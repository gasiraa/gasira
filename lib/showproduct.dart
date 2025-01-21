import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Method หลักทีRun
void main() {
  runApp(MyApp());
}

//Class stateless สั่งแสดงผลหนาจอ
class MyApp extends StatelessWidget {
  const MyApp({super.key});
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: showproduct(),
    );
  }
}

//Class stateful เรียกใช้การทํางานแบบโต้ตอบ
class showproduct extends StatefulWidget {
  @override
  State<showproduct> createState() => _MyHomePageState();
}
 
class _MyHomePageState extends State<showproduct> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref('products');
  List<Map<String, dynamic>> products = [];
 
  Future<void> fetchProducts() async {
    try {
      final snapshot = await dbRef.get();
      if (snapshot.exists) {
        List<Map<String, dynamic>> loadedProducts = [];
        snapshot.children.forEach((child) {
          Map<String, dynamic> product =
              Map<String, dynamic>.from(child.value as Map);
          product['key'] = child.key;
          loadedProducts.add(product);
        });
 
        // เรียงลำดับข้อมูลตามราคา จากมากไปน้อย
        loadedProducts.sort((a, b) => b['price'].compareTo(a['price']));
 
        setState(() {
          products = loadedProducts;
        });
        print("Products loaded: ${products.length} items");
      } else {
        print("No data found in Firebase");
      }
    } catch (e) {
      print("Error loading products: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาดในการโหลดข้อมูล: $e')),
      );
    }
  }
 
  @override
  void initState() {
    super.initState();
    fetchProducts();
  }
 
  String formatDate(String date) {
    final parsedDate = DateTime.parse(date);
    return DateFormat('dd/MM/yyyy').format(parsedDate);
  }
 
  void deleteProduct(String key, BuildContext context) {
    dbRef.child(key).remove().then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ลบสินค้าเรียบร้อย')),
      );
      fetchProducts(); // โหลดข้อมูลใหม่หลังจากการลบ
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    });
  }
 
  void showDeleteConfirmationDialog(String key, BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('ยืนยันการลบ'),
          content: Text('คุณแน่ใจว่าต้องการลบสินค้านี้ใช่หรือไม่?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text('ยกเลิก'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                deleteProduct(key, context);
              },
              child: Text('ลบ', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
 
  void showEditProductDialog(Map<String, dynamic> product) {
    TextEditingController nameController =
        TextEditingController(text: product['name']);
    TextEditingController descriptionController =
        TextEditingController(text: product['description']);
    TextEditingController categoryController =
      TextEditingController(text: product['category']);
     TextEditingController productionDateController =
        TextEditingController(text: product['productionDate']);
    TextEditingController priceController =
        TextEditingController(text: product['price'].toString());
    TextEditingController quantityController =
      TextEditingController(text: product['quantity'].toString());
   
 
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('แก้ไขสินค้า'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController, //ดึงข้อมูลชื่อเก่ามาแสดงผลจาก
                  decoration: InputDecoration(labelText: 'ชื่อสินค้า'),
                ),
                TextField(
                  controller:
                      descriptionController, //ดึงข้อมูลรายละเอียดเก่ามาแสดงผล
                  decoration: InputDecoration(labelText: 'รายละเอียด'),
                ),
                 TextField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'ประเภทสินค้า'),
              ),
              TextField(
                  controller: productionDateController,
                  decoration: const InputDecoration(labelText: 'วันที่ผลิต'),
                ),
                TextField(
                  controller: priceController, //ดึงข้อมูลราคาเก่ามาแสดงผล
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'ราคา'),
                ),
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'จำนวนสินค้า'),
              ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('ยกเลิก'),
            ),
            ElevatedButton(
              onPressed: () {
                dbRef.child(product['key']).update({
                  'name': nameController.text,
                  'description': descriptionController.text,
                  'category': categoryController.text,
                  'productionDate': productionDateController.text,
                  'price': int.parse(priceController.text),
                  'quantity': int.parse(quantityController.text),
                }).then((_) {
                  fetchProducts();
                  Navigator.of(dialogContext).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('แก้ไขข้อมูลสำเร็จ')),
                  );
                }).catchError((error) {
                  Navigator.of(dialogContext).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('เกิดข้อผิดพลาด: $error')),
                  );
                });
              },
              child: const Text('บันทึก'),
            ),
          ],
        );
      },
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แสดงผลสินค้า'),
      ),
      body: products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('รายละเอียด: ${product['description']}'),
                              Text('ราคา : ${product['price']} บาท'),
                              Text(
                                  'วันที่ผลิต: ${formatDate(product['productionDate'])}'),
                            ],
                          ),
                        ),
                        // ปรับให้ไอคอนอยู่ติดกันในแนวนอน
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                showEditProductDialog(product);
                              },
                              icon: const Icon(Icons.edit),
                              color: const Color.fromARGB(255, 0, 0, 0),
                              iconSize: 24,
                              tooltip: 'แก้ไขสินค้า',
                            ),
                            IconButton(
                              onPressed: () {
                                showDeleteConfirmationDialog(
                                    product['key'], context);
                              },
                              icon: const Icon(Icons.delete),
                              color: const Color.fromARGB(255, 207, 79, 211),
                              iconSize: 24,
                              tooltip: 'ลบสินค้า',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
import 'package:flutter/material.dart';
import 'showfiltertype.dart'; // Import หน้าที่เกี่ยวข้อง

class showproducttype extends StatelessWidget {
  // กำหนดรายการประเภทสินค้า
  final List<String> categories = ['ลิปสติก', 'บรัชออน', 'มาสคาร่า', 'รองพื้น'];
 
  // กำหนดไอคอนที่ตรงกับประเภทสินค้าแต่ละประเภท
  final List<IconData> categoryIcons = [
    Icons.mood, // Electronics
    Icons.brush, // Clothing
    Icons.visibility, // Food
    Icons.face, // Books
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ประเภทสินค้า'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 รายการต่อแถว
            crossAxisSpacing: 10.0, // ระยะห่างระหว่างคอลัมน์
            mainAxisSpacing: 10.0, // ระยะห่างระหว่างแถว
            childAspectRatio: 1 / 1.5, // กำหนดอัตราส่วน กว้าง : สูง
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // นำทางไปยังหน้า showfiltertype พร้อมส่งข้อมูล category
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        showfiltertype(category: categories[index]),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      categoryIcons[index], // ใช้ไอคอนจากรายการที่กำหนด
                      size: 40,
                      color: const Color.fromARGB(255, 212, 132, 228),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      categories[index], // ชื่อประเภทสินค้า
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
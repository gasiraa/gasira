import 'package:flutter/material.dart';
 
class ProductDetail extends StatelessWidget {
  final Map<String, dynamic> product;
 
  // รับข้อมูลสินค้าเมื่อกดจากหน้า showfiltertype
  const ProductDetail({Key? key, required this.product}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name'] ?? 'รายละเอียดสินค้า'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ชื่อสินค้า: ${product['name'] ?? 'ไม่มีชื่อสินค้า'}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'รายละเอียด: ${product['description'] ?? 'ไม่มีรายละเอียด'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'ราคา: ${product['price']} บาท',
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 171, 111, 212),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'จำนวน: ${product['quantity']} ชิ้น',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'addproduct.dart';
import 'showproductgrid.dart';
import 'showproducttype.dart';

//Method หลักทีRun
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAQTf4_sXZfqTVurub1x3--eiumN3A09IE",
            authDomain: "onlinefirebase-23319.firebaseapp.com",
            databaseURL:
                "https://onlinefirebase-23319-default-rtdb.firebaseio.com",
            projectId: "onlinefirebase-23319",
            storageBucket: "onlinefirebase-23319.firebasestorage.app",
            messagingSenderId: "976841905463",
            appId: "1:976841905463:web:46433b97aab398f43df6b2",
            measurementId: "G-C90FB4G2J6"));
  } else {
    await Firebase.initializeApp();
  }
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
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 207, 160, 245)),
        useMaterial3: true,
      ),
      home: Main(),
    );
  }
}

//Class stateful เรียกใช้การทํางานแบบโต้ตอบ
class Main extends StatefulWidget {
  @override
  State<Main> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Main> {
//ส่วนเขียน Code ภาษา dart เพื่อรับค่าจากหน้าจอมาคํานวณหรือมาทําบางอย่างและส่งค่ากลับไป
//ส่วนการออกแบบหน้าจอ
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Colors.white,
        title: Text('หน้าหลัก'),
      ),
      body: Stack(
        children: [
          //ภาพพื้นหลังที่ครอบคลุมทั้งหน้าจอ
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bg.png'), // Background image
                  fit: BoxFit.cover, //ทำให้ภาพครอบคลุมทั้งหน้าจอ
                ),
              ),
            ),
          ),
          //วางเนื้อหาหรือองค์ประกอบต่างๆ (เช่น ข้อความ รูปภาพ หรือปุ่ม)
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // จัดวางเนื้อหาทั้งหมด (เช่น ข้อความ รูปภาพ หรือปุ่ม) ให้อยู่ตรงกลางของพื้นที่
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //ใส่โลโก้
                  Image.asset(
                    'assets/logo.png', //ใส่โลโก้
                    width: 170, //ปรับขนาดตามความต้องการ
                    height: 170,
                  ),
                  SizedBox(height: 30), // ระยะห่างระหว่างข้อความและปุ่ม
 
                  // Buttons
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => addproduct()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      minimumSize: Size(250, 50), // ตั้งขนาดปุ่มให้คงที่
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'บันทึกข้อมูลสินค้า',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 16), // ว้นระยะระหว่างปุ่ม
 
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => showproductgrid()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      minimumSize: Size(250, 50), // กำหนดขนาดปุ่มให้คงที่
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'แสดงข้อมูลสินค้า',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 16), //  เว้นระยะระหว่างปุ่ม
 
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => showproducttype()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      minimumSize: Size(250, 50), // กำหนดขนาดคงที่สำหรับปุ่ม
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'ประเภทสินค้า',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
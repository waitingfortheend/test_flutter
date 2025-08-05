import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_diversition/generated/locales.g.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _numberController = TextEditingController();
  String _resultText = "";

  String checkPrimeAndExplain(int number) {
    if (number < 2) {
      return "$number ไม่ใช่จำนวนเฉพาะ เพราะจำนวนเฉพาะต้องมากกว่า 1.";
    }

    String explanation = "$number:\n";
    explanation +=
        "  - เริ่มตรวจสอบจาก 2 ถึงรากที่สองของ $number (${(number > 1 ? (number * number).toStringAsFixed(0) : '0')}**0.5 = ${number.toStringAsFixed(0)}).\n"; // แสดงรากที่สอง

    // ตรวจสอบตัวหาร
    bool foundDivisor = false;
    for (int i = 2; i * i <= number; i++) {
      if (number % i == 0) {
        explanation += "  - $number หารด้วย $i ลงตัว (เศษ 0).\n";
        explanation += "  ดังนั้น $number ไม่ใช่จำนวนเฉพาะ.";
        foundDivisor = true;
        break; // พบตัวหารแล้ว ออกจากลูป
      } else {
        explanation += "  - $number หารด้วย $i ไม่ลงตัว (เศษ ${number % i}).\n";
      }
    }

    if (!foundDivisor) {
      explanation += "  - ไม่พบตัวหารอื่นนอกจาก 1 และตัวมันเอง.\n";
      explanation += "  ดังนั้น $number เป็นจำนวนเฉพาะ.";
    }

    return explanation;
  }

  void _checkNumber() {
    int? number = int.tryParse(_numberController.text);
    if (number == null) {
      setState(() {
        _resultText = LocaleKeys.validate_please_enter_number.tr;
      });
      return;
    }

    setState(() {
      _resultText = checkPrimeAndExplain(number);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.prime_title.tr)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: LocaleKeys.enter_number.tr,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkNumber,
              child: Text(LocaleKeys.check_prime.tr),
            ),
            SizedBox(height: 20),
            Expanded(
              // ใช้ Expanded เพื่อให้ข้อความแสดงผลได้เต็มพื้นที่
              child: SingleChildScrollView(
                // ใช้ SingleChildScrollView เพื่อให้เลื่อนดูได้ถ้าข้อความยาว
                child: Text(_resultText, style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/run.dart';
import '../services/supabase_service.dart';

class AddRunUi extends StatefulWidget {
  const AddRunUi({super.key});

  @override
  State<AddRunUi> createState() => _AddRunUiState();
}

class _AddRunUiState extends State<AddRunUi> {
  // controller
  TextEditingController whereCtrl = TextEditingController();
  TextEditingController personCtrl = TextEditingController();
  TextEditingController distanceCtrl = TextEditingController();

  // save
  void saveRun() async {
    if (whereCtrl.text.isEmpty ||
        personCtrl.text.isEmpty ||
        distanceCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("กรุณากรอกข้อมูลให้ครบ"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Run run = Run(
      createdAt: DateTime.now().toIso8601String(),
      runWhere: whereCtrl.text,
      runPerson: personCtrl.text,
      runDistance: int.parse(distanceCtrl.text),
    );

    await SupabaseService().insertRun(run);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("บันทึกเรียบร้อย"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }

  // clear form
  void clearForm() {
    setState(() {
      whereCtrl.clear();
      personCtrl.clear();
      distanceCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("เพิ่มข้อมูลการวิ่ง"),
        backgroundColor: Colors.blue,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 40,
            bottom: 50,
            left: 40,
            right: 40,
          ),
          child: Column(
            children: [
              // 🔹 รูป
              Image.asset(
                'assets/images/running.png',
                width: 180,
                height: 180,
                fit: BoxFit.cover,
              ),

              const SizedBox(height: 20),

              // 🔹 วิ่งที่ไหน
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("วิ่งที่ไหน", style: TextStyle(fontSize: 18)),
              ),
              TextField(
                controller: whereCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: "เช่น สวนสาธารณะ",
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 ใครวิ่ง
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("ใครวิ่ง", style: TextStyle(fontSize: 18)),
              ),
              TextField(
                controller: personCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: "เช่น ตัวเอง / เพื่อน",
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 ระยะทาง
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("ระยะทาง (กม.)", style: TextStyle(fontSize: 18)),
              ),
              TextField(
                controller: distanceCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: "เช่น 5",
                ),
              ),

              const SizedBox(height: 30),

              // 🔹 ปุ่มบันทึก
              ElevatedButton(
                onPressed: saveRun,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    50,
                  ),
                ),
                child: const Text(
                  "บันทึก",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 10),

              // 🔹 ปุ่มยกเลิก
              ElevatedButton(
                onPressed: clearForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    50,
                  ),
                ),
                child: const Text(
                  "ยกเลิก",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/run.dart';
import '../services/supabase_service.dart';

class UpdateDelRunUi extends StatefulWidget {
  final Run run;

  const UpdateDelRunUi({super.key, required this.run});

  @override
  State<UpdateDelRunUi> createState() => _UpdateDelRunUiState();
}

class _UpdateDelRunUiState extends State<UpdateDelRunUi> {
  // controller
  late TextEditingController whereCtrl;
  late TextEditingController personCtrl;
  late TextEditingController distanceCtrl;

  final service = SupabaseService();

  @override
  void initState() {
    super.initState();

    whereCtrl = TextEditingController(text: widget.run.runWhere);
    personCtrl = TextEditingController(text: widget.run.runPerson);
    distanceCtrl =
        TextEditingController(text: widget.run.runDistance.toString());
  }

  // 🔹 UPDATE
  void updateRun() async {
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

    Run updated = Run(
      id: widget.run.id,
      createdAt: widget.run.createdAt,
      runWhere: whereCtrl.text,
      runPerson: personCtrl.text,
      runDistance: int.parse(distanceCtrl.text),
    );

    await service.updateRun(widget.run.id!, updated);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("แก้ไขเรียบร้อย"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }

  // 🔹 DELETE
  void deleteRun() async {
    await service.deleteRun(widget.run.id!);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("ลบเรียบร้อย"),
        backgroundColor: Colors.red,
      ),
    );

    Navigator.pop(context);
  }

  // 🔹 CLEAR
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
        title: const Text("แก้ไข / ลบข้อมูลการวิ่ง"),
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
                ),
              ),

              const SizedBox(height: 30),

              // 🔹 ปุ่มอัปเดต
              ElevatedButton(
                onPressed: updateRun,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    50,
                  ),
                ),
                child: const Text(
                  "บันทึกการแก้ไข",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 10),

              // 🔹 ปุ่มลบ
              ElevatedButton(
                onPressed: deleteRun,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    50,
                  ),
                ),
                child: const Text(
                  "ลบข้อมูล",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 10),

              // 🔹 ปุ่มยกเลิก (ล้างค่า)
              ElevatedButton(
                onPressed: clearForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    50,
                  ),
                ),
                child: const Text(
                  "ล้างค่า",
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

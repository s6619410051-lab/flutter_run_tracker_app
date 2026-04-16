import 'package:flutter/material.dart';
import '../models/run.dart';
import '../services/supabase_service.dart';
import 'add_run_ui.dart';
import 'update_del_run_ui.dart';

class ShowAllRunUi extends StatefulWidget {
  const ShowAllRunUi({super.key});

  @override
  State<ShowAllRunUi> createState() => _ShowAllRunUiState();
}

class _ShowAllRunUiState extends State<ShowAllRunUi> {
  List<Run> runs = [];
  final service = SupabaseService();

  // โหลดข้อมูล
  void loadAllRun() async {
    final data = await service.getAllRun();
    setState(() {
      runs = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadAllRun();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RUN TRACKER"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40),

            // 🔹 LOGO
            Image.asset(
              'assets/images/running.png',
              width: 180,
              height: 180,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 20),

            // 🔹 LIST
            Expanded(
              child: runs.isEmpty
                  ? const Center(child: Text("ยังไม่มีข้อมูล"))
                  : ListView.builder(
                      itemCount: runs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 5,
                          ),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      UpdateDelRunUi(run: runs[index]),
                                ),
                              ).then((_) => loadAllRun());
                            },

                            // 🔹 icon ซ้าย
                            leading: Image.asset(
                              'assets/images/run.png',
                              width: 40,
                            ),

                            // 🔹 icon ขวา
                            trailing: const Icon(
                              Icons.info,
                              color: Colors.blue,
                            ),

                            // 🔹 ข้อมูลหลัก
                            title: Text(
                              "วิ่งที่ ${runs[index].runWhere}",
                            ),

                            // 🔹 รายละเอียด
                            subtitle: Text(
                              "คน: ${runs[index].runPerson} | ระยะ: ${runs[index].runDistance} กม.",
                            ),

                            // 🔹 สีสลับ
                            tileColor: index % 2 == 0
                                ? Colors.blue[50]
                                : Colors.green[100],

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      // 🔹 ปุ่มเพิ่ม (เหมือนของเดิม)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddRunUi()),
          ).then((_) => loadAllRun());
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

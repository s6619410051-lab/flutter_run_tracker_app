import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/run.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  // 🔹 GET
  Future<List<Run>> getAllRun() async {
    final data = await supabase
        .from('run_tb')
        .select('*')
        .order('created_at', ascending: false);

    return data.map<Run>((e) => Run.fromJson(e)).toList();
  }

  // 🔹 INSERT
  Future insertRun(Run run) async {
    await supabase.from('run_tb').insert(run.toJson());
  }

  // 🔹 UPDATE
  Future updateRun(String id, Run run) async {
    await supabase.from('run_tb').update(run.toJson()).eq('id', id);
  }

  // 🔹 DELETE
  Future deleteRun(String id) async {
    await supabase.from('run_tb').delete().eq('id', id);
  }
}

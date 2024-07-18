import 'package:firebase_auth/firebase_auth.dart';
import 'package:galal/app_hierarchy/models/user_model.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/category_model.dart';

class HomeController extends GetxController {
  final supabase = Supabase.instance.client;
  late UserModel user;
  RxList<CategoryModel> categoryList = RxList<CategoryModel>([]);
  RxInt chosen = 0.obs;

  Future fetchCategories() async {
    List _x = await supabase.from('categories').select();
    for (var value in _x) {
      categoryList.add(CategoryModel.fromJson(value));
    }
  }

  Future mountUser() async {
    String id = FirebaseAuth.instance.currentUser!.uid;
    List _x = await supabase.from('users').select().eq('id', id);
    user = UserModel.fromJson(_x.first);
  }

  @override
  void onInit() async {
    await mountUser();
    await fetchCategories();
    super.onInit();
  }
}

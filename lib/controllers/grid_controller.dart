import 'package:flutter/material.dart';
import 'package:get/get.dart';
class GridController extends GetxController{
   var isPress=true.obs;
  void pressController() {
    isPress.value = !isPress.value;
  }
}
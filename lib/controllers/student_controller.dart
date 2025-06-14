import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_management_getx/model/student_model.dart';

class StudentController extends GetxController {
  var isGridView = true.obs;
  var isLoading = false.obs;
  var students = <Student>[].obs;
  var searchQuery = ''.obs;
  var imageFile = Rx<File?>(null);

  final nameController = TextEditingController();
  final admissionController = TextEditingController();
  final courseController = TextEditingController();
  final contactController = TextEditingController();

  List<Student> get filteredStudents {
    return students.where((student) {
      return student.name.toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          ) ||
          student.admissionNumber.toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          );
    }).toList();
  }

  void toggleView() {
    isGridView.value = !isGridView.value;
  }

  void clearImage() {
    imageFile.value = null;
  }
}

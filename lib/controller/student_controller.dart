import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:student_management_getx/db/db_helper.dart';
import 'package:student_management_getx/model/student_model.dart';

class StudentController extends GetxController {
  var students = <Student>[].obs;
  var isGridView = true.obs;
  var imageFile = Rx<File?>(null);
  var isLoading = false.obs;
  var searchQuery = ''.obs;
  // var student1 = Rx<Student?>(null);

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

  void clearControllers() {
    nameController.clear();
    admissionController.clear();
    courseController.clear();
    contactController.clear();
    clearImage();
  }

  void toggleView() {
    isGridView.value = !isGridView.value;
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  void clearImage() {
    imageFile.value = null;
  }

  Future<void> loadStudents() async {
    isLoading.value = true;

    try {
      students.value = await getAllStudents();
    } catch (e) {
      throw e;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addStudent(Student student) async {
    isLoading.value = true;

    try {
      String? imagePath;
      if (imageFile.value != null) {
        final directory = await getApplicationDocumentsDirectory();
        final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
        final savedImage = await imageFile.value!.copy(
          '${directory.path}/$fileName',
        );
        imagePath = savedImage.path;
      }

      final newStudent = Student(
        name: student.name,
        admissionNumber: student.admissionNumber,
        course: student.course,
        contact: student.contact,
        imagePath: imagePath,
      );

      await insertStudent(newStudent);
      await loadStudents();
    } catch (e) {
      throw e;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteStudent(int id) async {
    isLoading.value = true;

    try {
      await deleteStudent1(id);
      await loadStudents();
    } catch (e) {
      throw e;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        imageFile.value = File(pickedFile.path);
      }
    } catch (e) {
      throw e;
    }
  }
}

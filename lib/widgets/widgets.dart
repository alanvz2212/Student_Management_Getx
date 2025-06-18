import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_management_getx/controller/student_controller.dart';
import 'package:student_management_getx/model/student_model.dart';
import 'package:student_management_getx/screens/edit_student.dart';
import 'package:student_management_getx/screens/profile_screen.dart';

Widget buildTextFormField({
  required TextEditingController controller,
  required String label,
  required String validationMessage,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return validationMessage;
      }
      return null;
    },
  );
}

Widget buildStudentListTile(
  BuildContext context,
  Student student,
  StudentController controller,
) {
  return InkWell(
    onTap: () {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (student.id == null) {
          Get.defaultDialog(title: 'Error', middleText: 'No student ID found.');
        } else {
          Get.to(() => ProfileScreen(studentId: student.id!));
        }
        ListTile(
          leading: student.imagePath != null
              ? CircleAvatar(
                  backgroundImage: FileImage(File(student.imagePath!)),
                )
              : const CircleAvatar(child: Icon(Icons.person)),
          title: Text(student.name),
          subtitle: Text('${student.admissionNumber} - ${student.course}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Get.to(() => EditStudent(student: student));
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  showDeleteDialog(context, student, controller);
                },
              ),
            ],
          ),
        );
      });
    },
  );
}

appbarWidget(String name) {
  return AppBar(title: Text(name), backgroundColor: Colors.blue[100]);
}

void showDeleteDialog(
  BuildContext context,
  Student student,
  StudentController controller,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Student'),
        content: Text('Are you sure you want to delete ${student.name}?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () {
              controller.deleteStudent(student.id!);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

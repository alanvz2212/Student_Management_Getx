import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_management_getx/controllers/student_controller.dart';
import 'package:student_management_getx/model/student_model.dart';
import 'package:student_management_getx/screens/profile_screen.dart';
Widget buildStudentCard(
    BuildContext context, Student student, StudentController controller) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        if (student.id == null) {
          return const Center(child: Text('No student ID found.'));
        }

        return ProfileScreen(studentId: student.id!);
      }));
    },
    child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (student.imagePath != null)
            Expanded(
              child: Image.file(
                File(student.imagePath!),
                width: double.infinity,
                fit: BoxFit.fitHeight,
              ),
            )
          else
            Expanded(
              child: Container(
                color: Colors.grey[300],
                child: const Icon(Icons.person, size: 50),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(student.admissionNumber),
                Text(student.course),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // IconButton(
                    //   icon: const Icon(Icons.edit),
                    //   onPressed: () {
                    //     Get.to(() => EditStudentScreen(student: student));
                    //   },
                    // ),
                    // IconButton(
                    //   icon: const Icon(Icons.delete),
                    //   onPressed: () {
                    //     showDeleteDialog(context, student, controller);
                    //   },
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

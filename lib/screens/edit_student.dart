import 'package:flutter/material.dart';
import 'package:student_management_getx/model/student_model.dart';

class EditStudent extends StatefulWidget {
  final Student student;
  const EditStudent({super.key, required this.student});

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

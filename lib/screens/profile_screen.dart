import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final int studentId;
  const ProfileScreen({super.key, required this.studentId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

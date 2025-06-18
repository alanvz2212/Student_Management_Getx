import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_management_getx/controller/student_controller.dart';
import 'package:student_management_getx/screens/add_student.dart';
import 'package:student_management_getx/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  final StudentController studentController = Get.put(StudentController());

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Management'),
        actions: [
          Obx(() {
            return IconButton(
              icon: Icon(
                widget.studentController.isGridView.value
                    ? Icons.list
                    : Icons.grid_view,
              ),
              onPressed: widget.studentController.toggleView,
            );
          }),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: widget.studentController.setSearchQuery,
              decoration: const InputDecoration(
                labelText: 'Search Students',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (widget.studentController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              final students = widget.studentController.filteredStudents;
              if (students.isEmpty) {
                return const Center(child: Text('No Students Found'));
              }
              return widget.studentController.isGridView.value
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                      itemBuilder: (context, index) {
                        final student = students[index];
                        return buildStudentListTile(
                          context,
                          student,
                          widget.studentController,
                        );
                      },
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        final student = students[index];
                        return buildStudentListTile(
                          context,
                          student,
                          widget.studentController,
                        );
                      },
                    );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.studentController.clearImage();
          widget.studentController.clearControllers();
          Get.to(() => AddStudentScreen())?.then((_) {
            widget.studentController.loadStudents();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:student_management_getx/controllers/student_controller.dart';
import 'package:student_management_getx/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Management'),
        actions: [
          Obx(() {
            return IconButton(
              onPressed: studentController.toggleView,
              // ? studentController.setListView
              // : studentController.setGridView,
              icon: Icon(
                studentController.isGridView.value
                    ? Icons.grid_view
                    : Icons.list,
              ),
            );
          }),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Students',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (studentController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              final students = studentController.filteredStudents;
              if (students.isEmpty) {
                return const Center(child: Text('No Students Found'));
              }
              return studentController.isGridView.value
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];
                        return buildStudentCard(
                          context,
                          student,
                          studentController,
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                studentController.imageFile.value != null
                                ? FileImage(studentController.imageFile.value!)
                                : AssetImage('assets/images/default_avatar.png')
                                      as ImageProvider,
                          ),
                          title: Text(student.name),
                          subtitle: Text(student.admissionNumber),
                        );
                      },
                    );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          studentController.clearImage();
          // Navigate to the add student screen
          Get.toNamed('/add-student');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

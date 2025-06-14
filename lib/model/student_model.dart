class Student {
  final int? id;
  final String name;
  final String admissionNumber;
  final String course;
  final String contact;
  final String? imagePath;
  Student({
    this.id,
    required this.name,
    required this.admissionNumber,
    required this.course,
    required this.contact,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'admissionNumber': admissionNumber,
      'course': course,
      'contact': contact,
      'imagePath': imagePath,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      admissionNumber: map['admissionNumber'] as String,
      course: map['course'] as String,
      contact: map['contact'] as String,
      imagePath: map['imagePath'] as String?,
    );
  }
}

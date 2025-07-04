import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_management_getx/model/student_model.dart';

Database? _database;

Future<Database> get database async {
  if (_database != null) return _database!;
  _database = await initDB('students.db');
  return _database!;
}

Future<Database> initDB(String filePath) async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, filePath);

  return await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE students(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          admissionNumber TEXT NOT NULL,
          course TEXT NOT NULL,
          contact TEXT NOT NULL,
          imagePath TEXT
        )
      ''');
    },
  );
}

Future<int> insertStudent(Student student) async {
  final db = await database;
  return await db.insert('students', student.toMap());
}

Future<List<Student>> getAllStudents() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query('students');
  return List.generate(maps.length, (i) => Student.fromMap(maps[i]));
}

Future<int> deleteStudent1(int id) async {
  final db = await database;
  return await db.delete('students', where: 'id = ?', whereArgs: [id]);
}

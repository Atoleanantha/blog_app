import 'package:blog_app/models/BlogModel.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const int _version = 1;
  static const String _dbName = "Blog.db";

  static Future<Database> _getDB() async {
    String path = await _join(await getDatabasesPath(), _dbName);
    Database db = await openDatabase(path,
        version: _version,
        onCreate: (db, version) async {
          await db.execute(
              'CREATE TABLE Blog (id TEXT PRIMARY KEY, title TEXT NOT NULL, image_url TEXT NOT NULL)');
        });
    print("db is open"+db.isOpen.toString());
    return db;
  }

  static String _join(String s, String dbName) {
    return s + dbName;
  }

  static Future<int> addBlog(Blogs blog) async {
    Database db = await _getDB();
    return await db.insert("Blog", blog.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteBlog(Blogs blog) async {
    Database db = await _getDB();
    return await db.delete("Blog", where: 'id=?', whereArgs: [blog.id]);
  }

  static Future<List<Blogs>?> getAllBlogs() async {
    Database db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("Blog");

    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => Blogs.fromJson(maps[index]));
  }
}

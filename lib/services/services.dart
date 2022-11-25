import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:millennim_task/model/model_file.dart';
class ApiService {
  final endPointUrl = "https://saurav.tech/NewsAPI/everything/cnn.json";
  final client = http.Client();
Future<List<Article>> getArticle() async {
    
   
final uri = (Uri.parse(endPointUrl));
    final response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> body = json['articles'];
    List<Article> articles = body.map((dynamic item) => Article.fromJson(item)).toList();
    return articles;
  }
}
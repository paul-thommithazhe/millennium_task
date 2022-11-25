import 'dart:convert';
import 'dart:developer';

import 'package:carousel_images/carousel_images.dart';
import 'package:flutter/material.dart';
import 'package:millennim_task/model/model_file.dart';
import 'package:millennim_task/services/services.dart';
import 'package:millennim_task/views/detailed_page.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

List<String> listImages = [];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // Future loadData() async {
  //   var url = Uri.parse('https://saurav.tech/NewsAPI/everything/cnn.json');
  //   final response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     log('working fine');
  //     var json = jsonDecode(response.body);
  //     // print(json);
  //     List<dynamic> data = json['articles'];
  //     for (var i = 0; i < data.length; i++) {
  //       print(data[0]['author']);
  //     }

  //     return Article.fromJson(data[0]!);
  //   } else {
  //     log('status code error');
  //   }
  // }

  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // appBar: _appBar(),
      body: FutureBuilder(
        future: apiService.getArticle(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<Article> articles = snapshot.data;
            print(articles);

            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Latest News',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Text(
                                  'See All',
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(width: 5),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 18,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                          height: 250,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: articles.length,
                              itemBuilder: (context, index) {
                                var dddate =  DateTime.parse(articles[index].publishedAt!);
                             var date = DateFormat.yMMMMEEEEd().format(dddate);
                                listImages.add(articles[index].urlToImage!);

                                return Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailedPage(
                                              newsDate:
                                                  date,
                                              newsHeadLine:
                                                  articles[index].title!,
                                              newsDescr2:
                                                  articles[index].description!,
                                              newsDescr:
                                                  articles[index].content!,
                                              newsImage:
                                                  articles[index].urlToImage!,
                                              author: articles[index].author == null ?  'No Author' : 'author' ,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.network(
                                                articles[index].urlToImage!,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            height: 250,
                                            width: 300,
                                          ),
                                          SizedBox(
                                            width: 300,
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: 20),
                                                    Text(
                                                      'by ${articles[index].author ?? "No Author"}',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      articles[index].title!,
                                                      style: TextStyle(
                                                          fontSize: 19,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 30),
                                                    Text(
                                                      articles[index]
                                                          .description!,
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 2,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                  ],
                                );
                              })),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              NewsTopicContainer(
                                title: 'Healthy',
                                unSelectedColor: Colors.red,
                                selectedTextColor: Colors.white,
                              ),
                              const SizedBox(width: 10),
                              NewsTopicContainer(
                                title: 'Technology',
                              ),
                              const SizedBox(width: 10),
                              NewsTopicContainer(title: 'Finance'),
                              const SizedBox(width: 10),
                              NewsTopicContainer(title: 'Arts'),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 800,
                        child: ListView.builder(
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            if(articles[index].author == null){
                              articles[index].author = 'No Author';
                            }
                            var dddate =  DateTime.parse(articles[index].publishedAt!);
                             var date = DateFormat.yMMMMEEEEd().format(dddate);
                            print(date);
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailedPage(
                                          newsDate:
                                              date,
                                          newsHeadLine: articles[index].title!,
                                          newsDescr2:
                                              articles[index].description!,
                                          newsDescr: articles[index].content!,
                                          newsImage:
                                              articles[index].urlToImage!,
                                          author: articles[index].author ?? 'No Author' ,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          articles[index].urlToImage! ,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  'by ${articles[index].title!}',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                                SizedBox(height: 78),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: 100,
                                                      child: Text(
                                                        
                                                        articles[index].author!,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                       
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    Text(
                                                      date ,
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      
                                                      overflow: TextOverflow.ellipsis,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
               
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class NewsTopicContainer extends StatelessWidget {
  NewsTopicContainer({
    Key? key,
    required this.title,
    this.unSelectedColor,
    this.selectedTextColor,
  }) : super(key: key);

  String title;
  Color? unSelectedColor = Colors.white;
  Color? selectedTextColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 170, 166, 166)),
        borderRadius: BorderRadius.circular(20),
        color: unSelectedColor,
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 13, color: selectedTextColor),
        ),
      ),
    );
  }
}

PreferredSize _appBar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(100),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 40, 10, 0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 227, 221, 221)),
                borderRadius: BorderRadius.circular(19),
                color: Colors.white),
            width: 310,
            height: 30,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.1, horizontal: 12),
              child: TextFormField(
                style: TextStyle(fontSize: 12),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Dogcoin to the moon...'),
              ),
            ),
          ),
          SizedBox(width: 9),
          const CircleAvatar(
            radius: 17,
            backgroundColor: Color.fromARGB(255, 235, 87, 38),
            child: Icon(Icons.notifications, color: Colors.white),
          ),
        ],
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DetailedPage extends StatelessWidget {
  DetailedPage({
    super.key,
    required this.newsDate,
    required this.newsHeadLine,
    required this.newsDescr,
    required this.newsDescr2,
    required this.newsImage,
    required this.author,
  });

  String newsDate;

  String newsHeadLine;
  String author;
  String newsDescr;
  String newsDescr2;

  String newsImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.red,
            height: 400,
            child: Image.network(
              newsImage,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 100, horizontal: 5),
              child: Column(
                children: [
                  Text(
                    newsDescr2,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(newsDescr,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero)),
              height: 500,
            ),
          ),
          Align(
            alignment: Alignment(0.7, -0.3),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(newsDate),
                    Text(
                      '$newsHeadLine',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text('Published by ${author}')
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey.withOpacity(0.9)),
                height: 130,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey),
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                width: 40,
                height: 45,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {},
        child: Icon(
          Icons.favorite,
          color: Colors.white,
        ),
      ),
    );
  }
}

_appBar() {
  return PreferredSize(
      child: Container(
        width: 50,
        color: Colors.grey,
      ),
      preferredSize: Size(20, 50));
}

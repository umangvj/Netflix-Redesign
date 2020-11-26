import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflixredesign/models/movie_model.dart';
import 'package:netflixredesign/widgets/content_scroll.dart';

import 'movie_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8);
  }

  _movieSelector(int index) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieScreen(movie: movies[index]),
        ),
      ),
      child: Center(
        child: SizedBox(
          height: 270,
          width: 400,
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0.0, 4.0),
                        blurRadius: 10.0,
                      )
                    ],
                  ),
                  child: Center(
                    child: Hero(
                      tag: movies[index].imageUrl,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image(
                          image: AssetImage(movies[index].imageUrl),
                          height: 220.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 30.0,
                bottom: 40.0,
                child: Container(
                  width: 250,
                  child: Text(
                    movies[index].title.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Image(
            image: AssetImage('images/netflix_logo.png'),
            width: 150,
            height: 150,
          ),
        ),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          padding: EdgeInsets.only(left: 10.0),
          color: Colors.black,
          iconSize: 30.0,
          onPressed: () => print('Menu'),
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 10.0),
            icon: Icon(Icons.search),
            color: Colors.black,
            iconSize: 30.0,
            onPressed: () => print('Search'),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 280,
            width: double.infinity,
            child: PageView.builder(
              controller: _pageController,
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                return _movieSelector(index);
              },
            ),
          ),
          Container(
            height: 90,
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: labels.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 150,
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFD45253),
                        Color(0xFF9E1F28),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0,
                        color: Color(0xFF9E1F28),
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      labels[index],
                      style: TextStyle(
                        letterSpacing: 1.8,
                        color: Colors.white,
                        fontSize: 17.6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 15.0),
          ContentScroll(
            images: myList,
            imageHeight: 250.0,
            imageWidth: 150.0,
            title: 'My List',
          ),
          SizedBox(height: 13.0),
          ContentScroll(
            images: popular,
            imageHeight: 250.0,
            imageWidth: 150.0,
            title: 'Popular',
          ),
        ],
      ),
    );
  }
}

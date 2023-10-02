import 'package:adaptive_theme/adaptive_theme.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AddPostScreen.dart';
import 'FavoriteBlogsScreen.dart';
import 'Home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int screenIndex=0;
  final screens=[
    const Home(),
    const AddBlogScreen(),
    const FavoriteBlogsScreen(),
  ];
  final titles=[
    "Blogs",
    "Post Blog",
    "Favorite Blogs"
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        drawer: drawer(),
        bottomNavigationBar: bottomNavigationBar(),
        appBar: AppBar(
          title: Text(titles[screenIndex]),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {

                    AdaptiveTheme.of(context).toggleThemeMode();
                  });
                },
                icon: const Icon(
                  Icons.dark_mode_sharp,
                  color: Colors.white,
                )),
          ],
        ),
        body: screens[screenIndex]);
  }

  Widget bottomNavigationBar() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color:!AdaptiveTheme.of(context).isDefault?Theme.of(context).secondaryHeaderColor:Theme.of(context).primaryColor,
        borderRadius:const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                screenIndex = 0;
              });
            },
            icon: screenIndex == 0
                ? const Icon(
              Icons.home_filled,
              color: Colors.white,
              size: 35,
            )
                : const Icon(
              Icons.home_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                screenIndex = 1;
              });
            },
            icon: screenIndex == 1
                ? const Icon(
              Icons.add_box,
              color: Colors.white,
              size: 35,
            )
                : const Icon(
              Icons.add_box_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                screenIndex = 2;
              });
            },
            icon: screenIndex == 2
                ? const Icon(
              Icons.favorite,
              color: Colors.white,
              size: 35,
            )
                : const Icon(
              Icons.favorite_outline,
              color: Colors.white,
              size: 35,
            ),
          ),

        ],
      ),
    );

  }

//sidedrawer
  Widget drawer() {
    return Drawer(
      semanticLabel: "Profile",
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 5,
            child: DrawerHeader(
              decoration:const BoxDecoration(
                color: Colors.teal,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Anantha Atole",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "xyz@gmail.com",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text("+91 9XXXXXXXXX",
                          style: TextStyle(fontSize: 15, color: Colors.black)),
                    ],
                  )
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              // Update the state of the app.
              setState((){
                screenIndex=0;
              });
              Navigator.pop(context);
            },
          ),
          const Divider(
            thickness: 2,
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorites'),
            onTap: () {
              setState((){
                screenIndex=2;
              });
              Navigator.pop(context);

            },
          ),
          const Divider(
            thickness: 2,
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Contact'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          const Divider(
            thickness: 2,
          ),
          ListTile(
            title: const Text('Share App'),
            leading: const Icon(Icons.share),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          const Divider(
            thickness: 2,
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About Us'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          const Divider(
            thickness: 2,
          ),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.settings),
            title: Text("Settings"),
          ),
        ],
      ),
    );
  }


}

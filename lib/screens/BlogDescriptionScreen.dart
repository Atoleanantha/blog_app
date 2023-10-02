import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../APIHadling/service.dart';
import '../models/BlogModel.dart';
import '../models/favoritesBlogs.dart';
import '../models/favoritesBlogs.dart';
import '../models/favoritesBlogs.dart';

class BlogDescriptionScreen extends StatefulWidget {
  Blogs blog;
  FavoritesBlogs favoritesBlogs;
  BlogDescriptionScreen({super.key, required this.blog,required this.favoritesBlogs});

  @override
  State<BlogDescriptionScreen> createState() => _BlogDescriptionScreenState();
}

class _BlogDescriptionScreenState extends State<BlogDescriptionScreen> {
  bool isConnected=isDeviceConnectedToInternet();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.blog.title.toString(),
            style:const TextStyle(fontSize: 18),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.5,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),

                  // borderRadius: BorderRadius.circular(20),
                  image:
                  isConnected?
                  DecorationImage(
                      fit: BoxFit.fill,

                      image: NetworkImage(widget.blog.imageUrl.toString()))
                      :const DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/img.png")),

                ),
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children:  [
                              InkWell(
                                onTap: (){
                                  setState(() {
                                      widget.favoritesBlogs.addFavorite(widget.blog);
                                    // print(widget.FavoritesBlogs().favoriteBlog.contains(widget.blog));
                                  });
                                },
                                child: Icon(
                                  widget.favoritesBlogs.isFavorite(widget.blog)?Icons.favorite:Icons.favorite_outline,
                                  color: widget.favoritesBlogs.isFavorite(widget.blog)? Colors.red:Colors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              InkWell(
                                onTap: (){},
                                child:const Icon(
                                  Icons.share,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.blog.title.toString().toUpperCase(),
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              const Divider(
                thickness: 3,
                color: Colors.black,
              ),
              const Padding(
                padding:  EdgeInsets.only(left: 10.0,right: 10,bottom: 10),
                child: Text(
                    "     Following the announcement of Google+ API deprecation scheduled for March 2019, a number of changes will be made to Blogger’s Google+ integration on 4 February 2019. *Google+ widgets:* Support for the “+1 Button”, “Google+ Followers” and “Google+ Badge” widgets in Layout will no longer be available. All instances of these widgets will be removed from all blogs. *+1 buttons:* The +1/G+ buttons and Google+ share links below blog posts and in the navigation bar will be removed. Please note that if you have a custom template that includes Google+ features, you may need to update Following the announcement of Google+ API deprecation scheduled for March 2019, a number of changes will be made to Blogger’s Google+ integration on 4 February 2019. *Google+ widgets:* Support for the “+1 Button”, “Google+ Followers” and “Google+ Badge” widgets in Layout will no longer be available. All instances of these widgets will be removed from all blogs. *+1 buttons:* The +1/G+ buttons and Google+ share links below blog posts and in the navigation bar will be removed. Please note that if you have a custom template that includes Google+ features, you may need to update",
                    textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
        ));
  }
}

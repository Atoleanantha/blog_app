import 'package:blog_app/models/favoritesBlogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../APIHadling/service.dart';
import '../models/BlogModel.dart';

import 'BlogDescriptionScreen.dart';


class FavoriteBlogsScreen extends StatefulWidget {
  const FavoriteBlogsScreen({super.key});

  @override
  State<FavoriteBlogsScreen> createState() => _FavoriteBlogsScreenState();
}

class _FavoriteBlogsScreenState extends State<FavoriteBlogsScreen> {
  bool isConnected=isDeviceConnectedToInternet();
  @override
  Widget build(BuildContext context) {
    if(FavoritesBlogs.favoriteBlog.isEmpty){
      return Center(child: Text("No favorite blogs",style: Theme.of(context).textTheme.displayMedium,),);
    }
    return ListView.builder(
      itemCount: FavoritesBlogs.favoriteBlog.length,
        itemBuilder: (context,index){
          return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BlogDescriptionScreen(blog: FavoritesBlogs.favoriteBlog[index],favoritesBlogs: FavoritesBlogs(),)));
                setState(() {

                });

              },
              child: showBlogPostModel(context,FavoritesBlogs.favoriteBlog[index],FavoritesBlogs(),isConnected));
    });
  }
  Widget showBlogPostModel(BuildContext context,Blogs blog,FavoritesBlogs favoritesBlogs,bool isConnected) {
    double height = MediaQuery.of(context).size.height / 9;
    double width = MediaQuery.of(context).size.width / 3;



    return Container(
      height: height,
      margin: const EdgeInsets.only(top: 2,bottom: 2),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            height: height,
            constraints:  BoxConstraints(minWidth: 80, maxWidth: width),
            child:isConnected? Card(
              child:Image.network(blog.imageUrl.toString())) :Card(
              child: Image.asset("assets/img.png"),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0,bottom: 2),
            child: SizedBox(
              width: width+(width/1.5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blog.title.toString(),
                    maxLines: 2,
                    overflow:TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const Text(
                    "Description",
                    style: TextStyle(color: Colors.black45,fontSize: 13),
                  ),
                  const SizedBox(height: 2,),
                  const Expanded(child: SizedBox()),
                  const Text("10/10/2023 12:00 AM ",style: TextStyle(fontSize: 8),)
                ],
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: SizedBox(
              width: 15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        favoritesBlogs.addFavorite(blog);
                      });


                    },
                    child: Icon(
                      favoritesBlogs.isFavorite(blog)?Icons.favorite:Icons.favorite_outline,
                      color: favoritesBlogs.isFavorite(blog)? Colors.red:Colors.black,
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
            ),
          ),
        ],
      ),
    );
  }

}

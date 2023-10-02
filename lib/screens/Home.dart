
import 'package:blog_app/bloc/BlogBloc.dart';
import 'package:blog_app/models/favoritesBlogs.dart';
import 'package:blog_app/screens/BlogDescriptionScreen.dart';
import 'package:blog_app/sqflite/DBHelper.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../APIHadling/service.dart';
import '../bloc/BlocStates.dart';
import '../models/BlogModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Blogs> blogs;
  FavoritesBlogs favoritesBlogs=FavoritesBlogs();
  late List<Blogs>? blogsOffline=[];
  bool isConnected=isDeviceConnectedToInternet();

  Future<void> loadBlogs() async {
    final loadedBlogs = await DBHelper.getAllBlogs();
    setState(() {
      blogsOffline = loadedBlogs;
    });
  }

  @override
  void initState() {
    super.initState();
    loadBlogs();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<BlogBloc, BlocState>(
          listener: (context, state) async {
            setState(() {
              isConnected=isDeviceConnectedToInternet();
            });

            SnackBar snackBar1 ;

              isConnected?snackBar1 = const SnackBar(
                content: Text("Online"),
                backgroundColor: Colors.green,
              ):
               snackBar1 = const SnackBar(
                content: Text("Internet not connected!"),
                backgroundColor: Colors.grey,
              );
            if (state is ErrorState) {
              SnackBar snackBar = SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }else{
              ScaffoldMessenger.of(context).showSnackBar(snackBar1);
            }

          },
          builder: (context, state) {
            if(isConnected) {
              if (state is LoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              // if (state is OfflineState) {
              //   //   cache data
              //   blogs = state.offlineBlogs;
              //   return buildBlogList(blogs);
              // }

              if (state is LoadedState) {
                blogs = state.blogs;
                // printData();
                return buildBlogList(blogs);
              }

            }
            else if(blogsOffline!.isNotEmpty) {
              return buildBlogList(blogsOffline!);

            }
            else if(state is ErrorState) {
              return const Center(
                child: Text("Something went wrong!"),
              );
            }
            return buildBlogList(blogsOffline!);
          },
        ));
  }
  Widget buildBlogList(List<Blogs>blogs){
    return ListView.builder(
        itemCount: blogs.length,

        itemBuilder: (context,index){
          //add blog in local storage
          if(index<30){
            DBHelper.addBlog(blogs[index]);

           DBHelper.getAllBlogs().toString();
          }

          return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BlogDescriptionScreen(blog: blogs[index],favoritesBlogs: favoritesBlogs,)));
              },
              child: showBlogPostModel(blogs[index]));

        });
  }

  Widget showBlogPostModel(Blogs blog) {
    double height = MediaQuery.of(context).size.height / 9;
    double width = MediaQuery.of(context).size.width / 3;
    return Container(
      height: height,
      margin:const EdgeInsets.only(top: 2,bottom: 2),
      constraints:const BoxConstraints(minHeight: 100),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            height: height,
            // width:150,
            // color: Colors.white,
            constraints:  BoxConstraints(minWidth: 80, maxWidth: width),
            child: Card(
              child: isConnected?Image.network(blog.imageUrl.toString()):Image.asset("assets/img.png"),
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
                    // softWrap: t,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const Text(
                    "Description",
                    style: TextStyle(color: Colors.black45,fontSize: 15,overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(height: 2,),
                  const Expanded(child: SizedBox()),
                  const Text("10/10/2023 12:00 AM ",style: TextStyle(fontSize: 8),)
                ],
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          SizedBox(
            width: 30,
            child: Padding(
              padding: const EdgeInsets.only(right: 5.0),
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


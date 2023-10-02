import 'package:blog_app/models/favoritesBlogs.dart';
import 'package:flutter/material.dart';
import '../APIHadling/service.dart';
import '../models/BlogModel.dart';

Widget showBlogPostModel(BuildContext context,Blogs blog,FavoritesBlogs favoritesBlogs) {
  double height = MediaQuery.of(context).size.height / 9;
  double width = MediaQuery.of(context).size.width / 3;
  bool isConnected=isDeviceConnectedToInternet();


  return Container(
    height: height,
    margin: const EdgeInsets.only(top: 2,bottom: 2),
    color: Colors.white,
    child: Row(
      children: [
        Container(
          height: height,
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
        Expanded(child: SizedBox()),
        Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: SizedBox(
            width: 30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                      favoritesBlogs.addFavorite(blog);

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

// Widget ShowBlogPostModel(BuildContext context) {
//   double height= MediaQuery.of(context).size.height/4.4;
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 10.0),
//     child: Container(
//       width: MediaQuery.of(context).size.width,
//         height:height,
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.white),
//           // borderRadius: BorderRadius.circular(20),
//           image: const DecorationImage(
//               image: NetworkImage(
//                   "https://cdn.subspace.money/whatsub_blogs/dex-ezekiel-IxDPZ-AHfoI-unsplash1.jpg")),
//         ),
//         child: Stack(
//
//           children: [
//             Positioned(
//                 top: 0,
//                 right: 0,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child:Column(
//                     children:const [
//                       Icon(Icons.heart_broken,color: Colors.white,),
//                       SizedBox(height: 5,),
//                       Icon(Icons.share,color: Colors.white,),
//                     ],
//                   ),
//                 )),
//             Positioned(
//               bottom: 0,
//                 left: 0,
//                 right: 0,
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                     height: height/3,
//                     color: Colors.black38,
//                     child: Column(
//                       children: [
//                         Text("Hello",style:Theme.of(context).textTheme.headline2,textAlign: TextAlign.center,),
//                         Text("hrl djsf jfbd dfjhvd dfjvhfb",style: Theme.of(context).textTheme.bodyText1,)
//                       ],
//                     )),)
//           ],
//         ),
//   ));
// }

import 'BlogModel.dart';

class FavoritesBlogs{
  static List<Blogs>favoriteBlog=[];
  void addFavorite(Blogs blog){
    if(!favoriteBlog.contains(blog)){
      favoriteBlog.add(blog);
    }else{

      favoriteBlog.remove(blog);
    }
  }
  bool isFavorite(Blogs blog){
    return favoriteBlog.contains(blog);
  }
}
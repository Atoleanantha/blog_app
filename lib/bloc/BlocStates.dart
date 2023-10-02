import '../models/BlogModel.dart';

abstract class BlocState{}

class OfflineState extends BlocState{
  List<Blogs>offlineBlogs;
  OfflineState({required this.offlineBlogs});
}
class LoadingState extends BlocState{
  
}
class LoadedState extends BlocState{
  List<Blogs>blogs;
  LoadedState({required this.blogs});
}
class ErrorState extends BlocState{
  final String error;
  ErrorState({required this.error});
}
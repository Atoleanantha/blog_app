
import 'package:blog_app/APIHadling/service.dart';
import 'package:blog_app/bloc/BlocStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../APIHadling/API.dart';

import '../models/BlogModel.dart';

class BlogBloc extends Cubit<BlocState>{
  BlogBloc():super(LoadingState()){
    fetchBlogs();
  }
  API api=API();

  void fetchBlogs()async {

      try {
         List<Blogs>? blogs;
        blogs = await api.getBlogs();
        emit(LoadedState(blogs: blogs));
      } catch (error) {
        if(isDeviceConnectedToInternet()){
          emit(ErrorState(error: "Internet not connected!"));
        }
        else{
          emit(ErrorState(error: error.toString()));
        }

      }
  }

}
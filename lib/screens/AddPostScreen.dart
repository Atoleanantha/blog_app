import 'dart:io';

import 'package:blog_app/sqflite/DBHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/BlogModel.dart';

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({Key? key}) : super(key: key);

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _image;
  final imagepicker = ImagePicker();
  bool isLoading=false;

  Future getImageGallery() async {
    final pickedfile = await imagepicker.pickImage(
        source: ImageSource.gallery, imageQuality: 60);
    setState(() {
      if (pickedfile != null) {
        _image = File(pickedfile.path);
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void postBlog(Blogs blog) {
    isLoading=true;
    try {
      DBHelper.addBlog(blog);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Post Successful"),
        backgroundColor: Colors.green,
      ));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
        backgroundColor: Colors.red,
      ));

    }finally{
      isLoading=false;
      _titleController.clear();
      _descriptionController.clear();
      _image=null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 15.0, left: 8, right: 8, bottom: 10),
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      getImageGallery();
                    },
                    child: _image == null
                        ? const CircleAvatar(
                            radius: 90,
                            child: Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 60,
                            ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height / 3,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(_image!.absolute))),
                          ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Select image",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 60,
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: TextFormField(
                      controller: _titleController,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: "Title",
                        labelStyle: TextStyle(fontSize: 20),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Title Should not be empty";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    constraints:const BoxConstraints(
                      minHeight: 150,
                      // maxHeight: MediaQuery.of(context).size.height
                    ),
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                  border: Border.all(),
                    ),
                    child: TextFormField(
                  controller: _descriptionController,
                  minLines: 1,
                  scrollPadding: const EdgeInsets.all(6),
                  autocorrect: true,
                  maxLines: 10,
                  decoration: const InputDecoration(
                      labelText: "Description",
                      labelStyle: TextStyle(fontSize: 20),
                      border: InputBorder.none),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter description";
                    }
                    return null;
                  },
                    ),
                  ),
                  const SizedBox(height: 10,),
                  InkWell(

                    onTap: (){
                    if(_formKey.currentState!.validate() && _image!=null){
                      postBlog(Blogs(imageUrl: _image?.absolute.toString(),title: _titleController.text));
                    }else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.red, content: Text(
                        "Fill all the fields.",)));
                    }
                    setState(() {

                    });
                  }, child:  isLoading
                      ?const SizedBox(height: 15,width:15,child: CircularProgressIndicator(),)
                      : Container(
                    width: 90,
                      height: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).secondaryHeaderColor
                      ),
                      child:  Text("Post Blog",style: Theme.of(context).textTheme.button,)),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

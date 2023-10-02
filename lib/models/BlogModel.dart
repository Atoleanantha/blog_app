

class Blogs {
  String? id;
  String? imageUrl;
  String? title;

  Blogs({this.id, this.imageUrl, this.title});

  Blogs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['image_url'] = imageUrl;
    data['title'] = title;
    return data;
  }
}


class HomeModel {
  String? image;
  String? name;
  String? publisher;
  String? bookDetailsUrl;

  HomeModel.fromJson(bookDetailsUrl,Map<String, dynamic> json) {
    image = json['imageLinks']?['smallThumbnail'];
    name = json["title"];
    publisher = json["publisher"];
    this.bookDetailsUrl = bookDetailsUrl;
  }
}



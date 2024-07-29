class HomeModel{
  String? image;
  String? name;
  String? publisher;

  HomeModel.fromjson(Map<String,dynamic>json){
    this.image = json['imageLinks']?['smallThumbnail'];
    name= json["title"];
    publisher=json["publisher"];



  }



}


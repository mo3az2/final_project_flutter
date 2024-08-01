class BookDetailsModel{
  String? image;
  String? title;
  String? subTitle;
  String? description;
  String? publisher;
  String? publishedDate;
  int? pageCount;
  String? language;
  String? readUrl;


  BookDetailsModel.fromJson(Map<String, dynamic> json){
    image = json['imageLinks']?['thumbnail'];
    title = json["title"];
    subTitle = json["subtitle"];
    description = json["description"];
    publisher = json["publisher"];
    publishedDate = json["publishedDate"];
    pageCount = json["pageCount"];
    language = json["language"];
    readUrl = json["infoLink"];

  }



  }
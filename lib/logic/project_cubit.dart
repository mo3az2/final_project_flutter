import 'dart:convert';
import 'package:final_project/logic/project_state.dart';
import 'package:final_project/models/book_details_model.dart';
import 'package:final_project/models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';


class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);

  void setTab(int index) {
    emit(index);
  }
}
class HomeCubit extends Cubit<ProjectState> {
  HomeCubit() : super(ProjectInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<HomeModel> allData = [];
  List<HomeModel> programmingData = [];
  List<HomeModel> businessData = [];
  List<HomeModel> scienceData = [];
  List<HomeModel> freeData = [];

  void fetchAllData() {
    getAll();
    getProgramming();
    getBusiness();
    getScience();
    getFree();
  }

  void getAll() async {
    await fetchData("https://www.googleapis.com/books/v1/volumes?q=everything", allData);
  }

  void getProgramming() async {
    await fetchData("https://www.googleapis.com/books/v1/volumes?q=programming", programmingData);
  }

  void getBusiness() async {
    await fetchData("https://www.googleapis.com/books/v1/volumes?q=business", businessData);
  }

  void getScience() async {
    await fetchData("https://www.googleapis.com/books/v1/volumes?q=science", scienceData);
  }

  void getFree() async {
    await fetchData("https://www.googleapis.com/books/v1/volumes?q=free", freeData);
  }

  Future<void> fetchData(String url, List<HomeModel> dataList) async {
    emit(Loading());
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var convertedResponse = jsonDecode(response.body);
        List listFromApi = convertedResponse["items"];
        for (var element in listFromApi) {
          dataList.add(HomeModel.fromJson(element["selfLink"],element["volumeInfo"]));
        }
        emit(Success());
      } else {
        debugPrint("status : ${response.statusCode}");
        emit(Error());
      }
    } catch (e) {
      debugPrint("$e");
      emit(Error());
    }
  }
}


class BookDetailsCubit extends Cubit<ProjectState>{

  BookDetailsCubit() : super(ProjectInitial());

   static BookDetailsCubit get (context)=> BlocProvider.of(context);

  List<BookDetailsModel> bookDetails =[];


   Future<void> getBookDetails(String url) async {
     emit(Loading());
     try {
       var uri =Uri.parse(url);
       var response = await http.get(uri);
       if (response.statusCode == 200) {
         var convertedResponse = jsonDecode(response.body);
         // Ensure that `volumeInfo` is a Map and not an Iterable
         var volumeInfo = convertedResponse["volumeInfo"];

         if (volumeInfo != null && volumeInfo is Map<String, dynamic>) {
           bookDetails.add(BookDetailsModel.fromJson(volumeInfo));
           emit(Success());
         } else {
           emit(Error());
           debugPrint("VolumeInfo is not in the expected format.");
         }
       } else {
         debugPrint("status : ${response.statusCode}");
         emit(Error());
       }

     } catch (e) {
       debugPrint("$e");
       emit(Error());
     }


   }

  /*static Future<void> urlLaunch(String readUrl)async{
    final Uri url =Uri.parse(readUrl);
    if(!await launchUrl(url)){
      throw Exception("Could not launch");
    }else{
      await launchUrl(url);
    }
  }*/
 static Future<void> launchURL(String url) async {
    final uri = Uri.parse(url);
    try {
      /*if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint("Could not launch $url");
        // Provide user feedback
      }*/
      await launch(url);
    } catch (e) {
      debugPrint("Error launching URL: $e");
      // Provide user feedback
    }
  }

}




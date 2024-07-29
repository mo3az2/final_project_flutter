import 'dart:convert';
import 'package:final_project/logic/project_state.dart';
import 'package:final_project/models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);

  void setTab(int index) {
    emit(index);
  }
}

class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit() : super(ProjectInitial());

  static ProjectCubit get(context) => BlocProvider.of(context);

  List<HomeModel> AllData = [];
  void getAll() async {
    await fetchData("https://www.googleapis.com/books/v1/volumes?q=everything", AllData);
  }

  List<HomeModel> ProgrammingData = [];
  void getProgramming() async {
    await fetchData("https://www.googleapis.com/books/v1/volumes?q=programming", ProgrammingData);
  }

  List<HomeModel> BusinessData = [];
  void getBusiness() async {
    await fetchData("https://www.googleapis.com/books/v1/volumes?q=business", BusinessData);
  }

  List<HomeModel> ScienceData = [];
  void getScience() async {
    await fetchData("https://www.googleapis.com/books/v1/volumes?q=science", ScienceData);
  }

  List<HomeModel> FreeData = [];
  void getFree() async {
    await fetchData("https://www.googleapis.com/books/v1/volumes?q=free", FreeData);
  }

  Future<void> fetchData(String url, List<HomeModel> dataList) async {
    emit(Loading());
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var convertedResponse = jsonDecode(response.body);
        List listFromApi = convertedResponse["items"];
        for (var element in listFromApi) {
          dataList.add(HomeModel.fromjson(element["volumeInfo"]));
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

/*import 'dart:convert';
import 'package:final_project/logic/project_state.dart';
import 'package:final_project/models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);

  void setTab(int index) {
    emit(index);
  }

}


class ProjectCubit extends Cubit<ProjectState>{
  ProjectCubit() : super(ProjectInitial());

  static ProjectCubit get(context)=> BlocProvider.of(context);


  List <HomeModel> AllData = [];
  void getAll() async {

    try{
      emit(Loading());
      var url = Uri.parse("https://www.googleapis.com/books/v1/volumes?q=everything");
      var response = await http.get(url);
      if (response.statusCode==200){
        //print("=============================================${response.body}");
        var convertedResponse = jsonDecode(response.body);
        // print("==============================================${convertedResponse}");
        List listFromApi =convertedResponse["items"];
        for (var element in listFromApi) {
         AllData.add(HomeModel.fromjson(element["volumeInfo"]));
        }
        emit(Success());
      }else {
        debugPrint("status : ${response.statusCode}");
      }
    }catch(e){
      debugPrint("$e");
      emit(Error());
    }


  }

  List <HomeModel> ProgrammingData = [];
  void getProgramming() async {

    try{
      emit(Loading());
      var url = Uri.parse("https://www.googleapis.com/books/v1/volumes?q=programming");
      var response = await http.get(url);
      if (response.statusCode==200){
        //print("=============================================${response.body}");
        var convertedResponse = jsonDecode(response.body);
        // print("==============================================${convertedResponse}");
        List listFromApi =convertedResponse["items"];
        for (var element in listFromApi) {
          ProgrammingData.add(HomeModel.fromjson(element["volumeInfo"]));
        }
        emit(Success());
      }else {
        debugPrint("status : ${response.statusCode}");
      }
    }catch(e){
      debugPrint("$e");
      emit(Error());
    }


  }

  List <HomeModel> BusinessData = [];
  void getBusiness() async {

    try{
      emit(Loading());
      var url = Uri.parse("https://www.googleapis.com/books/v1/volumes?q=business");
      var response = await http.get(url);
      if (response.statusCode==200){
        //print("=============================================${response.body}");
        var convertedResponse = jsonDecode(response.body);
        // print("==============================================${convertedResponse}");
        List listFromApi =convertedResponse["items"];
        for (var element in listFromApi) {
          BusinessData.add(HomeModel.fromjson(element["volumeInfo"]));
        }
        emit(Success());
      }else {
        debugPrint("status : ${response.statusCode}");
      }
    }catch(e){
      debugPrint("$e");
      emit(Error());
    }


  }

  List <HomeModel> ScienceData = [];
  void getScience() async {

    try{
      emit(Loading());
      var url = Uri.parse("https://www.googleapis.com/books/v1/volumes?q=science");
      var response = await http.get(url);
      if (response.statusCode==200){
        //print("=============================================${response.body}");
        var convertedResponse = jsonDecode(response.body);
        // print("==============================================${convertedResponse}");
        List listFromApi =convertedResponse["items"];
        for (var element in listFromApi) {
          ScienceData.add(HomeModel.fromjson(element["volumeInfo"]));
        }
        emit(Success());
      }else {
        debugPrint("status : ${response.statusCode}");
      }
    }catch(e){
      debugPrint("$e");
      emit(Error());
    }


  }

  List <HomeModel> FreeData = [];
  void getFree() async {

    try{
      emit(Loading());
      var url = Uri.parse("https://www.googleapis.com/books/v1/volumes?q=free");
      var response = await http.get(url);
      if (response.statusCode==200){
        //print("=============================================${response.body}");
        var convertedResponse = jsonDecode(response.body);
        // print("==============================================${convertedResponse}");
        List listFromApi =convertedResponse["items"];
        for (var element in listFromApi) {
          FreeData.add(HomeModel.fromjson(element["volumeInfo"]));
        }
        emit(Success());
      }else {
        debugPrint("status : ${response.statusCode}");
      }
    }catch(e){
      debugPrint("$e");
      emit(Error());
    }


  }


}*/
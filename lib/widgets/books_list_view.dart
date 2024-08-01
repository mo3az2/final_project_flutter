import 'package:final_project/logic/project_cubit.dart';
import 'package:final_project/logic/project_state.dart';
import 'package:final_project/screens/book_details_screen.dart';
import 'package:final_project/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeListView extends StatelessWidget {
  final String type;

  const HomeListView({super.key, required this.type});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, ProjectState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        List data;
        switch (type) {
          case "Programming":
            data = cubit.programmingData;
            break;
          case "Business":
            data = cubit.businessData;
            break;
          case "Science":
            data = cubit.scienceData;
            break;
          case "Free":
            data = cubit.freeData;
            break;
          case "All":
          default:
            data = cubit.allData;
            break;
        }
        if (state is Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is Success) {
          if (data.isEmpty) {
            return const Center(child: Text("No data available"));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context,){
                      return BookDetailsScreen(url: data[index].bookDetailsUrl!,);
                    }
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: data[index].image != null
                            ? Image.network(
                          data[index].image!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.fill,
                        )
                            : const Center(child: Text("No image")),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            data[index].name != null
                                ? Text(
                              "Title: ${data[index].name!}",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )
                                : const Text(
                              "No title",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            data[index].publisher != null
                                ? Text(
                              "Publisher: ${data[index].publisher!}",
                            )
                                : const Text("No publisher"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
            itemCount: data.length,
          );
        } else {
          return const Center(child: Text("Error"));
        }
      },
    );
  }
}
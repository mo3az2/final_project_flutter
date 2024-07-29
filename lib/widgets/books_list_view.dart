import 'package:final_project/logic/project_cubit.dart';
import 'package:final_project/logic/project_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeListView extends StatelessWidget {
  final String type;

  HomeListView({required this.type});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        var cubit = ProjectCubit.get(context);
        List data;
        switch (type) {
          case "Programming":
            data = cubit.ProgrammingData;
            break;
          case "Business":
            data = cubit.BusinessData;
            break;
          case "Science":
            data = cubit.ScienceData;
            break;
          case "Free":
            data = cubit.FreeData;
            break;
          case "All":
          default:
            data = cubit.AllData;
            break;
        }
        return state is Loading
            ? const Center(child: CircularProgressIndicator())
            : state is Success
            ? ListView.separated(
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index) {
            return Container(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10);
          },
          itemCount: data.length,
        )
            : const Center(child: Text("Error"));
      },
    );
  }
}
/*import 'package:final_project/logic/project_cubit.dart';
import 'package:final_project/logic/project_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeListView extends StatelessWidget {
   const HomeListView({super.key,required this.query});
 final String query;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectCubit()..getHomeData(query),
      child: BlocBuilder<ProjectCubit, ProjectState>(
        builder: (context, state) {
          var cubit = ProjectCubit.get(context);
          return
            (state is Loading)?
            const Center(child: CircularProgressIndicator()):
            (state is Success)?
            ListView.separated(
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:
                            (cubit.homeData[index].image !=null)?
                            Image.network(
                              cubit.homeData[index].image!,
                              height: 100,
                              width: 100,
                              fit: BoxFit.fill,
                            ):
                            const Center(child: Text("No image"))
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            children: [
                              cubit.homeData[index].name!=null?
                              Text("Title : ${cubit.homeData[index].name!}",
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ):
                              const Text("No title",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(height: 5,),
                              cubit.homeData[index].publisher!=null?
                              Text("Publisher : ${cubit.homeData[index].publisher!}",
                              ):
                              const Text("No publisher",),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10,);
                },
                itemCount: cubit.homeData.length):
            const Text("Error");
        },
      ),
    );
  }
}*/
/*import 'package:final_project/logic/project_cubit.dart';
import 'package:final_project/logic/project_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeListView extends StatelessWidget {
   HomeListView({super.key,required this.direction,required this.cubit2});
  final direction;
  final cubit2;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) => ProjectCubit()..getAll() ,
      child: BlocBuilder<ProjectCubit, ProjectState>(
        builder: (context, state) {
          var cubit = ProjectCubit.get(context);
          return state is Loading
              ? const Center(child: CircularProgressIndicator())
              : state is Success
              ? ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return Container(
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
                      child: cubit[index].image != null
                          ? Image.network(
                        cubit[index].image!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                      )
                          : const Center(child: Text("No image")),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          cubit[index].name != null
                              ? Text(
                            "Title: ${cubit[index].name!}",
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
                          cubit[index].publisher != null
                              ? Text(
                            "Publisher: ${cubit[index].publisher!}",
                          )
                              : const Text("No publisher"),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
            itemCount: cubit.length,
          )
              : const Center(child: Text("Error"));
        },
      ),
    );
  }
}*/



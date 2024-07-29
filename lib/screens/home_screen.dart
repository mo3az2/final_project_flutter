

import 'package:final_project/logic/project_cubit.dart';
import 'package:final_project/widgets/books_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Widget> _pages = [
    BlocProvider(
      create: (context) => ProjectCubit()..getAll(),
      child: HomeListView(type: "All"),
    ),
    BlocProvider(
      create: (context) => ProjectCubit()..getProgramming(),
      child: HomeListView(type: "Programming"),
    ),
    BlocProvider(
      create: (context) => ProjectCubit()..getBusiness(),
      child: HomeListView(type: "Business"),
    ),
    BlocProvider(
      create: (context) => ProjectCubit()..getScience(),
      child: HomeListView(type: "Science"),
    ),
    BlocProvider(
      create: (context) => ProjectCubit()..getFree(),
      child: HomeListView(type: "Free"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: Scaffold(
        body: BlocBuilder<NavigationCubit, int>(
          builder: (context, currentIndex) {
            return _pages[currentIndex];
          },
        ),
        bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
          builder: (context, currentIndex) {
            return BottomNavigationBar(
              currentIndex: currentIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                context.read<NavigationCubit>().setTab(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.clear_all_outlined),
                  label: 'All',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.computer),
                  label: 'Programming',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'Business',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.science_rounded),
                  label: 'Science',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.money_off),
                  label: 'Free',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}


/*import 'package:final_project/logic/project_cubit.dart';
import 'package:final_project/logic/project_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {

    List<Widget> _pages = [

      BlocProvider(
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
                        child: cubit.AllData[index].image != null
                            ? Image.network(
                          cubit.AllData[index].image!,
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
                            cubit.AllData[index].name != null
                                ? Text(
                              "Title: ${cubit.AllData[index].name!}",
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
                            cubit.AllData[index].publisher != null
                                ? Text(
                              "Publisher: ${cubit.AllData[index].publisher!}",
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
              itemCount: cubit.AllData.length,
            )
                : const Center(child: Text("Error"));
          },
        ),
      ),

      BlocProvider(
        create:(context) => ProjectCubit()..getProgramming() ,
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
                        child: cubit.ProgrammingData[index].image != null
                            ? Image.network(
                          cubit.ProgrammingData[index].image!,
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
                            cubit.ProgrammingData[index].name != null
                                ? Text(
                              "Title: ${cubit.ProgrammingData[index].name!}",
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
                            cubit.ProgrammingData[index].publisher != null
                                ? Text(
                              "Publisher: ${cubit.ProgrammingData[index].publisher!}",
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
              itemCount: cubit.ProgrammingData.length,
            )
                : const Center(child: Text("Error"));
          },
        ),
      ),

      BlocProvider(
        create:(context) => ProjectCubit()..getBusiness() ,
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
                        child: cubit.BusinessData[index].image != null
                            ? Image.network(
                          cubit.BusinessData[index].image!,
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
                            cubit.BusinessData[index].name != null
                                ? Text(
                              "Title: ${cubit.BusinessData[index].name!}",
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
                            cubit.BusinessData[index].publisher != null
                                ? Text(
                              "Publisher: ${cubit.BusinessData[index].publisher!}",
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
              itemCount: cubit.BusinessData.length,
            )
                : const Center(child: Text("Error"));
          },
        ),
      ),

      BlocProvider(
        create:(context) => ProjectCubit()..getScience() ,
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
                        child: cubit.ScienceData[index].image != null
                            ? Image.network(
                          cubit.ScienceData[index].image!,
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
                            cubit.ScienceData[index].name != null
                                ? Text(
                              "Title: ${cubit.ScienceData[index].name!}",
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
                            cubit.ScienceData[index].publisher != null
                                ? Text(
                              "Publisher: ${cubit.ScienceData[index].publisher!}",
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
              itemCount: cubit.ScienceData.length,
            )
                : const Center(child: Text("Error"));
          },
        ),
      ),

      BlocProvider(
        create:(context) => ProjectCubit()..FreeData ,
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
                        child: cubit.FreeData[index].image != null
                            ? Image.network(
                          cubit.FreeData[index].image!,
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
                            cubit.FreeData[index].name != null
                                ? Text(
                              "Title: ${cubit.FreeData[index].name!}",
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
                            cubit.FreeData[index].publisher != null
                                ? Text(
                              "Publisher: ${cubit.FreeData[index].publisher!}",
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
              itemCount: cubit.FreeData.length,
            )
                : const Center(child: Text("Error"));
          },
        ),
      ),
     /* HomeListView(direction: (context) => ProjectCubit()..getAll(),
          cubit2: ProjectCubit.get(context).AllData),

      HomeListView(direction: (context) => ProjectCubit()..getProgramming(),
          cubit2: ProjectCubit.get(context).ProgrammingData),

      HomeListView(direction: (context) => ProjectCubit()..getBusiness(),
          cubit2: ProjectCubit.get(context).BusinessData),

      HomeListView(direction: (context) => ProjectCubit()..getScience(),
          cubit2: ProjectCubit.get(context).ScienceData),

      HomeListView(direction: (context) => ProjectCubit()..getFree(),
          cubit2: ProjectCubit.get(context).FreeData),*/

    ];
    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: Scaffold(
        body: BlocBuilder<NavigationCubit, int>(
          builder: (context, currentIndex) {
            return _pages[currentIndex];
          },
        ),
        bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
          builder: (context, currentIndex) {
            return BottomNavigationBar(
              currentIndex: currentIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index){
                context.read<NavigationCubit>().setTab(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.clear_all_outlined),
                  label: 'All',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.computer),
                  label: 'Programming',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'Business',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.science_rounded),
                  label: 'Science',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.money_off),
                  label: 'Free',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}*/



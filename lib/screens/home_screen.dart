import 'package:final_project/logic/project_cubit.dart';
import 'package:final_project/widgets/books_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Widget> _pages = [
    const HomeListView(type: "All"),
    const HomeListView(type: "Programming"),
    const HomeListView(type: "Business"),
    const HomeListView(type: "Science"),
    const HomeListView(type: "Free"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text("Books"),
        centerTitle: true,
      ),

      body: SafeArea(
        child: BlocBuilder<NavigationCubit, int>(
          builder: (context, currentIndex) {
            return _pages[currentIndex];
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentIndex){
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
    );
  }
}



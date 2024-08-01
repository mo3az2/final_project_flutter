import 'package:final_project/logic/project_cubit.dart';
import 'package:final_project/logic/project_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text("Book Details"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => BookDetailsCubit()..getBookDetails(url),
        child: BlocBuilder<BookDetailsCubit, ProjectState>(
          builder: (context, state) {
            var cubit = BookDetailsCubit.get(context);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0), // Adding padding for better layout
                child: ListView.builder(
                  shrinkWrap: true, // Adjusts the height based on content
                  physics: const NeverScrollableScrollPhysics(), // Prevents scrolling within the SingleChildScrollView
                  itemCount: cubit.bookDetails.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),
                        (cubit.bookDetails[index].image != null)
                            ? Image.network(
                          cubit.bookDetails[index].image!,
                          width: double.infinity,
                          height: 200,
                        )
                            : const Text("No image"),
                        const SizedBox(height: 20,),

                        // Title
                        const Text(
                          "Title:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          cubit.bookDetails[index].title ?? "No title",
                          style: const TextStyle(fontSize: 16),
                        ),

                        const SizedBox(height: 20,),

                        // Subtitle
                        const Text(
                          "Subtitle:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          cubit.bookDetails[index].subTitle ?? "No subtitle",
                          style: const TextStyle(fontSize: 16),
                        ),

                        const SizedBox(height: 20,),

                        // Language
                        const Text(
                          "Language:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          cubit.bookDetails[index].language ?? "No language",
                          style: const TextStyle(fontSize: 16),
                        ),

                        const SizedBox(height: 20,),

                        // Number of pages
                        const Text(
                          "Number of pages:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          cubit.bookDetails[index].pageCount.toString() ?? "N/A",
                          style: const TextStyle(fontSize: 16),
                        ),

                        const SizedBox(height: 20,),

                        // Publisher
                        const Text(
                          "Publisher:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          cubit.bookDetails[index].publisher ?? "No publisher",
                          style: const TextStyle(fontSize: 16),
                        ),

                        const SizedBox(height: 20,),

                        // Published date
                        const Text(
                          "Published date:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          cubit.bookDetails[index].publishedDate ?? "No date",
                          style: const TextStyle(fontSize: 16),
                        ),

                        const SizedBox(height: 20,),

                        // Description
                        const Text(
                          "Description:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          cubit.bookDetails[index].description ?? "No description",
                          style: const TextStyle(fontSize: 16),
                        ),

                        const SizedBox(height: 20,),

                        // Read button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              (cubit.bookDetails[index].readUrl!=null)?
                              BookDetailsCubit.launchURL(cubit.bookDetails[index].readUrl!):
                                  ScaffoldMessenger.of(context).showMaterialBanner(
                                    MaterialBanner(
                                        content: const Text("Error opening link"),
                                        padding: const EdgeInsets.all(6),
                                        backgroundColor: Colors.white,
                                        actions: <Widget>[
                                          TextButton(onPressed: (){
                                            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();

                                          }, child: const Text("Hide") )
                                        ] ,

                                    )

                                  );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amberAccent,
                              foregroundColor: Colors.black,
                            ),
                            child: const Text("Read"),
                          ),
                        ),

                        const SizedBox(height: 30,), // Additional spacing between items
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


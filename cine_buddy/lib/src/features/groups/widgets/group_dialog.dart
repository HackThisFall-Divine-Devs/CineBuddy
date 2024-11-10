import 'package:cine_buddy/src/common_widgets/alerts.dart';
import 'package:cine_buddy/src/common_widgets/theme_button.dart';
import 'package:cine_buddy/src/common_widgets/theme_textfield.dart';
import 'package:cine_buddy/src/features/groups/bloc/group_bloc.dart';
import 'package:cine_buddy/src/features/groups/group_create.dart';
import 'package:cine_buddy/src/features/groups/groups_page.dart';
import 'package:cine_buddy/src/features/groups/movie_groups_page.dart';
import 'package:cine_buddy/src/models/groups/group.dart';
import 'package:cine_buddy/src/models/movie/movies.dart';
import 'package:cine_buddy/src/utils/colors_sys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupDialog {
  void launchDialog(BuildContext context,
      {required Map<String, Object> movie}) {
    final Movies movieData = movie["movie"] as Movies;

    // print(movie["movie"].title);
    print(movieData.title);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(child: Text("Find your Movie Match!")),
        titleTextStyle:
            Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
        backgroundColor: ColorSys.kprimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        content: SizedBox(
          height: 150.0,
          width: 350.0,
          child: Column(
            children: [
              ThemeButton(
                name: "Join the Watch Party",
                buttonColor: ColorSys.kwhite,
                onPressed: () {
                  Navigator.pop(context, true);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieGroupPage(movieData.title),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              ThemeButton(
                name: "Create Your Crew",
                buttonColor: ColorSys.ksecondary,
                onPressed: () {
                  Navigator.pop(context, true);
                  // createGroupDialog(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateGroupPage(movie),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void createGroupDialog(BuildContext context) {
  //   TextEditingController nameController = TextEditingController();
  //   TextEditingController descriptionController = TextEditingController();

  //   showDialog(
  //     context: context,
  //     builder: (context) => BlocConsumer<GroupBloc, GroupState>(
  //       listener: (context, state) {
  //         if (state is CreateGroupSuccess) {
  //           Navigator.push(context,
  //               MaterialPageRoute(builder: (context) => const GroupsPage()));
  //         }
  //       },
  //       builder: (context, state) {
  //         return AlertDialog(
  //           title: const Center(child: Text("Create Your own Crew!")),
  //           titleTextStyle:
  //               Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
  //           backgroundColor: ColorSys.kprimary,
  //           shape: const RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(
  //               Radius.circular(20),
  //             ),
  //           ),
  //           content: SizedBox(
  //             height: 220.0,
  //             width: 350.0,
  //             child: Column(
  //               children: [
  //                 ThemeTextField(
  //                   fieldName: "Enter name of your crew....",
  //                   controllerName: nameController,
  //                 ),
  //                 const SizedBox(
  //                   height: 20.0,
  //                 ),
  //                 ThemeTextField(
  //                   fieldName: "Enter short description....",
  //                   controllerName: descriptionController,
  //                 ),
  //                 const SizedBox(
  //                   height: 20.0,
  //                 ),
  //                 state is CreateGroupLoading
  //                     ? const Center(
  //                         child: CircularProgressIndicator(),
  //                       )
  //                     : ThemeButton(
  //                         name: "Create",
  //                         buttonColor: ColorSys.ksecondary,
  //                         onPressed: () => createGroup(
  //                             context, nameController, descriptionController),
  //                       ),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  // void createGroup(BuildContext context, TextEditingController nameController,
  //     TextEditingController descriptionController) {
  //   if (nameController.text.isNotEmpty &&
  //       descriptionController.text.isNotEmpty) {
  //     context.read<GroupBloc>().add(CreateGroup(
  //           nameController.text.trim(),
  //           descriptionController.text.trim(),
  //         ));
  //     return;
  //   }
  //   showAlert(context, "Name or Description can't be empty!", "", "info");
  // }
}

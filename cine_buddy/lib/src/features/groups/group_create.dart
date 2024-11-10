import 'package:cine_buddy/src/common_widgets/theme_button.dart';
import 'package:cine_buddy/src/common_widgets/theme_textfield.dart';
import 'package:cine_buddy/src/features/groups/bloc/group_bloc.dart';
import 'package:cine_buddy/src/features/groups/groups_page.dart';
import 'package:cine_buddy/src/models/movie/genere.dart';
import 'package:cine_buddy/src/models/movie/movies.dart';
import 'package:cine_buddy/src/utils/colors_sys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:intl/intl.dart';

class CreateGroupPage extends StatefulWidget {
  Map<String, Object> movie;
  CreateGroupPage(this.movie, {Key? key}) : super(key: key);

  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController otherDetailsController = TextEditingController();
  List<String> selectedGenre = [];
  List<String> selectedTimePreference = [];
  List<String> selectedAgeGroup = [];
  List<String> selectedGenderPreference = [];
  List<String> selectedLanguagePreference = [];
  String? selectedType = 'dating';
  String? selectedPublic = 'Public';
  int? membersLimit;
  DateTime? selectedDate;
  String? selectedTimezone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Create Your Own Crew!",
          style:
              Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 22.0),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<GroupBloc, GroupState>(
          listener: (context, state) {
            print(state);
            if (state is CreateGroupSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GroupsPage()),
              );
            }
          },
          builder: (context, state) {
            return ListView(
              children: [
                ThemeTextField(
                  fieldName: "Enter name of your crew....",
                  controllerName: nameController,
                ),
                const SizedBox(height: 20),
                Text(
                  "Select Privacy",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 18.0),
                ),
                const SizedBox(height: 10),
                MultiSelectContainer(
                  singleSelectedItem: true,
                  itemsDecoration: MultiSelectDecorations(
                    selectedDecoration: BoxDecoration(
                        color: ColorSys.ksecondary,
                        border: Border.all(color: ColorSys.ksecondary),
                        borderRadius: BorderRadius.circular(20)),
                    decoration: BoxDecoration(
                        color: ColorSys.kgrey,
                        border: Border.all(color: ColorSys.kgrey),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  textStyles: MultiSelectTextStyles(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorSys.kwhite,
                    ),
                    selectedTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorSys.kprimary,
                    ),
                  ),
                  items: [
                    MultiSelectCard(value: 'Public', label: 'Public'),
                    MultiSelectCard(value: 'Private', label: 'Private'),
                  ],
                  highlightColor: Colors.blueAccent,
                  splashColor: Colors.grey,
                  onChange: (allSelectedItems, selectedItem) {
                    setState(() {
                      selectedPublic = allSelectedItems.isEmpty
                          ? 'Public'
                          : allSelectedItems.first;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  "Select Time Preference",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 18.0),
                ),
                const SizedBox(height: 10),
                MultiSelectContainer(
                  singleSelectedItem: true,
                  itemsDecoration: MultiSelectDecorations(
                    selectedDecoration: BoxDecoration(
                        color: ColorSys.ksecondary,
                        border: Border.all(color: ColorSys.ksecondary),
                        borderRadius: BorderRadius.circular(20)),
                    decoration: BoxDecoration(
                        color: ColorSys.kgrey,
                        border: Border.all(color: ColorSys.kgrey),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  textStyles: MultiSelectTextStyles(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorSys.kwhite,
                    ),
                    selectedTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorSys.kprimary,
                    ),
                  ),
                  items: [
                    MultiSelectCard(value: 'morning', label: 'Morning'),
                    MultiSelectCard(value: 'noon', label: 'Noon'),
                    MultiSelectCard(value: 'evening', label: 'Evening'),
                    MultiSelectCard(value: 'late night', label: 'Late Night'),
                  ],
                  highlightColor: Colors.blueAccent,
                  splashColor: Colors.grey,
                  onChange: (allSelectedItems, selectedItem) {
                    setState(() {
                      selectedTimePreference = allSelectedItems;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  "Select Age Group",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 18.0),
                ),
                const SizedBox(height: 10),
                MultiSelectContainer(
                  itemsDecoration: MultiSelectDecorations(
                    selectedDecoration: BoxDecoration(
                        color: ColorSys.ksecondary,
                        border: Border.all(color: ColorSys.ksecondary),
                        borderRadius: BorderRadius.circular(20)),
                    decoration: BoxDecoration(
                        color: ColorSys.kgrey,
                        border: Border.all(color: ColorSys.kgrey),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  textStyles: MultiSelectTextStyles(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorSys.kwhite,
                    ),
                    selectedTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorSys.kprimary,
                    ),
                  ),
                  items: [
                    MultiSelectCard(value: '12-18', label: '12-18'),
                    MultiSelectCard(value: '18-25', label: '18-25'),
                    MultiSelectCard(value: '25-35', label: '25-35'),
                    MultiSelectCard(value: '35+', label: '35+'),
                  ],
                  highlightColor: Colors.blueAccent,
                  splashColor: Colors.grey,
                  onChange: (allSelectedItems, selectedItem) {
                    setState(() {
                      selectedAgeGroup = allSelectedItems;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  "Select Gender Preference",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 18.0),
                ),
                const SizedBox(height: 10),
                MultiSelectContainer(
                  singleSelectedItem: true,
                  itemsDecoration: MultiSelectDecorations(
                    selectedDecoration: BoxDecoration(
                        color: ColorSys.ksecondary,
                        border: Border.all(color: ColorSys.ksecondary),
                        borderRadius: BorderRadius.circular(20)),
                    decoration: BoxDecoration(
                        color: ColorSys.kgrey,
                        border: Border.all(color: ColorSys.kgrey),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  textStyles: MultiSelectTextStyles(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorSys.kwhite,
                    ),
                    selectedTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorSys.kprimary,
                    ),
                  ),
                  items: [
                    MultiSelectCard(value: 'Male', label: 'Male'),
                    MultiSelectCard(value: 'Female', label: 'Female'),
                    MultiSelectCard(value: 'Non-Binary', label: 'Non-Binary'),
                    MultiSelectCard(value: 'Any', label: 'Any'),
                  ],
                  highlightColor: Colors.blueAccent,
                  splashColor: Colors.grey,
                  onChange: (allSelectedItems, selectedItem) {
                    setState(() {
                      selectedGenderPreference = allSelectedItems;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  "Select Language Preference",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 18.0),
                ),
                const SizedBox(height: 10),
                MultiSelectContainer(
                  itemsDecoration: MultiSelectDecorations(
                    selectedDecoration: BoxDecoration(
                        color: ColorSys.ksecondary,
                        border: Border.all(color: ColorSys.ksecondary),
                        borderRadius: BorderRadius.circular(20)),
                    decoration: BoxDecoration(
                        color: ColorSys.kgrey,
                        border: Border.all(color: ColorSys.kgrey),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  textStyles: MultiSelectTextStyles(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorSys.kwhite,
                    ),
                    selectedTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorSys.kprimary,
                    ),
                  ),
                  items: [
                    MultiSelectCard(value: 'English', label: 'English'),
                    MultiSelectCard(value: 'Spanish', label: 'Spanish'),
                    MultiSelectCard(value: 'French', label: 'French'),
                    MultiSelectCard(value: 'Any', label: 'Any'),
                  ],
                  highlightColor: Colors.blueAccent,
                  splashColor: Colors.grey,
                  onChange: (allSelectedItems, selectedItem) {
                    setState(() {
                      selectedLanguagePreference = allSelectedItems;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  "Select Type",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 18.0),
                ),
                const SizedBox(height: 10),
                DropdownButton<String>(
                  value: selectedType,
                  onChanged: (newValue) {
                    setState(() {
                      selectedType = newValue!;
                    });
                  },
                  items: ['dating', 'friend'].map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(
                        type,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                ThemeTextField(
                  fieldName: "Enter other details....",
                  controllerName: otherDetailsController,
                ),
                const SizedBox(height: 20),
                Text(
                  "Select Date",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 18.0),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: selectedDate == null
                        ? ""
                        : DateFormat('yyyy-MM-dd').format(selectedDate!),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Date",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Select Timezone",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 18.0),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      selectedTimezone = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Timezone",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Members Limit",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 18.0),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      membersLimit = int.tryParse(value);
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Members Limit (1-10)",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                state is CreateGroupLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ThemeButton(
                        name: "Create",
                        buttonColor: Colors.blueAccent,
                        onPressed: () => createGroup(context),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }

  void createGroup(BuildContext context) {
    final Movies movieData = widget.movie["movie"] as Movies;
    final List<Genre> genre = widget.movie["genere"] as List<Genre>;
    List<String> genreNames = genre.map((genre) => genre.name).toList();
    String formattedDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(selectedDate!);

    final payload = {
      "groupName": nameController.text,
      "movieName": movieData.title,
      "public": selectedPublic == 'Public',
      "timePreference": selectedTimePreference.isNotEmpty
          ? selectedTimePreference.first
          : "evening",
      "timezone": selectedTimezone ?? "IST",
      "date": selectedDate != null ? formattedDate : "2024-11-15T20:00:00Z",
      "membersLimit": membersLimit ?? 10,
      "ageGroup":
          selectedAgeGroup.isNotEmpty ? selectedAgeGroup.first : "18-25",
      "genderPreference": selectedGenderPreference.isNotEmpty
          ? selectedGenderPreference.first
          : "anyone",
      "languagePreference": selectedLanguagePreference.isNotEmpty
          ? selectedLanguagePreference
          : ["English", "Hindi"],
      "type": selectedType ?? "friend",
      "genre": selectedGenre.isNotEmpty ? selectedGenre.first : "sci-fi",
      "otherDetails": otherDetailsController.text.isNotEmpty
          ? otherDetailsController.text
          : "<95min",
      "movieData": {
        "adult": false,
        "backdropPath": movieData.backdropPath ?? "",
        "genre": genreNames ?? [],
        "id": movieData.id ?? 0,
        "originalLanguage": movieData.originalLanguage ?? "en",
        "originalTitle": movieData.originalTitle ?? "Unknown Title",
        "overview": movieData.overview ?? "No overview available.",
        "popularity": movieData.popularity ?? 0.0,
        "posterPath": movieData.posterPath ?? "",
        "releaseDate": movieData.releaseDate ?? "2023-01-01",
        "title": movieData.title ?? "Unknown Title",
        "voteAverage": movieData.voteAverage ?? 0.0,
        "voteCount": movieData.voteCount ?? 0
      }
    };

    context.read<GroupBloc>().add(CreateGroup(
          payload: payload,
        ));
  }
}

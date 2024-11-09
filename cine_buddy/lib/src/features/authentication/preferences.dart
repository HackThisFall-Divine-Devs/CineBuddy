import 'package:cine_buddy/src/common_widgets/alerts.dart';
import 'package:cine_buddy/src/common_widgets/loading_incicator.dart';
import 'package:cine_buddy/src/common_widgets/theme_button.dart';
import 'package:cine_buddy/src/features/authentication/bloc/authentication_bloc.dart';
import 'package:cine_buddy/src/features/home_outline/home_outline.dart';
import 'package:cine_buddy/src/utils/colors_sys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';

class Preferences extends StatefulWidget {
  String username;
  String email;
  String password;
  Preferences({
    super.key,
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  List<String> selectedGenre = [];
  List<String> selectedStreamingPlatform = [];
  List<String> selectedOtherDetails = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showAlert(context, state.error, "", "error");
          }
          if (state is AuthSuccess) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeOutLine()));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const LoadingIndicator();
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "I'm looking for...",
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 28.0),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Genre",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
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
                        MultiSelectCard(value: 'Action', label: 'Action'),
                        MultiSelectCard(value: 'Adventure', label: 'Adventure'),
                        MultiSelectCard(value: 'Comedy', label: 'Comedy'),
                        MultiSelectCard(value: 'Drama', label: 'Drama'),
                        MultiSelectCard(value: 'Fantasy', label: 'Fantasy'),
                        MultiSelectCard(value: 'Horror', label: 'Horror'),
                        MultiSelectCard(value: 'Mystery', label: 'Mystery'),
                        MultiSelectCard(value: 'Romance', label: 'Romance'),
                        MultiSelectCard(value: 'Sci-Fi', label: 'Sci-Fi'),
                        MultiSelectCard(value: 'Thriller', label: 'Thriller')
                      ],
                      highlightColor: ColorSys.ksecondary,
                      splashColor: ColorSys.kgrey,
                      onChange: (allSelectedItems, selectedItem) {
                        selectedGenre = allSelectedItems;
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Streaming providers",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
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
                        MultiSelectCard(value: 'Netflix', label: 'Netflix'),
                        MultiSelectCard(
                            value: 'Amazon Prime Video',
                            label: 'Amazon Prime Video'),
                        MultiSelectCard(value: 'Disney+', label: 'Disney+'),
                        MultiSelectCard(value: 'Hulu', label: 'Hulu'),
                        MultiSelectCard(value: 'HBO Max', label: 'HBO Max'),
                        MultiSelectCard(value: 'Apple TV+', label: 'Apple TV+'),
                        MultiSelectCard(value: 'Peacock', label: 'Peacock'),
                        MultiSelectCard(
                            value: 'Paramount+', label: 'Paramount+'),
                        MultiSelectCard(
                            value: 'YouTube TV', label: 'YouTube TV'),
                        MultiSelectCard(value: 'Sling TV', label: 'Sling TV'),
                        MultiSelectCard(
                            value: 'Discovery+', label: 'Discovery+'),
                        MultiSelectCard(value: 'ESPN+', label: 'ESPN+'),
                        MultiSelectCard(
                            value: 'Crunchyroll', label: 'Crunchyroll'),
                        MultiSelectCard(value: 'Showtime', label: 'Showtime'),
                        MultiSelectCard(value: 'Starz', label: 'Starz'),
                      ],
                      onChange: (allSelectedItems, selectedItem) {
                        selectedStreamingPlatform = allSelectedItems;
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "And also...",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    MultiSelectContainer(
                      itemsDecoration: MultiSelectDecorations(
                        selectedDecoration: BoxDecoration(
                            color: ColorSys.ksecondary,
                            border: Border.all(color: ColorSys.ksecondary),
                            borderRadius: BorderRadius.circular(20)),
                        decoration: BoxDecoration(
                          color: ColorSys.kgrey,
                          border: Border.all(color: ColorSys.kgrey),
                          borderRadius: BorderRadius.circular(20),
                        ),
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
                        MultiSelectCard(
                            value: '< 95 minutues', label: '< 95 minutues'),
                        MultiSelectCard(value: '< 2 Hours', label: '< 2 Hours'),
                        MultiSelectCard(value: '2020s', label: '2020s'),
                        MultiSelectCard(value: '2010s', label: '2010s'),
                        MultiSelectCard(value: '2000s', label: '2000s'),
                        MultiSelectCard(value: '1990s', label: '1990s'),
                        MultiSelectCard(value: '1980s', label: '1980s'),
                        MultiSelectCard(value: '1970s', label: '1970s'),
                        MultiSelectCard(value: '1960s', label: '1960s'),
                        MultiSelectCard(value: 'G Rated', label: 'G Rated'),
                        MultiSelectCard(value: 'PG Rated', label: 'PG Rated'),
                        MultiSelectCard(value: 'PG-13', label: 'PG-13'),
                        MultiSelectCard(value: 'R/TV-MA', label: 'R/TV-MA')
                      ],
                      highlightColor: ColorSys.ksecondary,
                      splashColor: ColorSys.kgrey,
                      onChange: (allSelectedItems, selectedItem) {
                        selectedStreamingPlatform = allSelectedItems;
                      },
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    ThemeButton(
                      name: "Continue",
                      onPressed: signUpWithEmailAndPassword,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void signUpWithEmailAndPassword() {
    context.read<AuthenticationBloc>().add(
          AuthRegisterRequested(
            username: widget.username,
            email: widget.email,
            password: widget.password,
            selectedGenre: selectedGenre,
            selectedStreamingPlatform: selectedStreamingPlatform,
            selectedOtherDetails: selectedOtherDetails,
          ),
        );
    return;
  }
}

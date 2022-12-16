import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
          appBarTheme: super.appBarTheme(context).appBarTheme.copyWith(
                elevation: 1.0,
              ),
        );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => close(context, null),
        child: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: FaIcon(
            FontAwesomeIcons.arrowLeftLong,
            size: 23,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Center(
      child: Text('Results'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text('Suggestions');
  }
}

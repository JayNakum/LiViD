import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  final _searchController = TextEditingController();
  final void Function(String userName) search;
  Search(this.search);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Expanded(
        child: TextField(
          // onSubmitted: (value) {
          //   _userName = value;
          // },
          controller: _searchController,
          keyboardType: TextInputType.name,
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
            return search(_searchController.text);
          },
          decoration: InputDecoration(
            filled: true,
            hintText: 'Search',
            // hintStyle: Theme.of(context).textTheme.headline3,
            suffixIcon: Icon(
              Icons.search_rounded,
              color: Colors.orange,
            ),

            fillColor: Colors.amber,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

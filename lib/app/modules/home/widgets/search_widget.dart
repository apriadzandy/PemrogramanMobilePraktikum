// lib/modules/home/widgets/search_widget.dart
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearch;

  SearchWidget({required this.searchController, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ),
        onChanged: (value) {
          onSearch(value);  // Fungsi search dipanggil saat teks berubah
        },
      ),
    );
  }
}

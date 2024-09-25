import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quadb_project/constants/test_style.dart';
import 'package:quadb_project/controller/home_screen_controller.dart';
import 'package:quadb_project/screens/details_screen.dart';
import 'package:quadb_project/widgets/loading_indicator.dart';

class HomeScreen extends StatelessWidget {
  final ApiController showController = Get.put(ApiController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF66CDAA),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildGridBody(),
        ],
      ),
    );
  }

  Widget _buildGridBody() {
    return Expanded(
      child: Obx(() {
        if (showController.isLoading.value) {
          return const Center(child: LoadingIndicator());
        }

        var filteredShows = showController.filteredShows.isNotEmpty
            ? showController.filteredShows
            : showController.shows;

        if (filteredShows.isEmpty) {
          return const Center(
              child: Text('No shows found',
                  style: TextStyle(color: Colors.white)));
        }

        return ListView.builder(
          itemCount: filteredShows.length,
          itemBuilder: (context, index) {
            var show = filteredShows[index]['show'];
            return Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: show['image'] != null
                    ? Image.network(show['image']['medium'])
                    : const Icon(Icons.image_not_supported),
                title: Text(show['name']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Genres: ${show['genres'].join(', ')}'),
                    Text('Rating: ${show['rating']['average'] ?? 'N/A'}'),
                    Text('Status: ${show['status']}'),
                    Text(
                        'Schedule: ${show['schedule']['days'].join(', ')} at ${show['schedule']['time']}'),
                  ],
                ),
                onTap: () {
                  Get.to(ShowDetailScreen(show: show));
                },
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        onChanged: (value) {
          showController.filterShows(value);
        },
        decoration: InputDecoration(
          hintText: 'Search Screen',
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          filled: true,
          fillColor: Colors.white.withOpacity(0.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(color: Colors.white70),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: const Text(
        'Home Screen',
        style: TStyle.homeText,
      ),
      centerTitle: true,
    );
  }
}

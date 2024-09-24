import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quadb_project/constants/urls.dart';

class ApiController extends GetxController {
  var shows = [].obs;
  var filteredShows = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchShows();
    super.onInit();
  }

  void fetchShows() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse(Urls.homeUrl));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        shows.value = data;
        filteredShows.clear();
      } else {}
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  void filterShows(String query) {
    if (query.isEmpty) {
      filteredShows.clear();
    } else {
      filteredShows.value = shows
          .where((show) =>
              show['show']['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}

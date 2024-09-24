import 'package:flutter/material.dart';

class ShowDetailScreen extends StatelessWidget {
  final Map<String, dynamic> show;

  const ShowDetailScreen({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(show['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            show['image'] != null
                ? Image.network(show['image']['original'])
                : Container(height: 200, color: Colors.grey),
            const SizedBox(height: 10),
            Text(show['name'],
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Genres: ${show['genres'].join(', ')}'),
            Text('Language: ${show['language']}'),
            Text('Status: ${show['status']}'),
            Text('Premiered: ${show['premiered'] ?? 'N/A'}'),
            const SizedBox(height: 10),
            const Text('Summary:'),
            const SizedBox(height: 5),
            Text(show['summary']?.replaceAll(RegExp(r'<[^>]*>'), '') ??
                'No summary available.'),
          ],
        ),
      ),
    );
  }
}

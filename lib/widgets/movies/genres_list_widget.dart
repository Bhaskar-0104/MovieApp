import 'package:flutter/material.dart';

class GenresListWidget extends StatelessWidget {
  const GenresListWidget({super.key, required this.genres});

  final List<String> genres;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        genres.length,
        (index) => chipWidget(
          context: context,
          genreName: genres[index],
        ),
      ),
    );
  }

  Widget chipWidget({
    required BuildContext context,
    required String genreName,
  }) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.2),
          border: Border.all(color: Theme.of(context).colorScheme.surface),
        ),
        child: Text(
          genreName,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

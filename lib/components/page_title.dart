import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
          const Text("Pagina / ", 
          style: TextStyle(
            color: Colors.white
          ),
          ),
          Text(title,
          style: const TextStyle(
            color: Colors.white
          ),
          ),
            ],
          ),
          Text(title, style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),),
        ],
      );
  }
}
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  const MenuItem(
      {required this.icon,
      required this.onPressed,
      required this.title,
      super.key});

  final String title;
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Center(
          child: TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 25, right: 10),
            ),
            onPressed: () {
              onPressed();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              Icon(icon),
              const SizedBox(width: 10),
              Text(title),
            ]),
          ),
        ));
  }
}

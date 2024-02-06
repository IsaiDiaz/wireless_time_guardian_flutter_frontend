import 'package:flutter/material.dart';

class EmployeTableElement extends StatelessWidget {
  const EmployeTableElement({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
            width: 0.8,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              width: 100,
              padding: const EdgeInsets.all(10),
              child: const Text('Nombre'),
            ),
            Container(
              width: 100,
              padding: const EdgeInsets.all(10),
              child: const Text('Apellido'),
            ),
            Container(
              width: 100,
              padding: const EdgeInsets.all(10),
              child: const Text('DNI'),
            ),
            Container(
              width: 100,
              padding: const EdgeInsets.all(10),
              child: const Text('Email'),
            ),
            Container(
              width: 100,
              padding: const EdgeInsets.all(10),
              child: const Text('Telefono'),
            ),
            Container(
              width: 100,
              padding: const EdgeInsets.all(10),
              child: const Text('Proyecto'),
            ),
          ],
        ),
      )
    );
  }
}
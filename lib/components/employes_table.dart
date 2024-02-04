import 'package:flutter/material.dart';

class EmployesTable extends StatelessWidget {
  const EmployesTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text("Employes Table"),
    );
  }
}
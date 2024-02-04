import 'package:flutter/material.dart';
import 'package:wireless_time_guardian_flutter_frontend/components/employes_table.dart';
import 'package:wireless_time_guardian_flutter_frontend/components/page_title.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        PageTitle(title: "Inicio"),
        SizedBox(height: 20),
        EmployesTable(),
        SizedBox(height: 20),
        EmployesTable()
      ],
    );
  }
}
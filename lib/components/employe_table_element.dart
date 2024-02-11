import 'package:flutter/material.dart';

class EmployeTableElement extends StatelessWidget {
  const EmployeTableElement({this.name, this.lastname, this.dni, this.email, this.telefono, this.proyecto, super.key});

  final String? name;
  final String? lastname;
  final String? dni;
  final String? email;
  final String? telefono;
  final String? proyecto;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
            width: 0.8,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name!),
          Text(lastname!),
          Text(dni!),
          Text(email!),
          Text(telefono!),
          Text(proyecto!),
        ],
      )
    );
  }
}
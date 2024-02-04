import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/page_bloc.dart';
import 'package:wireless_time_guardian_flutter_frontend/components/menu_item.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.98,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Wireless Time Guardian',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
          ),
          const Divider(
            endIndent: 20,
            indent: 20,
            color: Color.fromARGB(103, 80, 80, 80),
            thickness: 0.8,
          ),
          MenuItem(
              title: "Inicio",
              icon: Icons.home,
              onPressed: () {
                BlocProvider.of<PageBloc>(context).add(ChangePageEvent(0));
              }),
          MenuItem(
              icon: Icons.auto_awesome_motion_rounded,
              onPressed: () {
                BlocProvider.of<PageBloc>(context).add(ChangePageEvent(1));
              },
              title: "Proyectos"),
          MenuItem(
              icon: Icons.person,
              onPressed: () {
                BlocProvider.of<PageBloc>(context).add(ChangePageEvent(2));
              },
              title: "Empleados"),
          MenuItem(
              icon: Icons.contactless_rounded,
              onPressed: () {
                BlocProvider.of<PageBloc>(context).add(ChangePageEvent(3));
              },
              title: "RFID"),
        ],
      ),
    );
  }
}

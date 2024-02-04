import 'package:flutter/material.dart';
import 'package:wireless_time_guardian_flutter_frontend/components/page_title.dart';

class RFID extends StatelessWidget {
  const RFID({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        PageTitle(title: "RFID")
      ],
    );
  }
}
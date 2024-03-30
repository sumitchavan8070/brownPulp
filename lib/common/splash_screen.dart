import 'package:flutter/material.dart';
import 'package:project/utilities/theme/app_colors.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.zircon,
        child: const Center(
          child: Text("Dashboard Screen"),
        ),
      ),
    );
  }
}

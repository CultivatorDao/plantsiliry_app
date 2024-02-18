import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class ChasingDotsLoading extends StatelessWidget {
  const ChasingDotsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitChasingDots(
        color: Color.fromARGB(255, 44, 94, 70),
        size: 50.0,
      ),
    );
  }
}

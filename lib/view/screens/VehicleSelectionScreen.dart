import 'dart:math';

import 'package:cos_challenge/core/constants/colors.dart';
import 'package:cos_challenge/core/models/vehicle.dart';
import 'package:cos_challenge/core/models/vehicle_choice.dart';
import 'package:cos_challenge/view/widgets/vehicle_widget.dart';
import 'package:flutter/material.dart';

class VehicleSelectionScreen extends StatelessWidget {
  const VehicleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicleData =
        ModalRoute.of(context)!.settings.arguments as List<VehicleChoice>;

    final int highestSimilarity = vehicleData.fold<int>(
      0,
      (max, vehicle) => vehicle.similarity > max ? vehicle.similarity : max,
    );

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: const Text('Select a Vehicle'),
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: ListView.builder(
        itemCount: vehicleData.length,
        itemBuilder: (context, index) {
          final vehicle = vehicleData[index];
          final isBestChoice = vehicle.similarity == highestSimilarity;

          return VehicleWidget(vehicle: vehicle, isBestChoice: isBestChoice);
        },
      ),
    );
  }
}

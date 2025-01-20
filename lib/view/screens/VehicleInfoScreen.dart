import 'package:cos_challenge/core/constants/colors.dart';
import 'package:cos_challenge/core/models/vehicle.dart';
import 'package:flutter/material.dart';

class VehicleInfoScreen extends StatelessWidget {
  const VehicleInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicleData =
        ModalRoute.of(context)!.settings.arguments as VehicleModel;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: const Text('Vehicle Information'),
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: Center(
        child: Card(
          color: AppColors.secondaryColor,
          elevation: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network('https://picsum.photos/id/111/200/300',
                        height: 350, fit: BoxFit.cover)),
                const SizedBox(height: 10),
                Text(
                  vehicleData.make,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Model: ${vehicleData.model}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Price: \$${vehicleData.price}',
                  style: const TextStyle(fontSize: 16, color: Colors.green),
                ),
                const SizedBox(height: 10),
                Text(
                  'UUID: ${vehicleData.fkUuidAuction}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

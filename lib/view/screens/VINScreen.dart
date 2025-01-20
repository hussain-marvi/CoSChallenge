import 'dart:convert';

import 'package:cos_challenge/core/bloc/vehicle_bloc.dart';
import 'package:cos_challenge/core/constants/colors.dart';
import 'package:cos_challenge/core/exceptions/network_exception.dart';
import 'package:cos_challenge/core/models/vehicle.dart';
import 'package:cos_challenge/core/models/vehicle_choice.dart';
import 'package:cos_challenge/core/utils/storage_utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class VINScreen extends StatefulWidget {
  const VINScreen({super.key});

  @override
  State<VINScreen> createState() => _VINScreenState();
}

class _VINScreenState extends State<VINScreen> {
  final TextEditingController _vinController = TextEditingController();
  final VehicleBloc _vehicleBloc = VehicleBloc();

  @override
  void dispose() {
    _vinController.dispose();
    _vehicleBloc.dispose();
    super.dispose();
  }

  void _fetchVehicleData() async {
    final vin = _vinController.text;
    if (vin.length == 17) {
      try {
        await _vehicleBloc.fetchVehicleData(
            vin, StorageUtility().getData('uniqueID') ?? 'someUniqueId');
      } on NetworkException catch (e) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message),
              backgroundColor: Colors.red,
            ),
          );
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('VIN must be 17 characters long.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/images/caronsale_logo.jpg',
              height: 120,
              width: 120,
            ),
            const SizedBox(height: 80),
            const Text(
              'Vehicle Identification Number',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w600),
            ),
            const Text(
              'Enter Vehicle Identification Number',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 40),
            TextField(
              maxLength: 17,
              maxLines: 1,
              controller: _vinController,
              decoration: const InputDecoration(
                labelText: 'Vehicle Identification Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor,
                textStyle: const TextStyle(color: Colors.white),
              ),
              onPressed: _fetchVehicleData,
              child: const Text('Submit'),
            ),
            const SizedBox(height: 10),
            StreamBuilder(
              stream: _vehicleBloc.vehicleStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  _displayTimedOutErrorDialog(context);
                  return Container();
                } else if (snapshot.hasData) {
                  Response response = (snapshot.data as Response);
                  if (response.statusCode == 200) {
                    try {
                      _navigateToVehicleInfoScreen(
                          jsonDecode(response.body), context);
                    } on FormatException {
                      //display and handle potential errors like deserialization
                      _displayInternalServerErrorDialog(context);
                    }
                    return Container();
                  } else if (response.statusCode == 300) {
                    try {
                      _navigateToVehicleSelectionScreen(
                          jsonDecode(response.body), context);
                    } on FormatException {
                      //display and handle potential errors like deserialization
                      _displayInternalServerErrorDialog(context);
                    }
                    return Container();
                  }
                  return Text(
                      'Our system is under maintainance. ${jsonDecode(response.body)['message']}');
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToVehicleSelectionScreen(dynamic json, BuildContext context) {
    List<VehicleChoice> vch =
        List.generate((json as List<dynamic>).length, (index) {
      return VehicleChoice.fromJson((json as List<dynamic>)[index]);
    });
    //If you receive a status code 300 in the second step, show the user the options for selecting the correct vehicle.
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Navigator.pushNamed(context, '/vehicle_selection', arguments: vch));
  }

  void _navigateToVehicleInfoScreen(dynamic json, BuildContext context) {
    VehicleModel vm = VehicleModel.fromJson(json);
    //save the data persistently and locally, then navigate the user to step 5.
    StorageUtility().saveData('vehicle', json).then((_) => {
          WidgetsBinding.instance.addPostFrameCallback((_) =>
              Navigator.pushNamed(context, '/vehicle_info', arguments: vm))
        });
  }
}

void _displayTimedOutErrorDialog(BuildContext context) {
  return WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text(
              'Session Timed Out',
              style: TextStyle(color: AppColors.primaryColor),
            ),
            content: const Text(
              'Your session has timed out.',
              style: TextStyle(color: AppColors.primaryColor),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  StorageUtility().clearAllData().then((_) =>
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushReplacementNamed(context, '/identity');
                      }));
                }, // passing false
                child: const Text('OK'),
              ),
            ],
          );
        });
  });
}

void _displayInternalServerErrorDialog(BuildContext context) {
  return WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text(
              '500 Internal Server Error',
              style: TextStyle(color: AppColors.primaryColor),
            ),
            content: const Text(
              'Uh Oh! Something went wrong. Please contact our customer support.',
              style: TextStyle(color: AppColors.primaryColor),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                }, // passing false
                child: const Text('OK'),
              ),
            ],
          );
        });
  });
}

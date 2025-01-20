import 'dart:math';

import 'package:cos_challenge/core/models/vehicle.dart';
import 'package:cos_challenge/core/models/vehicle_choice.dart';
import 'package:flutter/material.dart';

class VehicleWidget extends StatelessWidget {
  const VehicleWidget({
    super.key,
    required this.vehicle,
    required this.isBestChoice,
  });

  final VehicleChoice vehicle;
  final bool isBestChoice;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            'https://picsum.photos/id/111/200/300',
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          '${vehicle.make} ${vehicle.model}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          'Similarity: ${vehicle.similarity}%',
        ),
        trailing: isBestChoice
            ? const Chip(
                label: Text(
                  'Best Match',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              )
            : null,
        onTap: () {
          // Handle vehicle selection
          Navigator.pushNamed(context, '/vehicle_info',
              arguments: VehicleModel(
                  id: Random().nextInt(1000000),
                  feedback: "Please modify the price.",
                  valuatedAt: DateTime.parse('2023-01-05T14:08:40.456Z'),
                  requestedAt: DateTime.parse('2023-01-05T14:08:40.456Z'),
                  createdAt: DateTime.parse('2023-01-05T14:08:40.456Z'),
                  updatedAt: DateTime.parse('2023-01-05T14:08:42.153Z'),
                  make: "Toyota",
                  model: "GT 86 Basis",
                  externalId: "DE003-018601450020008",
                  fkSellerUser: "25475e37-6973-483b-9b15-cfee721fc29f",
                  price: Random().nextInt(1000),
                  positiveCustomerFeedback: Random().nextBool(),
                  fkUuidAuction: "3e255ad2-36d4-4048-a962-5e84e27bfa6e",
                  inspectorRequestedAt:
                      DateTime.parse("2023-01-05T14:08:40.456Z"),
                  origin: "AUCTION",
                  estimationRequestId: "3a295387d07f"));
        },
      ),
    );
  }
}

import 'dart:async';
import 'package:cos_challenge/core/exceptions/network_exception.dart';
import 'package:cos_challenge/core/services/network_service.dart';

import '../services/http_client.dart';

class VehicleBloc {
  final _vehicleController = StreamController<dynamic>();

  Stream<dynamic> get vehicleStream => _vehicleController.stream;

  Future<dynamic> fetchVehicleData(String vin, String userId) async {
    final isConnected = await ConnectivityService.isConnected();
    if (!isConnected) {
      throw NetworkException('No Internet Available');
    }

    try {
      final data = await HttpClient.httpClient
          .get(Uri.https('anyUrl'), headers: {HttpClient.user: userId});
      _vehicleController.sink.add(data);
    } catch (e) {
      _vehicleController.sink.addError(e);
    }
  }

  void dispose() {
    _vehicleController.close();
  }
}

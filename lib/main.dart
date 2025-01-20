import 'package:cos_challenge/core/constants/theme.dart';
import 'package:cos_challenge/core/services/network_service.dart';
import 'package:cos_challenge/view/screens/UserIdentificationScreen.dart';
import 'package:cos_challenge/view/screens/VINScreen.dart';
import 'package:cos_challenge/view/screens/VehicleInfoScreen.dart';
import 'package:cos_challenge/view/screens/VehicleSelectionScreen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ConnectivityService().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: ConnectivityService().connectionStream,
        builder: (context, snapshot) {
          final isConnected = snapshot.data ?? true;
          return MaterialApp(
              title: 'Flutter Demo',
              theme: AppTheme.lightTheme,
              home: const UserIdentificationScreen(),
              initialRoute: '/identity',
              routes: {
                '/identity': (context) => const UserIdentificationScreen(),
                '/vehicle': (context) => const VINScreen(),
                '/vehicle_info': (context) => const VehicleInfoScreen(),
                '/vehicle_selection': (context) =>
                    const VehicleSelectionScreen(),
              },
              builder: (context, child) {
                if (!isConnected) {
                  return Stack(
                    children: [
                      child!,
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: MaterialBanner(
                          content: const Text(
                            'No Internet Connection',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                          actions: [
                            TextButton(
                                onPressed: () => {}, child: const Text(''))
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return child!;
              });
        });
  }
}

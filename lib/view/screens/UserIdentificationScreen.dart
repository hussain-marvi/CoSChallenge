import 'package:cos_challenge/core/constants/colors.dart';
import 'package:cos_challenge/core/utils/storage_utility.dart';
import 'package:flutter/material.dart';

class UserIdentificationScreen extends StatefulWidget {
  const UserIdentificationScreen({super.key});

  @override
  State<UserIdentificationScreen> createState() =>
      _UserIdentificationScreenState();
}

class _UserIdentificationScreenState extends State<UserIdentificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkForSavedID();
  }

  void _checkForSavedID() async {
    await StorageUtility().init();
    String? savedID = StorageUtility().getData('uniqueID');
    if (savedID != null) {
      // Navigate to the next screen if ID is already saved
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/vehicle');
    }
  }

  void _saveID() async {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      String enteredID = _idController.text;
      if (enteredID.isNotEmpty) {
        await StorageUtility().saveData('uniqueID', enteredID);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/vehicle');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Form(
          key: _formKey,
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
                'Identification',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w600),
              ),
              const Text(
                'Enter User Identification Number',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(
                  labelText: 'Unique ID',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter identification number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                    textStyle: const TextStyle(color: Colors.black)),
                onPressed: _saveID,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

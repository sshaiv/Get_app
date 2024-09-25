import 'package:doctor_app/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _selectedLocation;

  final List<String> _locations = [
    'Hospital1',
    'Hospital2',
    'Hospital3',
    'Hospital4',
    'Hospital5'
  ];

  @override
  void initState() {
    super.initState();
  }

Future<void> _login() async {
  final username = _usernameController.text;
  final password = _passwordController.text;
  final location = _selectedLocation ?? 'Not selected';
  setState(() {
    _isLoading = true;
  });

  try {
    final response = await http.get(
      Uri.parse(
          'https://doctorapi.medonext.com/api/UserCred/GetUserLogin?JsonOrg={"loginid":"$username","pwd":"$password"}'),
    );
    
    print('Username: $username');
    print('Password: $password');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(jsonDecode(response.body));
      print('Response data: $data');

      // Assuming the empid is in the first item of the "Table" array
      final empid = data['Table'][0]['empid'];
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            username: username,
            empid: empid, 
          ),
        ),
      );

      _usernameController.clear();
      _passwordController.clear();
      setState(() {
        _selectedLocation = null; 
      });

      if (data['success'] == true) {
        final token = data['token'];
        print("Token :$token");

        print('Username: $username');
        print('Token: $token');
        print('Location: $location');
        print('Emp ID: $empid'); 
      }
    } else {
      _showErrorDialog('Failed to login with status code ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e'); 
    _showErrorDialog('Invalid Username or Password.');
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}



  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.black.withOpacity(0.3), 
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Container(
                color: Colors.white.withOpacity(0.2), 
                height: 500, 
                constraints: const BoxConstraints(maxWidth: 400),
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(
                        'assets/images/medonextlogo.png',
                        width: 200,
                      ),
                    ),
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      value: _selectedLocation,
                      hint: const Text('Select Location'),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedLocation = newValue;
                        });
                      },
                      items: _locations.map<DropdownMenuItem<String>>((String location) {
                        return DropdownMenuItem<String>(
                          value: location,
                          child: Text(location),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.location_on),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
                        backgroundColor: Colors.red[400],
                        textStyle: const TextStyle(fontSize: 18.0),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




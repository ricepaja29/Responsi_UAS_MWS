import 'package:flutter/material.dart';
import 'package:sewamotorapp/screens/motor_page_screen.dart';
import 'package:sewamotorapp/screens/profile_page_screen.dart'; // Import halaman ProfilePage

class DashboardMotorScreen extends StatefulWidget {
  @override
  _DashboardMotorScreenState createState() => _DashboardMotorScreenState();
}

class _DashboardMotorScreenState extends State<DashboardMotorScreen> {
  final List<Map<String, dynamic>> _motors = [
    {
      'name': 'Honda Beat',
      'type': 'Matic',
      'price': 50000,
      'available': true,
      'image': 'assets/images/honda_beat.png'
    },
    {
      'name': 'Yamaha NMAX',
      'type': 'Matic',
      'price': 80000,
      'available': true,
      'image': 'assets/images/yamaha_nmax.png'
    },
    {
      'name': 'Honda Vario',
      'type': 'Matic',
      'price': 60000,
      'available': false,
      'image': 'assets/images/honda_vario.png'
    },
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // List of widget options for each tab
    final List<Widget> _pages = [
      buildHomePage(),
      buildMotorPage(),
      ProfilePage(), // Mengarahkan ke halaman profil yang dibuat
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Sewa Motor'),
        backgroundColor: Colors.blue[800],
        centerTitle: true,
      ),
      body: _pages[_selectedIndex], // Switch between pages
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.motorcycle),
            label: 'Motor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
      ),
    );
  }

  // Function to build Home Page content
  Widget buildHomePage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('POPULAR BIKES:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _motors.length,
              itemBuilder: (context, index) {
                final motor = _motors[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          motor['image'],
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 10),
                        Text(
                          motor['name'],
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${motor['type']} - Rp ${motor['price']}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('NEW RENTALS:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('sewa motor jogja & Bike Rental', textAlign: TextAlign.center),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Sewa Motor Jogja - Dewa Motor', textAlign: TextAlign.center),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('SALE!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: TextButton(
              onPressed: () {},
              child: Text('All available bikes >', style: TextStyle(color: Colors.blue)),
            ),
          ),
        ],
      ),
    );
  }

  // Function to build Motor Page content
  Widget buildMotorPage() {
    return MotorPageScreen();
  }
}

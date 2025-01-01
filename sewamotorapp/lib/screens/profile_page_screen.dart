import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.blue[800],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/profile_picture.png'), // Ganti dengan gambar profil
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Ricep Ardiansyah', // Ganti dengan nama pengguna
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '5220411357', // Ganti dengan NPM pengguna
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Profile Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.email, color: Colors.blue[800]),
                    title: Text('Email'),
                    subtitle: Text('ricep@example.com'), // Ganti dengan email pengguna
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.phone, color: Colors.blue[800]),
                    title: Text('Phone'),
                    subtitle: Text('+62 812 3456 7890'), // Ganti dengan nomor telepon pengguna
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.location_on, color: Colors.blue[800]),
                    title: Text('Address'),
                    subtitle: Text('Cilograng, Banten, Indonesia'), // Ganti dengan alamat pengguna
                  ),
                  Divider(),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Tambahkan logika untuk Edit Profile
                      print('Edit Profile clicked');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text('Edit Profile',
                    style: TextStyle(
                      color: Colors.white
                    ),),
                  ),
                  SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {
                      // Tambahkan logika untuk Logout
                      print('Logout clicked');
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      side: BorderSide(color: Colors.red),
                    ),
                    child: Text('Logout', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
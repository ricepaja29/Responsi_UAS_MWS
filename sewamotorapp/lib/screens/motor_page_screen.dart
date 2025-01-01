import 'package:flutter/material.dart';
import 'package:sewamotorapp/service/motor_service.dart';

class MotorPageScreen extends StatefulWidget {
  @override
  _MotorPageScreenState createState() => _MotorPageScreenState();
}

class _MotorPageScreenState extends State<MotorPageScreen> {
  final MotorService _motorService = MotorService();
  List<Map<String, dynamic>> motors = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadMotors();
  }

  void _loadMotors() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    try {
      List<Map<String, dynamic>> motorData = await _motorService.getMotors();
      setState(() {
        motors = motorData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Gagal memuat data motor: $e';
        isLoading = false;
      });
    }
  }

  void _addMotor(Map<String, dynamic> motor) async {
    try {
      await _motorService.addMotor(motor);
      _loadMotors();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menambahkan motor: $e')),
      );
    }
  }

  void _editMotor(int id, Map<String, dynamic> updatedMotor) async {
    try {
      await _motorService.editMotor(id, updatedMotor);
      _loadMotors();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengedit motor: $e')),
      );
    }
  }

  void _deleteMotor(int id) async {
    try {
      await _motorService.deleteMotor(id);
      _loadMotors();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus motor: $e')),
      );
    }
  }

  void _showMotorForm({Map<String, dynamic>? motor}) {
    final nameController = TextEditingController(text: motor?['name'] ?? '');
    final typeController = TextEditingController(text: motor?['type'] ?? '');
    final yearController = TextEditingController(text: motor?['year']?.toString() ?? '');
    final priceController = TextEditingController(text: motor?['price']?.toString() ?? '');
    final descriptionController = TextEditingController(text: motor?['description'] ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(motor == null ? 'Tambah Motor' : 'Edit Motor'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Nama Motor'),
                ),
                TextField(
                  controller: typeController,
                  decoration: InputDecoration(labelText: 'Tipe Motor'),
                ),
                TextField(
                  controller: yearController,
                  decoration: InputDecoration(labelText: 'Tahun'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: 'Harga Sewa'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Deskripsi'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final newMotor = {
                  'name': nameController.text,
                  'type': typeController.text,
                  'year': int.tryParse(yearController.text) ?? 0,
                  'price': int.tryParse(priceController.text) ?? 0,
                  'description': descriptionController.text,
                };

                if (motor == null) {
                  _addMotor(newMotor);
                } else {
                  _editMotor(motor['id'], newMotor);
                }

                Navigator.of(context).pop();
              },
              child: Text(motor == null ? 'Tambah' : 'Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Motor'),
        backgroundColor: Colors.indigo,
        automaticallyImplyLeading: false, // This removes the back arrow
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : motors.isEmpty
                  ? Center(child: Text('Tidak ada data motor'))
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          int crossAxisCount = (constraints.maxWidth / 160).floor(); // Adjusted for smaller cards
                          crossAxisCount = crossAxisCount > 0 ? crossAxisCount : 1;

                          return GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.75, // Adjusted for smaller aspect ratio
                            ),
                            itemCount: motors.length,
                            itemBuilder: (context, index) {
                              final motor = motors[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                                        color: Colors.indigoAccent,
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            motor['name'],
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14, // Smaller font size
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Tipe: ${motor['type']}'),
                                          Text('Tahun: ${motor['year']}'),
                                          Text('Harga: Rp ${motor['price']}/hari'),
                                          SizedBox(height: 4),
                                          Text(
                                            'Deskripsi: ${motor['description']}',
                                            style: TextStyle(fontSize: 12, color: Colors.grey),
                                            maxLines: 2, // Limit to 2 lines
                                            overflow: TextOverflow.ellipsis, // Truncate if the description is too long
                                          ),
                                        ],
                                      ),
                                    ),
                                    ButtonBar(
                                      alignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.edit, color: Colors.blue),
                                          onPressed: () {
                                            _showMotorForm(motor: motor);
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete, color: Colors.red),
                                          onPressed: () {
                                            _deleteMotor(motor['id']);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showMotorForm();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.indigo,
      ),
    );
  }
}

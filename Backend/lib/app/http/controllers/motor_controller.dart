import 'dart:io';
import 'package:backend/app/models/motor.dart';
import 'package:vania/vania.dart';

class MotorController extends Controller {
  // Menampilkan semua data motor
  Future<Response> index() async {
    var motors = await Motor().query().get();
    return Response.json({
      "message": "Data motor berhasil diambil",
      "data": motors,
    }, HttpStatus.ok);
  }

  // Menyimpan data motor baru
  Future<Response> store(Request request) async {
    request.validate({
      'name': 'required',
      'type': 'required',
      'year': 'required|numeric',
      'price': 'required|numeric',
      'description': 'required',
    }, {
      'name.required': 'Nama harus diisi',
      'type.required': 'Tipe motor harus diisi',
      'year.required': 'Tahun harus diisi',
      'year.numeric': 'Tahun harus berupa angka',
      'price.required': 'Harga harus diisi',
      'price.numeric': 'Harga harus berupa angka',
      'description.required': 'Deskripsi harus diisi',
    });

    // Ambil data dari request
    var requestData = request.input();

    // Simpan data ke database
    await Motor().query().insert(requestData);

    return Response.json({
      "message": "Motor berhasil ditambahkan",
      "data": requestData,
    }, HttpStatus.created);
  }

  // Menampilkan detail data motor berdasarkan ID
  Future<Response> show(int id) async {
    var motor = await Motor().query().find(id);
    if (motor == null) {
      return Response.json({
        "message": "Motor tidak ditemukan",
      }, HttpStatus.notFound);
    }

    return Response.json({
      "message": "Data motor berhasil diambil",
      "data": motor,
    }, HttpStatus.ok);
  }

  // Memperbarui data motor berdasarkan ID
  Future<Response> update(Request request, int id) async {
    request.validate({
      'name': 'required',
      'type': 'required',
      'year': 'required|numeric',
      'price': 'required|numeric',
      'description': 'required',
    }, {
      'name.required': 'Nama harus diisi',
      'type.required': 'Tipe motor harus diisi',
      'year.required': 'Tahun harus diisi',
      'year.numeric': 'Tahun harus berupa angka',
      'price.required': 'Harga harus diisi',
      'price.numeric': 'Harga harus berupa angka',
      'description.required': 'Deskripsi harus diisi',
    });

    // Cari motor berdasarkan ID
    var motor = await Motor().query().find(id);
    if (motor == null) {
      return Response.json({
        "message": "Motor tidak ditemukan",
      }, HttpStatus.notFound);
    }

    // Ambil data dari request
    var requestData = request.input();
    requestData.remove('id'); // Hapus ID agar tidak ikut di-update

    // Update data motor berdasarkan ID
    var updated = await Motor()
        .query()
        .where('id', id.toString())
        .update(requestData);

    // Jika tidak ada perubahan
    if (updated == 0) {
      return Response.json({
        "message": "Tidak ada perubahan pada motor",
      }, HttpStatus.ok);
    }

    // Ambil data terbaru setelah update
    var updatedMotor = await Motor().query().find(id);

    return Response.json({
      "message": "Motor berhasil diperbarui",
      "data": updatedMotor,
    }, HttpStatus.ok);
  }

  // Menghapus data motor berdasarkan ID
  Future<Response> destroy(int id) async {
    var motor = await Motor().query().find(id);
    if (motor == null) {
      return Response.json({
        "message": "Motor tidak ditemukan",
      }, HttpStatus.notFound);
    }

    // Hapus data motor
    await Motor().query().delete(id);

    return Response.json({
      "message": "Motor berhasil dihapus"
    }, HttpStatus.ok);
  }
}

final MotorController motorController = MotorController();

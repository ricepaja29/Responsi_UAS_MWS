import 'package:vania/vania.dart';

class CreateMotorsTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('motors', () {
      bigIncrements('id');
      primary('id'); // Membuat id sebagai auto-increment
      string('name'); // Nama motor
      string('type');
      integer('year'); // Tipe motor (contoh: matic, manual)
      integer('price'); // Harga sewa per hari
      text('description'); // Deskripsi motor
      timeStamps(); // created_at dan updated_at
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('motors'); // Menghapus tabel jika ada
  }
}

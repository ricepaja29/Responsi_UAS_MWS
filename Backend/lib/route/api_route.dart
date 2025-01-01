import 'package:backend/app/http/controllers/auth_controller.dart';
import 'package:backend/app/http/controllers/user_controller.dart';
import 'package:backend/app/http/controllers/motor_controller.dart';
import 'package:backend/app/http/middleware/authenticate.dart';
import 'package:vania/vania.dart';

class ApiRoute implements Route {
  @override
  void register() {
    /// Base RoutePrefix
    Router.basePrefix('api');

    // Auth routes
    Router.group(() {
      Router.post('register', authController.register);
      Router.post('login', authController.login);
    }, prefix: 'auth');

    // User routes
    Router.group(() {
      Router.get('me', userController.index);
    }, prefix: 'user', middleware: [AuthenticateMiddleware()]);

    // Motor routes
    Router.group(() {
      Router.get('/', motorController.index);            // GET semua motor
      Router.post('/', motorController.store);           // POST tambah motor
      Router.get('/{id}', motorController.show);         // GET detail motor
      Router.put('/{id}', motorController.update);       // PUT update motor
      Router.delete('/{id}', motorController.destroy);   // DELETE hapus motor
    }, prefix: 'motors');
  }
}

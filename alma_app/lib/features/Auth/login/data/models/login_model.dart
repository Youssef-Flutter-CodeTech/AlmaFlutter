import '../../domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  LoginModel() : super();

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    // TODO: Map JSON to model
    return LoginModel();
  }
}

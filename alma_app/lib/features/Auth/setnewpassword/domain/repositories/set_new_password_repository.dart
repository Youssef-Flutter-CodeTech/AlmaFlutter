import '../entities/set_new_password_entity.dart';

abstract class SetNewPasswordRepository {
  Future<bool> setNewPassword(SetNewPasswordEntity entity);
}

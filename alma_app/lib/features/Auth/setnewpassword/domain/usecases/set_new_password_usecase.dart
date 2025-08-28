import '../entities/set_new_password_entity.dart';
import '../repositories/set_new_password_repository.dart';

class SetNewPasswordUseCase {
  final SetNewPasswordRepository repository;

  SetNewPasswordUseCase(this.repository);

  Future<bool> call(SetNewPasswordEntity entity) {
    return repository.setNewPassword(entity);
  }
}

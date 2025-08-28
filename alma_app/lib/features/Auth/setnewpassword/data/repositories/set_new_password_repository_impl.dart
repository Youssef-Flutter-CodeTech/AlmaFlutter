import '../../domain/entities/set_new_password_entity.dart';
import '../../domain/repositories/set_new_password_repository.dart';

class SetNewPasswordRepositoryImpl implements SetNewPasswordRepository {
  @override
  Future<bool> setNewPassword(SetNewPasswordEntity entity) async {
    // TODO: Implement actual API call
    // For now, simulate a successful response
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}

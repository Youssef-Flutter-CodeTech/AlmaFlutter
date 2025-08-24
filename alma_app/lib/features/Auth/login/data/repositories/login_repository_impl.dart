import '../../domain/repositories/login_repository.dart';
import '../datasources/login_remote_datasource.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl(this.remoteDataSource);

  // TODO: Implement repository logic
}

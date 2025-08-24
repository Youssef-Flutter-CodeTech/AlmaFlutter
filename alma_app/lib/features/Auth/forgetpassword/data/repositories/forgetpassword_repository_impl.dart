import '../../domain/repositories/forgetpassword_repository.dart';
import '../datasources/forgetpassword_remote_datasource.dart';

class ForgetpasswordRepositoryImpl implements ForgetpasswordRepository {
  final ForgetpasswordRemoteDataSource remoteDataSource;

  ForgetpasswordRepositoryImpl(this.remoteDataSource);

  // TODO: Implement repository logic
}

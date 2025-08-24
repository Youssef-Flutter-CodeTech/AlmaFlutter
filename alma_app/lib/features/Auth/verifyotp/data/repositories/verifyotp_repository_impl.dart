import '../../domain/repositories/verifyotp_repository.dart';
import '../datasources/verifyotp_remote_datasource.dart';

class VerifyotpRepositoryImpl implements VerifyotpRepository {
  final VerifyotpRemoteDataSource remoteDataSource;

  VerifyotpRepositoryImpl(this.remoteDataSource);

  // TODO: Implement repository logic
}

import '../../domain/repositories/singup_repository.dart';
import '../datasources/singup_remote_datasource.dart';

class SingupRepositoryImpl implements SingupRepository {
  final SingupRemoteDataSource remoteDataSource;

  SingupRepositoryImpl(this.remoteDataSource);

  // TODO: Implement repository logic
}

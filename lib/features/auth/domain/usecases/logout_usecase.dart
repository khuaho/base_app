import 'package:injectable/injectable.dart';
import 'package:base_app/features/auth/domain/repositories/auth_repository.dart';

@injectable
class LogoutUseCase {
  const LogoutUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call() => _repository.logout();
}

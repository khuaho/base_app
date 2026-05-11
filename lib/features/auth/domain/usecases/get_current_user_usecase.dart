import 'package:injectable/injectable.dart';
import 'package:base_app/features/auth/domain/entities/user_entity.dart';
import 'package:base_app/features/auth/domain/repositories/auth_repository.dart';

@injectable
class GetCurrentUserUseCase {
  const GetCurrentUserUseCase(this._repository);

  final AuthRepository _repository;

  Future<UserEntity?> call() => _repository.getCurrentUser();
}

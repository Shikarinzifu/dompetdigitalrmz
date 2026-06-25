import '../../repositories/auth_repository.dart';
import '../../entities/user_entity.dart';

class LoginWithEmailUsecase {
  final AuthRepository _repository;
  LoginWithEmailUsecase(this._repository);

  Future<({UserEntity user, String token})> call(String email, String password) {
    return _repository.loginWithEmail(email, password);
  }
}

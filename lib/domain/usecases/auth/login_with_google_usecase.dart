import '../../repositories/auth_repository.dart';
import '../../entities/user_entity.dart';

class LoginWithGoogleUsecase {
  final AuthRepository _repository;
  LoginWithGoogleUsecase(this._repository);

  Future<({UserEntity user, String token})> call() {
    return _repository.loginWithGoogle();
  }
}

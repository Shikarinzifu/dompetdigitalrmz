import '../../repositories/auth_repository.dart';
import '../../entities/user_entity.dart';

class RegisterWithOtpUsecase {
  final AuthRepository _repository;
  RegisterWithOtpUsecase(this._repository);

  Future<({UserEntity user, String token})> call({
    required String name,
    required String email,
    required String password,
  }) {
    return _repository.registerWithOtp(name: name, email: email, password: password);
  }
}

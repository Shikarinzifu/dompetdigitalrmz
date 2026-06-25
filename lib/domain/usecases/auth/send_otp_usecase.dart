import '../../repositories/otp_repository.dart';
import '../../entities/otp_entity.dart';

class SendOtpNotificationUsecase {
  final OtpRepository _repository;
  SendOtpNotificationUsecase(this._repository);
  Future<OtpSentEntity> call() => _repository.sendOtpNotification();
}

class SendOtpEmailUsecase {
  final OtpRepository _repository;
  SendOtpEmailUsecase(this._repository);
  Future<OtpSentEntity> call() => _repository.sendOtpEmail();
}

class ConfirmOtpUsecase {
  final OtpRepository _repository;
  ConfirmOtpUsecase(this._repository);
  Future<void> call({required String code, required String otpType}) =>
      _repository.confirmOtp(code: code, otpType: otpType);
}

class RegisterTotpUsecase {
  final OtpRepository _repository;
  RegisterTotpUsecase(this._repository);
  Future<TotpSetupEntity> call() => _repository.registerTotp();
}

class VerifyTotpUsecase {
  final OtpRepository _repository;
  VerifyTotpUsecase(this._repository);
  Future<bool> call(String code) => _repository.verifyTotp(code);
}

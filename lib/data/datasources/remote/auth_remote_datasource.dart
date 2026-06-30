import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<({UserModel user, String token})> loginWithEmail(String email, String password);
  Future<({UserModel user, String token})> loginWithGoogle();
  Future<({UserModel user, String token})> registerWithOtp({
    required String name,
    required String email,
    required String password,
  });
  Future<void> verifyEmailOtp(String code);
  Future<UserModel> getMe();
  Future<void> updateFcmToken(String fcmToken);
  void setAuthToken(String token);
  void clearAuthToken();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final ApiClient _client;
  final fb.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRemoteDatasourceImpl(this._client, this._firebaseAuth, this._googleSignIn);

  @override
  Future<({UserModel user, String token})> loginWithEmail(String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user == null) {
      throw Exception('Login Firebase gagal');
    }

    final firebaseToken = await credential.user!.getIdToken();

    final response = await _client.post(
      ApiEndpoints.login,
      data: {'firebase_token': firebaseToken},
    );
    final data = response['data'] as Map<String, dynamic>;
    final token = data['access_token'] as String;
    final user = UserModel.fromJson(data['user'] as Map<String, dynamic>);
    _client.setAuthToken(token);
    return (user: user, token: token);
  }

  @override
  Future<({UserModel user, String token})> loginWithGoogle() async {
    // Step 1: Sign in with Google
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception('Login Google dibatalkan');
    }

    // Step 2: Get authentication details
    final googleAuth = await googleUser.authentication;
    final credential = fb.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Step 3: Sign in to Firebase with Google credential
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    if (userCredential.user == null) {
      throw Exception('Login Firebase dengan Google gagal');
    }

    // Step 4: Get Firebase ID token
    final firebaseToken = await userCredential.user!.getIdToken();

    // Step 5: Send token to backend
    final response = await _client.post(
      ApiEndpoints.login,
      data: {'firebase_token': firebaseToken},
    );
    final data = response['data'] as Map<String, dynamic>;
    final token = data['access_token'] as String;
    final user = UserModel.fromJson(data['user'] as Map<String, dynamic>);
    _client.setAuthToken(token);
    return (user: user, token: token);
  }

  @override
  Future<({UserModel user, String token})> registerWithOtp({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user == null) {
      throw Exception('Registrasi Firebase gagal');
    }

    await credential.user!.updateDisplayName(name);

    final firebaseToken = await credential.user!.getIdToken();

    final response = await _client.post(
      ApiEndpoints.register,
      data: {'firebase_token': firebaseToken},
    );
    final data = response['data'] as Map<String, dynamic>;
    final token = data['access_token'] as String;
    final user = UserModel.fromJson(data['user'] as Map<String, dynamic>);
    _client.setAuthToken(token);
    return (user: user, token: token);
  }

  @override
  Future<void> verifyEmailOtp(String code) async {
    await _client.post(ApiEndpoints.verifyEmailOtp, data: {'code': code});
  }

  @override
  Future<UserModel> getMe() async {
    final response = await _client.get(ApiEndpoints.me);
    return UserModel.fromJson(response['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> updateFcmToken(String fcmToken) async {
    await _client.put(ApiEndpoints.fcmToken, data: {'fcm_token': fcmToken});
  }

  @override
  void setAuthToken(String token) {
    _client.setAuthToken(token);
  }

  @override
  void clearAuthToken() {
    _client.clearAuthToken();
  }
}

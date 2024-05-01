class AuthenticationService {
  Future<String> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return 'fake_token';
  }

  Future<String> register(String email, String password) async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return 'fake_token';
  }
}

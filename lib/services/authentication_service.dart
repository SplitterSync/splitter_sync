class AuthenticationService {
  Future<String> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return 'fake_token';
  }

  Future<String> register(String name, String email, String password) async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return 'fake_token';
  }
}

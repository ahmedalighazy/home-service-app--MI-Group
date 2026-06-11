/// Sign In Request Model - Data Layer
/// 
/// DTO for sign in API request
class SignInRequestModel {
  final String email;
  final String password;

  SignInRequestModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

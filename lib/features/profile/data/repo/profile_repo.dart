import '../../../../core/network/api_error_handler.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/api_service.dart';
import '../models/profile_model.dart';

class ProfileRepo {
  final ApiService _apiService;

  ProfileRepo(this._apiService);

  Future<ApiResult<ProfileModel>> getProfile(
    String email,
    String password,
  ) async {
    //Map<String, dynamic> map = {"email": email, "password": password};

    try {
      final response = await _apiService.getProfile();

      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  //exzample

  // class LoginCubit extends Cubit<LoginState> {
  //   LoginCubit(this._loginRepo) : super(LoginInitial());
  //   TextEditingController emailController = TextEditingController();
  //   TextEditingController passwordController = TextEditingController();
  //   GlobalKey<FormState> login = GlobalKey<FormState>();

  //   final LoginRepo _loginRepo;
  //   void emitLoginStates(BuildContext context) async {
  //     if (login.currentState!.validate()) {
  //       emit(LoginLoading());
  //       final response = await _loginRepo.login(
  //         emailController.text,
  //         passwordController.text,
  //       );

  //       response.when(
  //         success: (loginResponse) {
  //           if (!isClosed) emit(LoginSuccess(successString: ''));
  //         },
  //         failure: (error) {
  //           emit(LoginFailure(message: error.messege ?? ''));
  //         },
  //       );
  //     }
  //   }
  // }
}

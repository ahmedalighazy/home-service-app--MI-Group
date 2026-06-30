import '../../../../core/network/api_error_handler.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/api_service.dart';
import '../models/change_password_responses.dart';
import '../models/profile_responses.dart';
import '../models/update_responses.dart';

class ProfileRepo {
  final ApiService _apiService;

  ProfileRepo(this._apiService);

  // ======================== Get Profile =======================
  /// جلب بيانات البروفايل الخاصة بالمستخدم الحالي
  Future<ApiResult<ProfileResponses>> getProfile() async {
    try {
      final response = await _apiService.getProfile();
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  // ======================== Update Profile =======================
  /// تحديث بيانات البروفايل
  Future<ApiResult<UpdateResponses>> updateProfile({
    String? name,
    String? phone,
    String? bio,
    String? preferredLanguage,
  }) async {
    try {
      final Map<String, dynamic> body = {};
      if (name != null) body['name'] = name;
      if (phone != null) body['phone'] = phone;
      if (bio != null) body['bio'] = bio;
      if (preferredLanguage != null) body['preferredLanguage'] = preferredLanguage;

      final response = await _apiService.updateProfile(body);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  // ======================== Change Password =======================
  /// تغيير كلمة المرور
  Future<ApiResult<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _apiService.changePassword(
        ChangePasswordResponses(
          currentPassword: currentPassword,
          newPassword: newPassword,
        ),
      );
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  // ======================== Delete Account =======================
  /// حذف الحساب
  Future<ApiResult<void>> deleteAccount() async {
    try {
      await _apiService.deleteAccount();
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}

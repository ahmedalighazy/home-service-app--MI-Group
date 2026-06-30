// import 'package:dio/dio.dart';
// import '../../../../core/network/api_constants.dart';
// import '../models/profile_responses.dart';
// import '../models/update_responses.dart';

// /// خدمة الـ API الخاصة بالـ Profile
// /// تحتوي على كل الـ endpoints المتعلقة بالـ Profile
// class ProfileApiService {
//   final Dio _dio;

//   ProfileApiService(this._dio);

//   // ======================== Get Profile =======================
//   /// جلب بيانات البروفايل الخاصة بالمستخدم الحالي
//   Future<ProfileResponses> getProfile() async {
//     final response = await _dio.get(ApiConstants.profile);
//     return ProfileResponses.fromJson(response.data);
//   }

//   // ======================== Update Profile =======================
//   /// تحديث بيانات البروفايل
//   /// [name] - الاسم (اختياري)
//   /// [phone] - رقم الهاتف (اختياري)
//   /// [bio] - نبذة تعريفية (اختياري)
//   /// [preferredLanguage] - اللغة المفضلة (اختياري)
//   Future<UpdateResponses> updateProfile({
//     String? name,
//     String? phone,
//     String? bio,
//     String? preferredLanguage,
//   }) async {
//     final Map<String, dynamic> body = {};
//     if (name != null) body['name'] = name;
//     if (phone != null) body['phone'] = phone;
//     if (bio != null) body['bio'] = bio;
//     if (preferredLanguage != null) body['preferredLanguage'] = preferredLanguage;

//     final response = await _dio.put(ApiConstants.updateProfile, data: body);
//     return UpdateResponses.fromJson(response.data);
//   }

//   // ======================== Change Password =======================
//   /// تغيير كلمة المرور
//   /// [currentPassword] - كلمة المرور الحالية
//   /// [newPassword] - كلمة المرور الجديدة
//   Future<void> changePassword({
//     required String currentPassword,
//     required String newPassword,
//   }) async {
//     await _dio.post(
//       ApiConstants.changePassword,
//       data: {
//         'currentPassword': currentPassword,
//         'newPassword': newPassword,
//       },
//     );
//   }
// }

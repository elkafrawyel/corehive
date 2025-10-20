import '../api_requests/register_request.dart';
import '../api_responses/register_response.dart';
import 'package:corehive_store/app/data/models/user_model.dart';
import 'package:corehive_store/app/config/clients/api/api_result.dart';

class AuthRepository {
  Future<ApiResult<RegisterResponse>> register({
    required RegisterRequest registerRequest,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    final user = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'name': registerRequest.name,
      'email': registerRequest.email,
      'phone': registerRequest.phone,
      'image': null,
    };
    final response = RegisterResponse(
      success: true,
      message: 'Fake registration successful',
      data: UserModel.fromJson(user),
    );
    return ApiSuccess(response);
  }

  Future<ApiResult<RegisterResponse>> login({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    // Fake user data
    final user = {
      'id': '1',
      'name': 'Mahmoud',
      'email': email,
      'phone': '1234567890',
      'image': null,
    };
    final response = RegisterResponse(
      success: true,
      message: 'Fake login successful',
      data: UserModel.fromJson(user),
    );
    return ApiSuccess(response);
  }
}

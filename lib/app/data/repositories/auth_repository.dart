import '../../config/clients/api/api_client.dart';
import '../../config/clients/api/api_result.dart';
import '../../domain/repositories/auth_repository.dart';
import '../api_requests/register_request.dart';
import '../api_responses/register_response.dart';

class AuthRepositoryImpl extends AuthRepository {

  @override
  Future<ApiResult<RegisterResponse>> register({
    required RegisterRequest registerRequest,
  }) {
    return APIClient.instance.post(
      endPoint: 'register',
      fromJson: RegisterResponse.fromJson,
      requestBody: registerRequest.toJson(),
    );
  }
}

import '../../config/clients/api/api_result.dart';
import '../../data/api_requests/register_request.dart';
import '../../data/api_responses/register_response.dart';

abstract class AuthRepository {

  Future<ApiResult<RegisterResponse>> register({
    required RegisterRequest registerRequest,
  });

}

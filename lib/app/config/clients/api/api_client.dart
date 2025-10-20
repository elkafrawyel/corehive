import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../environment.dart';
import '../../helpers/logging_helper.dart';
import '../../helpers/offline_handler.dart';
import '../storage/storage_client.dart';
import 'api_result.dart';
import 'network_helper.dart';

enum DioMethods { get, post, patch, put, delete }

class APIClient {
  static const _requestTimeOut = Duration(seconds: 30);

  APIClient._();

  static final instance = APIClient._();

  final Dio _client =
      Dio(
          BaseOptions(
            baseUrl: Environment().url(),
            headers: {
              HttpHeaders.acceptHeader: 'application/json',
              HttpHeaders.cacheControlHeader: 'no-cache',
              HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
              HttpHeaders.authorizationHeader:
                  'Bearer ${StorageClient().apiToken()}',
              HttpHeaders.acceptLanguageHeader: StorageClient()
                  .getAppLanguage(),
            },
            followRedirects: false,
            validateStatus: (status) => status! <= 500,
            connectTimeout: _requestTimeOut,
            receiveTimeout: _requestTimeOut,
          ),
        )
        ..interceptors.add(
          PrettyDioLogger(
            request: true,
            requestBody: true,
            requestHeader: true,
            error: true,
            logPrint: (object) => AppLogger.log(object.toString()),
            maxWidth: 1000,
          ),
        );

  void updateAcceptedLanguageHeader(String language) {
    _client.options.headers[HttpHeaders.acceptLanguageHeader] = language;
  }

  void updateTokenHeader(String? token, {String? tokenType}) {
    if (token == null) {
      _client.options.headers.remove(HttpHeaders.authorizationHeader);
      AppLogger.log('Auth token removed');
    } else {
      _client.options.headers[HttpHeaders.authorizationHeader] =
          '${tokenType ?? 'Bearer'} $token';
    }
  }

  /// Generic request sender to avoid repeating try/catch.
  Future<ApiResult<T>> _sendRequest<T>(
    Future<Response> Function() request,
    T Function(dynamic) fromJson,
  ) async {
    try {
      if (!await OfflineHandler.isConnected()) {
        return ApiFailure(
          StorageClient.instance.isAr()
              ? 'لا يوجد اتصال بالإنترنت'
              : 'Check your internet connection and try again.',
        );
      }

      final response = await request();

      if (NetworkHelper.isSuccess(response)) {
        return ApiSuccess(fromJson(response.data));
      } else {
        return NetworkHelper.handleCommonNetworkCases(response);
      }
    } on DioException catch (error) {
      return NetworkHelper.handleDioError(error);
    } catch (error, stack) {
      AppLogger.log(error.toString());
      AppLogger.log(stack.toString());
      return ApiFailure(
        StorageClient().isAr() ? 'للأسف حدث خطأ' : 'Unexpected Error Happened',
      );
    }
  }

  // ------------------- PUBLIC METHODS -------------------

  Future<ApiResult<T>> get<T>({
    required String endPoint,
    required T Function(dynamic) fromJson,
    Map<String, dynamic>? queryParameters,
  }) {
    return _sendRequest(
      () => _client.get(endPoint, queryParameters: queryParameters),
      fromJson,
    );
  }

  Future<ApiResult<T>> post<T>({
    required String endPoint,
    required T Function(dynamic) fromJson,
    required Map<String, dynamic> requestBody,
    List<MapEntry<String, File>> files = const [],
    Function(double percentage)? onUploadProgress,
    Function(double percentage)? onDownloadProgress,
    bool forceFormData = false,
  }) {
    final haveFiles = files.isNotEmpty || forceFormData;
    final data = haveFiles
        ? FormData.fromMap({
            ...requestBody,
            ...Map.fromEntries(
              files.map(
                (e) => MapEntry(
                  e.key,
                  MultipartFile.fromFileSync(
                    e.value.path,
                    filename: e.value.path.split("/").last,
                  ),
                ),
              ),
            ),
          })
        : requestBody;

    return _sendRequest(
      () => _client.post(
        endPoint,
        data: data,
        onReceiveProgress: (received, total) {
          if (total > 0 && onDownloadProgress != null) {
            onDownloadProgress(received / total);
          }
          AppLogger.log(
            'Downloading ....${((received / (total > 0 ? total : 1)) * 100).floor()}%',
          );
        },
        onSendProgress: (sent, total) {
          if (total > 0 && onUploadProgress != null) {
            onUploadProgress(sent / total);
          }
          AppLogger.log(
            'Uploading ....${((sent / (total > 0 ? total : 1)) * 100).floor()}%',
          );
        },
      ),
      fromJson,
    );
  }

  Future<ApiResult<T>> put<T>({
    required String endPoint,
    required T Function(dynamic) fromJson,
    required Map<String, dynamic> requestBody,
  }) {
    return _sendRequest(
      () => _client.put(endPoint, data: requestBody),
      fromJson,
    );
  }

  Future<ApiResult<T>> delete<T>({
    required String endPoint,
    required T Function(dynamic) fromJson,
    Map<String, dynamic>? requestBody,
  }) {
    return _sendRequest(
      () => _client.delete(endPoint, data: requestBody),
      fromJson,
    );
  }

  Future<ApiResult<T>> patch<T>({
    required String endPoint,
    required T Function(dynamic) fromJson,
    Map<String, dynamic>? requestBody,
  }) {
    return _sendRequest(
      () => _client.patch(endPoint, data: requestBody),
      fromJson,
    );
  }
}

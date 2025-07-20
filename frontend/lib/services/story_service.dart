import 'package:dio/dio.dart';
import '../models/story_request.dart';
import '../models/story_response.dart';
import 'api_client.dart';

class StoryService {
  final ApiClient _apiClient = ApiClient();

  Future<StoryResponse> generateStory(StoryRequest request) async {
    try {
      final response = await _apiClient.dio.post(
        '/generate',
        data: request.toJson(),
      );

      return StoryResponse.fromJson(response.data);
    } on DioException catch (e) {
      // Handle API errors
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to generate story: ${e.toString()}');
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final responseData = e.response!.data;

      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('detail')) {
        return Exception('Error $statusCode: ${responseData['detail']}');
      }

      return Exception('API Error $statusCode: ${e.message}');
    }

    return Exception('Network error: ${e.message}');
  }
}

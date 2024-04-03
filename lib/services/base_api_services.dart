abstract class BaseApiServices{

  Future<dynamic> getApi(String url, {Map<String, dynamic>? queryParameters});

  Future<dynamic> postApi(String url,dynamic body);
}
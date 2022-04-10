import 'package:dio/dio.dart';
import 'package:football_scores_api/end_points.dart';

class DioHelper{

static late Dio dio;

static init(){
dio =Dio(
BaseOptions(
  baseUrl:'https://v3.football.api-sports.io/',
  receiveDataWhenStatusError: true
)
);

}

static Future<Response> getData({
 required String url,
 Map<String,dynamic>? query

})async{
dio.options.headers = {
  'x-rapidapi-host': "v3.football.api-sports.io",
  'x-rapidapi-key': kApiKey
};

  return await dio.get(url,queryParameters: query);
}

} 
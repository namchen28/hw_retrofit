import 'package:dio/dio.dart';
import 'package:hw_retrofit/bio.dart';
import 'package:hw_retrofit/news.dart';
import 'package:retrofit/retrofit.dart';

part 'test.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/countries')
  Future<dynamic> getCountries();

  @POST('/detect')
  @FormUrlEncoded()
  Future<String> detectLang(@Field() String q);

  @POST('')
  @FormUrlEncoded()
  Future<dynamic> postTranslate(@Field() String q, @Field() String target);

  @GET('/actors/get-bio?nconst={nconst}')
  Future<Bio> getBio(@Path() String nconst);

  @GET('/actors/get-all-news?nconst={nconst}')
  Future<News> getNews(@Path() String nconst);
}

import 'package:dio/dio.dart';
import 'package:hw_retrofit/test.dart';
import 'package:logger/logger.dart';

final logger = Logger();

void printLog() async {
  final news = Dio();

  news.options.headers = {
    'X-RapidAPI-Key': 'a05f098654msh774b1fe074234ccp18d309jsncc8e7acb55db',
    'X-RapidAPI-Host': 'imdb8.p.rapidapi.com'
  };
  news.options.baseUrl = 'https://imdb8.p.rapidapi.com';
  final clientNews = RestClient(news);
  clientNews.getNews("nm0001667").then((it) => logger.i(it)).catchError((obj) {
    // non-200 error goes here.
    switch (obj.runtimeType) {
      case DioException _:
        // Here's the sample to get the failed response error code and message
        final res = (obj as DioException).response;
        logger.e('Got error : ${res?.statusCode} -> ${res?.statusMessage}');
        break;
      default:
        break;
    }
  });

  final dio = Dio(); // Provide a dio instance
  dio.options.headers = {
    'X-RapidAPI-Key': 'a05f098654msh774b1fe074234ccp18d309jsncc8e7acb55db',
    'X-RapidAPI-Host': 'wft-geo-db.p.rapidapi.com'
  };
  dio.options.baseUrl = 'https://wft-geo-db.p.rapidapi.com/v1/geo';
  final client = RestClient(dio);

  client.getCountries().then((it) => logger.i(it)).catchError((obj) {
    // non-200 error goes here.
    switch (obj.runtimeType) {
      case DioException:
        // Here's the sample to get the failed response error code and message
        final res = (obj as DioException).response;
        logger.e('Got error : ${res?.statusCode} -> ${res?.statusMessage}');
        break;
      default:
        break;
    }
  });

  final translate = Dio();
  translate.options.baseUrl =
      'https://google-translate1.p.rapidapi.com/language/translate/v2';
  translate.options.headers = {
    'X-RapidAPI-Key': 'a05f098654msh774b1fe074234ccp18d309jsncc8e7acb55db',
    'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com'
  };
  final clientTranslate = RestClient(translate);
  clientTranslate
      .postTranslate("Hello", "es")
      .then((it) => logger.i(it))
      .catchError((obj) {
    // non-200 error goes here.
    switch (obj.runtimeType) {
      case DioException:
        // Here's the sample to get the failed response error code and message
        final res = (obj as DioException).response;
        logger.e('Got error : ${res?.statusCode} -> ${res?.statusMessage}');
        break;
      default:
        break;
    }
  });

  final detect = Dio();
  detect.options.baseUrl =
      'https://google-translate1.p.rapidapi.com/language/translate/v2';
  detect.options.headers = {
    'content-type': 'application/x-www-form-urlencoded',
    'Accept-Encoding': 'application/gzip',
    'X-RapidAPI-Key': 'a05f098654msh774b1fe074234ccp18d309jsncc8e7acb55db',
    'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com'
  };
  final clientDetect = RestClient(detect);
  clientDetect.detectLang("Hello").then((it) => logger.i(it)).catchError((obj) {
    // non-200 error goes here.
    switch (obj.runtimeType) {
      case DioException:
        // Here's the sample to get the failed response error code and message
        final res = (obj as DioException).response;
        logger.e('Got error : ${res?.statusCode} -> ${res?.statusMessage}');
        break;
      default:
        break;
    }
  });
}

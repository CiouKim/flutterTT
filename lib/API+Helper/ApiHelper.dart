import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:my_app/Model/Model.dart';

Dio dio = Dio();

// GET
Future<T> getRequest<T>(String url,
    {Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers}) async {
  try {
    final response = await dio.get(url,
        queryParameters: queryParameters, options: Options(headers: headers));
    final jsonData = response.data;
    if (response.statusCode == 200) {
      //ok
      debugger();
      return parseJsonData<T>(jsonData);
    } else {
      throw ErrorTypeException(ErrorTypeExceptionType.serverError,
          message: ErrorTypeExceptionType.serverError.showMessages());
    }
  } on DioError catch (e) {
    switch (e.type) {
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw ErrorTypeException(ErrorTypeExceptionType.timeout,
            message: ErrorTypeExceptionType.timeout.showMessages());
      case DioErrorType.connectionError:
      case DioErrorType.badResponse:
        if (e.error is SocketException || e.error is HandshakeException) {
          throw ErrorTypeException(ErrorTypeExceptionType.noInternetConnection,
              message:
                  ErrorTypeExceptionType.noInternetConnection.showMessages());
        } else if (e.response?.statusCode == 401) {
          throw ErrorTypeException(ErrorTypeExceptionType.unauthorized,
              message: ErrorTypeExceptionType.unauthorized.showMessages());
        } else if (e.response?.statusCode == 403) {
          throw ErrorTypeException(ErrorTypeExceptionType.forbidden,
              message: ErrorTypeExceptionType.forbidden.showMessages());
        } else {
          throw ErrorTypeException(ErrorTypeExceptionType.serverError,
              message: ErrorTypeExceptionType.serverError.showMessages());
        }
      default:
        throw ErrorTypeException(ErrorTypeExceptionType.serverError,
            message: ErrorTypeExceptionType.serverError.showMessages());
    }
  }
}

// POST
Future<T> postRequest<T>(String url, Map<String, dynamic> data,
    {Map<String, dynamic>? headers}) async {
  try {
    final response =
        await dio.post(url, data: data, options: Options(headers: headers));
    final jsonData = response.data;
    if (response.statusCode == 200) {
      return parseJsonData<T>(jsonData);
    } else {
      throw ErrorTypeException(ErrorTypeExceptionType.serverError,
          message: ErrorTypeExceptionType.serverError.showMessages());
    }
  } on DioError catch (e) {
    switch (e.type) {
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw ErrorTypeException(ErrorTypeExceptionType.timeout,
            message: ErrorTypeExceptionType.timeout.showMessages());
      case DioErrorType.connectionError:
      case DioErrorType.badResponse:
        if (e.error is SocketException || e.error is HandshakeException) {
          throw ErrorTypeException(ErrorTypeExceptionType.noInternetConnection,
              message:
                  ErrorTypeExceptionType.noInternetConnection.showMessages());
        } else if (e.response?.statusCode == 401) {
          throw ErrorTypeException(ErrorTypeExceptionType.unauthorized,
              message: ErrorTypeExceptionType.unauthorized.showMessages());
        } else if (e.response?.statusCode == 403) {
          throw ErrorTypeException(ErrorTypeExceptionType.forbidden,
              message: ErrorTypeExceptionType.forbidden.showMessages());
        } else {
          throw ErrorTypeException(ErrorTypeExceptionType.serverError,
              message: ErrorTypeExceptionType.serverError.showMessages());
        }
      default:
        throw ErrorTypeException(ErrorTypeExceptionType.serverError,
            message: ErrorTypeExceptionType.serverError.showMessages());
    }
  }
}


T parseJsonData<T>(dynamic jsonString) {
  final jsonData = jsonDecode(jsonString);
  if (jsonData is Map<String, dynamic>) {
    if (T == Person) {
      return Person.fromJson(jsonData) as T;
    }
    if (T == Res) {
      return Res.fromJson(jsonData) as T;
    }

    ///....todo how to fixed without add
  }
  throw ErrorTypeException(ErrorTypeExceptionType.jsonParseError,
      message: ErrorTypeExceptionType.unsupportedJsonParse.showMessages());
}

T _fromJson<T>(dynamic json, Type type) {
  if (json is List) {
    return _fromJsonList<T>(json, type);
  } else if (json is Map<String, dynamic>) {
    return _fromJsonMap<T>(json, type);
  } else {
    throw ErrorTypeException(ErrorTypeExceptionType.jsonParseError,
        message: ErrorTypeExceptionType.jsonParseError.showMessages());
  }
}

T _fromJsonList<T>(List<dynamic> list, Type type) {
  final newList = <T>[];
  for (final item in list) {
    newList.add(_fromJson(item, type));
  }
  return newList as T;
}

T _fromJsonMap<T>(Map<String, dynamic> map, Type type) {
  if (type == Person) {
    return Person.fromJson(map) as T;
  }
  // Add more type checks for other models as needed...
  else {
    throw ErrorTypeException(ErrorTypeExceptionType.unsupportedJsonParse,
        message: ErrorTypeExceptionType.unsupportedJsonParse.showMessages());
  }
}

enum ErrorTypeExceptionType {
  noInternetConnection,
  timeout,
  serverError,
  unauthorized, //401
  forbidden, //403
  other,
  unsupportedJsonParse,
  jsonParseError,
}

extension ErrorTypeExceptionMessage on ErrorTypeExceptionType {
  String showMessages() {
    switch (this) {
      case ErrorTypeExceptionType.noInternetConnection:
        return 'No internet connection';
      case ErrorTypeExceptionType.timeout:
        return 'server time out';
      case ErrorTypeExceptionType.serverError:
        return 'Server error';
      case ErrorTypeExceptionType.unauthorized:
        return 'Unauthforbiddenorized';
      case ErrorTypeExceptionType.forbidden:
        return 'resource forbidden';
      case ErrorTypeExceptionType.other:
        return 'something Opps';
      case ErrorTypeExceptionType.unsupportedJsonParse:
        return 'unsupported Parse Type';
      case ErrorTypeExceptionType.jsonParseError:
        return 'Failed to parse JSON data';
      default:
        return 'something Opps';
    }
  }
}

class ErrorTypeException implements Exception {
  final ErrorTypeExceptionType exceptionType;
  final String message;

  ErrorTypeException(this.exceptionType, {this.message = ''});

  @override
  String toString() {
    return 'ErrorTypeExceptionType: $exceptionType - $message';
  }
}

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../core/utils/utils.dart';
import '../../core/extensions/extensions.dart';
import '../../data/models/models.dart';

part 'auth_repository.dart';
part 'movie_repository.dart';
part 'user_repository.dart';




class ApiHelper {
  Dio launch() {
    Dio dio = new Dio();
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 1000));
    dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    dio.options.headers["accept"] = 'application/json';
    dio.options.followRedirects = false;
    dio.options.validateStatus = (s) {
      return s < 500;
    };

    return dio;
  }
}

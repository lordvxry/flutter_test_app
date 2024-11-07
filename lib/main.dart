import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/repositories/crypto_coins/crypto_coins.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'flutter_demo_app.dart';

void main() async {
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);

  const cryptoCoinsBoxName = 'crypto_coins_box';

  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Hive.initFlutter();

    Hive.registerAdapter(CryptoCoinAdapter());
    Hive.registerAdapter(CryptoCoinDetailAdapter());

    final cryptoCoinsBox = await Hive.openBox<CryptoCoin>(cryptoCoinsBoxName);

    final dio = Dio();
    dio.interceptors.add(TalkerDioLogger(
        talker: talker,
        settings: const TalkerDioLoggerSettings(
          printResponseData: false,
        )));

    Bloc.observer = TalkerBlocObserver(
        talker: talker,
        settings: const TalkerBlocLoggerSettings(
          printStateFullData: false,
          printEventFullData: false,
        ));

    GetIt.I.registerLazySingleton<AbstractCoinsRepository>(
        () => CryptoCoinsRepository(dio: dio, cryptoCoinsBox: cryptoCoinsBox));

    FlutterError.onError =
        (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

    runApp(const FlutterDemoApp());
  }, (exception, stackTrace) {
    GetIt.I<Talker>().handle(exception, stackTrace);
  });
}

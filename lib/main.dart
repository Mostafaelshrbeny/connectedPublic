import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/data/core/lang/codegen_loader.g.dart';
import 'package:elconnected/data/data_sources/localedate.dart';
import 'package:elconnected/domain/use_cases/location_services.dart';
import 'package:elconnected/domain/use_cases/mainmethods.dart';
import 'package:elconnected/domain/use_cases/save_token.dart';
import 'package:elconnected/firebase_options.dart';
import 'package:elconnected/presentation/blocs/BlocObserver/blocobserver.dart';
import 'package:elconnected/presentation/pages/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocationServices.getloctaion();
  String? token = await FirebaseMessaging.instance.getToken();
  SaveToken.setFCMtoken(token);
  Bloc.observer = const SimpleBlocObserver();
  await LocalePref.setPref();
  Hive.init(appDocumentDirectory.path);
  await EasyLocalization.ensureInitialized();
  MainAppFunctions.statusbarColor();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await HiveLocaleData.openbox('MyAppData');
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
        path: 'assets/lang',
        startLocale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        assetLoader: const CodegenLoader(),
        child: const MyApp()),
  );
}

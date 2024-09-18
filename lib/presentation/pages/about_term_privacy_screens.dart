import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/presentation/blocs/AboutAppCubit/about_app_cubit.dart';
import 'package:elconnected/presentation/blocs/AboutAppCubit/about_app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class AboutTermPrivacyScreens extends StatefulWidget {
  const AboutTermPrivacyScreens({super.key, required this.arguments});
  final Map<String, String> arguments;
  @override
  State<AboutTermPrivacyScreens> createState() =>
      _AboutTermPrivacyScreensState();
}

class _AboutTermPrivacyScreensState extends State<AboutTermPrivacyScreens> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((val) =>
        AboutAppCubit.get(context).getData(api: widget.arguments['Api']!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AboutAppCubit, AboutAppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AboutAppCubit.get(context).about != null
                  ? AboutAppCubit.get(context).title!
                  : widget.arguments["title"]!,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            centerTitle: true,
          ),
          body: AboutAppCubit.get(context).loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppThemeData.appBlue,
                  ),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: AboutAppCubit.get(context).about != null
                      ? Html(
                          data: AboutAppCubit.get(context).data,
                          style: {
                            "body": Style(
                              color: Colors.black,
                            ),
                            "h1": Style(
                              color: Colors.black,
                            ),
                            "p": Style(
                              color: Colors.black,
                            ),
                          },
                        )
                      : Text(
                          'But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes,\n \nor avoids pleasure itself, because it is pleasure,But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth,\n \nthe master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure,But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure,',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.grey),
                        ),
                ),
        );
      },
    );
  }
}

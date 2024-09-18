import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/presentation/blocs/QRCubit/qr_code_cubit.dart';
import 'package:elconnected/presentation/blocs/QRCubit/qr_code_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class QrCodeScreen extends StatelessWidget {
  const QrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QrCodeCubit, QrCodeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              LocaleKeys.myQRcode.tr(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            centerTitle: true,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: AppThemeData.appBlue,
                )),
          ),
          body: QrCodeCubit.get(context).loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppThemeData.appBlue,
                  ),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(LocaleKeys.qRCode.tr(),
                          style: Theme.of(context).textTheme.headlineMedium),
                      const Gap(8),
                      Text(LocaleKeys.useyourQR.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(fontWeight: FontWeight.w300)),
                      const Gap(30),
                      QrCodeCubit.get(context).qrCode == null
                          ? Center(
                              child: Text(LocaleKeys.noQR.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium))
                          : Center(
                              child: QrCodeCubit.get(context).qrCode,
                            )
                    ],
                  ),
                ),
        );
      },
    );
  }
}

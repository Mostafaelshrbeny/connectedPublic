import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/domain/use_cases/availabel_vouchers.dart';
import 'package:elconnected/domain/use_cases/location_services.dart';
import 'package:elconnected/presentation/blocs/VouchersCubit/vouchers_data_cubit.dart';
import 'package:elconnected/presentation/blocs/VouchersCubit/vouchers_data_state.dart';
import 'package:elconnected/presentation/widgets/accountoption_row.dart';
import 'package:elconnected/presentation/widgets/cutsombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class AdsPaymentScreen extends StatelessWidget {
  const AdsPaymentScreen({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VouchersDataCubit, VouchersDataState>(
      listener: (context, state) {
        if (state is SellFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              VouchersDataCubit.get(context).erroMsg ?? "",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ));
        } else if (state is SellDoneState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Done",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
          ));
        }
      },
      builder: (context, state) {
        VouchersDataCubit vCubit = VouchersDataCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.payment.tr(),
                style: Theme.of(context).textTheme.headlineLarge),
            centerTitle: true,
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
            children: [
              vCubit.vouchers == null
                  ? const SizedBox()
                  : SizedBox(
                      height:
                          Device.deviceHeight(context: context, percent: 1 / 8),
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    hexToColor(vCubit
                                            .vouchersList[vCubit.currentvoucher]
                                            .appearance
                                            ?.backgroundColor ??
                                        "#FFFFFF"),
                                    BlendMode.color),
                                child: SvgPicture.asset(
                                    "assets/images/Subtract.svg")),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        vCubit
                                                .vouchersList[
                                                    vCubit.currentvoucher]
                                                .title
                                                ?.text ??
                                            '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(
                                                color: hexToColor(vCubit
                                                        .vouchersList[vCubit
                                                            .currentvoucher]
                                                        .title
                                                        ?.color ??
                                                    "#FFFFFF")),
                                      ),
                                      const Gap(5),
                                      Expanded(
                                        child: SizedBox(
                                          width: Device.deviceWidth(
                                              context: context, percent: 1 / 2),
                                          child: Text(
                                            vCubit
                                                    .vouchersList[
                                                        vCubit.currentvoucher]
                                                    .description
                                                    ?.text ??
                                                '',
                                            softWrap: true,
                                            maxLines: 2,
                                            overflow: TextOverflow.clip,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall!
                                                .copyWith(
                                                    color: hexToColor(vCubit
                                                            .vouchersList[vCubit
                                                                .currentvoucher]
                                                            .description
                                                            ?.color ??
                                                        "#FFFFFF")),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  margin: const EdgeInsetsDirectional.only(
                                      bottom: 10),
                                  width: Device.deviceWidth(
                                      context: context, percent: 1 / 4),
                                  child: Center(
                                    child: Text(
                                      vCubit.vouchersList[0].discountText
                                              ?.text ??
                                          "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(
                                              color: hexToColor(vCubit
                                                      .vouchersList[0]
                                                      .description
                                                      ?.color ??
                                                  "#FFFFFF")),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment(-1, -0.15),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 15.5,
                            ),
                          ),
                          Align(
                            alignment: Alignment(1, -0.15),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 15.5,
                            ),
                          ),
                        ],
                      ),
                    ),
              const Gap(12),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      color: AppThemeData.appBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8)),
                  child: AccountoptionRow(
                    option: LocaleKeys.viewavailablevouchers.tr(),
                    withSuffix: true,
                    suffixIcon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppThemeData.appBlue,
                      size: 18,
                    ),
                    nextScreenRoute: () => vCubit.vouchers == null
                        ? null
                        : AvailabelVouchers.vouchersSheet(context, vCubit),
                    prefixIcon: Icon(
                      Icons.confirmation_num_outlined,
                      color: AppThemeData.appBlue,
                    ),
                  )),
              const Gap(23),
              // Text(
              //   LocaleKeys.paymentsummary.tr(),
              //   style: Theme.of(context).textTheme.headlineLarge,
              // ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     mainAxisSize: MainAxisSize.min,
              //     children: List.generate(
              //       3,
              //       (index) => const Padding(
              //         padding: EdgeInsets.only(top: 16),
              //         child: RecieptPriceRow(
              //           service: "Basic listing fee",
              //           price: "350 EGP",
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   child: Divider(
              //     color: Colors.grey.withOpacity(0.4),
              //   ),
              // ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 16),
              //   child: RecieptPriceRow(
              //     service: 'Total (Incl. VAT)',
              //     price: "1150 EGP",
              //   ),
              // ),
              // const Gap(50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AppCustomButton(
                    buttonChild: Text(
                      LocaleKeys.addyourlistings.tr(),
                      style: AppThemeData.buttonTextThem(context),
                    ),
                    ontap: () {
                      VouchersDataCubit.get(context).sellItem();
                    }),
              )
            ],
          ),
        );
      },
    );
  }

  Color hexToColor(String hexString) {
    final buffer = StringBuffer();

    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

class RecieptPriceRow extends StatelessWidget {
  const RecieptPriceRow({
    super.key,
    required this.service,
    required this.price,
  });
  final String service, price;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(service, style: Theme.of(context).textTheme.headlineMedium),
        const Spacer(),
        Text(price,
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(fontWeight: FontWeight.bold))
      ],
    );
  }
}

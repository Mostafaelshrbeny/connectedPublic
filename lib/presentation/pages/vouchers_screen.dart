import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/presentation/blocs/VouchersCubit/vouchers_data_cubit.dart';
import 'package:elconnected/presentation/blocs/VouchersCubit/vouchers_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class VouchersScreen extends StatefulWidget {
  const VouchersScreen({super.key});

  @override
  State<VouchersScreen> createState() => _VouchersScreenState();
}

class _VouchersScreenState extends State<VouchersScreen> {
  @override
  void initState() {
    scControll.addListener(scrollListener);
    Future.delayed(Duration.zero)
        .then((_) => VouchersDataCubit.get(context).getAllVouchers(0));
    super.initState();
  }

  @override
  void dispose() {
    // Dispose of the controller to avoid memory leaks
    scControll.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (scControll.offset >= scControll.position.maxScrollExtent - 200 &&
        !scControll.position.outOfRange) {
      // RecommendedForyouCubit.get(context).scroll();
    }
  }

  ScrollController scControll = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VouchersDataCubit, VouchersDataState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.vouchers.tr(),
                style: Theme.of(context).textTheme.headlineLarge),
            centerTitle: true,
          ),
          body: VouchersDataCubit.get(context).loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppThemeData.appBlue,
                  ),
                )
              : VouchersDataCubit.get(context).vouchersList.isEmpty
                  ? Center(
                      child: Text(
                        LocaleKeys.noItems.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: AppThemeData.appBlue),
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 32),
                      itemBuilder: (context, index) {
                        var voucher =
                            VouchersDataCubit.get(context).vouchersList[index];
                        return SizedBox(
                          height: Device.deviceHeight(
                              context: context, percent: 1 / 8),
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                        hexToColor(voucher
                                                .appearance?.backgroundColor ??
                                            "#FFFFFF"),
                                        BlendMode.color),
                                    child: SvgPicture.asset(
                                        "assets/images/Subtract.svg")),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
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
                                            voucher.title?.text ?? '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineLarge!
                                                .copyWith(
                                                    color: hexToColor(
                                                        voucher.title?.color ??
                                                            "#FFFFFF")),
                                          ),
                                          const Gap(5),
                                          Expanded(
                                            child: SizedBox(
                                              width: Device.deviceWidth(
                                                  context: context,
                                                  percent: 1 / 2),
                                              child: Text(
                                                voucher.description?.text ?? '',
                                                softWrap: true,
                                                maxLines: 2,
                                                overflow: TextOverflow.clip,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall!
                                                    .copyWith(
                                                        color: hexToColor(
                                                            voucher.description
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
                                          voucher.discountText?.text ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineLarge!
                                              .copyWith(
                                                  color: hexToColor(voucher
                                                          .description?.color ??
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
                        );
                      },
                      itemCount:
                          VouchersDataCubit.get(context).vouchersList.length,
                      separatorBuilder: (context, index) => const Gap(24),
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

/*Container(
                          height: Device.deviceHeight(
                              context: context, percent: 1 / 8),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: hexToColor(
                                  voucher.appearance?.backgroundColor ??
                                      "#FFFFFF"),
                              borderRadius: BorderRadius.circular(25)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      voucher.title?.text ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(
                                              color: hexToColor(
                                                  voucher.title?.color ??
                                                      "#FFFFFF")),
                                    ),
                                    const Gap(5),
                                    Expanded(
                                      child: SizedBox(
                                        width: Device.deviceWidth(
                                            context: context, percent: 1 / 2),
                                        child: Text(
                                          voucher.description?.text ?? '',
                                          softWrap: true,
                                          maxLines: 2,
                                          overflow: TextOverflow.clip,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(
                                                  color: hexToColor(voucher
                                                          .description?.color ??
                                                      "#FFFFFF")),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Container(
                              //   width: Device.deviceWidth(
                              //       context: context, percent: 1 / 4),
                              //       decoration: BoxDecoration(color: ),
                              // )
                            ],
                          ),
                        )
*/
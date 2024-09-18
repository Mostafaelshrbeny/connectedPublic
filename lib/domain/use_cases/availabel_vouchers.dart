import 'package:elconnected/constant/device.dart';
import 'package:elconnected/presentation/blocs/VouchersCubit/vouchers_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class AvailabelVouchers {
  static vouchersSheet(BuildContext context, VouchersDataCubit cub) {
    return showModalBottomSheet(
      isDismissible: true,
      enableDrag: false,
      isScrollControlled: true,
      constraints: BoxConstraints(
          maxHeight: Device.deviceHeight(context: context, percent: 1 / 1.4)),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      context: context,
      builder: (context) => ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 32),
        itemBuilder: (context, index) {
          var voucher = cub.vouchersList[index];
          return InkWell(
            onTap: () {
              cub.selectVoucher(index);
              Navigator.pop(context);
            },
            child: SizedBox(
              height: Device.deviceHeight(context: context, percent: 1 / 8),
              width: double.infinity,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            hexToColor(voucher.appearance?.backgroundColor ??
                                "#FFFFFF"),
                            BlendMode.color),
                        child: SvgPicture.asset("assets/images/Subtract.svg")),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                voucher.title?.text ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(
                                        color: hexToColor(
                                            voucher.title?.color ?? "#FFFFFF")),
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
                                            color: hexToColor(
                                                voucher.description?.color ??
                                                    "#FFFFFF")),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(
                          margin: const EdgeInsetsDirectional.only(bottom: 10),
                          width: Device.deviceWidth(
                              context: context, percent: 1 / 4),
                          child: Center(
                            child: Text(
                              voucher.discountText?.text ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                      color: hexToColor(
                                          voucher.description?.color ??
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
          );
        },
        itemCount: cub.vouchersList.length,
        separatorBuilder: (context, index) => const Gap(24),
      ),
    );
  }

  static Color hexToColor(String hexString) {
    final buffer = StringBuffer();

    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

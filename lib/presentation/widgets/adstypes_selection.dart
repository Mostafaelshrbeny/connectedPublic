import 'package:cached_network_image/cached_network_image.dart';
import 'package:elconnected/constant/device.dart';
import 'package:elconnected/presentation/blocs/AdditionalServCubit/additional_services_cubit.dart';
import 'package:elconnected/presentation/blocs/AdditionalServCubit/additional_services_state.dart';
import 'package:elconnected/presentation/widgets/adoptions_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdsTypesSelection extends StatelessWidget {
  const AdsTypesSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdditionalServicesCubit, AdditionalServicesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: List.generate(
            AdditionalServicesCubit.get(context).allServiceList.length,
            (index) => AdOptionsCard(
                isChecked: AdditionalServicesCubit.get(context)
                    .selectedAdTypes
                    .contains(index),
                adType: AdditionalServicesCubit.get(context)
                        .allServiceList[index]
                        .name ??
                    "",
                adDescription: AdditionalServicesCubit.get(context)
                        .allServiceList[index]
                        .description ??
                    '',
                ontap: () =>
                    AdditionalServicesCubit.get(context).selectAdType(index),
                price:
                    '${AdditionalServicesCubit.get(context).allServiceList[index].price ?? "0"} EGP',
                suffix: CachedNetworkImage(
                  imageUrl: AdditionalServicesCubit.get(context)
                          .allServiceList[index]
                          .icon ??
                      '',
                  placeholder: (context, url) => const SizedBox(),
                  errorWidget: (context, url, error) => const SizedBox(),
                  imageBuilder: (context, imageProvider) => Image(
                    image: imageProvider,
                    height:
                        Device.deviceHeight(context: context, percent: 1 / 12),
                    width:
                        Device.deviceHeight(context: context, percent: 1 / 12),
                  ),
                )),
          ),
        );
      },
    );
  }
}

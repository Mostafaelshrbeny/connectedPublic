import 'package:elconnected/data/models/sellitem_model.dart';
import 'package:elconnected/presentation/blocs/SellOperationCubit/sell_operation_cubit.dart';
import 'package:elconnected/presentation/blocs/SellOperationCubit/sell_operation_state.dart';

import 'package:elconnected/presentation/widgets/rounded_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gap/gap.dart';

class GenerateSellPage {
  static generateSellPageWidget(SellitemModel? sellSpecifications) {}
  static Map<String, String> x = {};
  //add required to check
  static selectWidgetCase(String type, Specifications? itemlist, int index) {
    switch (type) {
      case "Range":
        return BlocConsumer<SellOperationCubit, SellOperationState>(
          listener: (context, state) {},
          builder: (context, state) {
            // bool req = itemlist?.isRequired ?? false;
            print(x.values.toList());
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: double.infinity),
                Text(itemlist?.name ?? " ",
                    style: const TextStyle(color: Colors.black)),
                const Gap(5),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: List.generate(
                      itemlist?.values?.length ?? 0,
                      (index) => InkWell(
                            onTap: () {
                              SellOperationCubit.get(context).addtoSell(
                                  itemlist!.values![index].value!,
                                  x,
                                  itemlist.id!);
                              if (x.keys.contains(itemlist.id!)) {
                                x.update(
                                  itemlist.id!,
                                  (value) =>
                                      itemlist.values![index].id!.toString(),
                                );
                              } else {
                                x.addAll({
                                  itemlist.id!:
                                      itemlist.values![index].id!.toString(),
                                });
                              }
                            },
                            child: RoundedCardWithText(
                              backgroundColor:
                                  x.values.contains(itemlist?.values?[index].id)
                                      ? Colors.blue
                                      : Colors.white,
                              borderColor: Colors.grey,
                              textColor: Colors.black,
                              cardText:
                                  "From ${itemlist?.values?[index].from ?? ''} To ${itemlist?.values?[index].to ?? ''}",
                            ),
                          )),
                ),
                const Gap(20),
              ],
            );
          },
        );
      case "DropdownList":
        return BlocConsumer<SellOperationCubit, SellOperationState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: double.infinity),
                Text(itemlist?.name ?? '',
                    style: const TextStyle(color: Colors.black)),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: List.generate(
                      itemlist?.values?.length ?? 0,
                      (index) => InkWell(
                            onTap: () {
                              SellOperationCubit.get(context).addtoSell(
                                  itemlist?.values?[index].value ?? '',
                                  x,
                                  itemlist!.id.toString());
                              if (x.keys.contains(itemlist.id!)) {
                                x.update(
                                  itemlist.id!,
                                  (value) =>
                                      itemlist.values![index].id!.toString(),
                                );
                              } else {
                                x.addAll({
                                  itemlist.id!:
                                      itemlist.values![index].id!.toString(),
                                });
                              }
                            },
                            child: RoundedCardWithText(
                              backgroundColor:
                                  x.values.contains(itemlist?.values?[index].id)
                                      ? Colors.blue
                                      : Colors.white,
                              borderColor: Colors.grey,
                              textColor: Colors.black,
                              cardText: itemlist?.values?[index].value ?? "",
                            ),
                          )),
                ),
                const Gap(20),
              ],
            );
          },
        );
      case "Profile":
        return BlocConsumer<SellOperationCubit, SellOperationState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: double.infinity),
                Text(itemlist?.name ?? '',
                    style: const TextStyle(color: Colors.black)),
                const Gap(5),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: List.generate(
                      itemlist?.values?.length ?? 0,
                      (index) => InkWell(
                            onTap: () {
                              SellOperationCubit.get(context).addtoSell(
                                  itemlist?.values?[index].value ?? '',
                                  x,
                                  itemlist!.id!);
                              if (x.keys.contains(itemlist.id!)) {
                                x.update(
                                  itemlist.id!,
                                  (value) =>
                                      itemlist.values![index].id!.toString(),
                                );
                              } else {
                                x.addAll({
                                  itemlist.id!:
                                      itemlist.values![index].id!.toString(),
                                });
                              }
                            },
                            child: RoundedCardWithText(
                              backgroundColor:
                                  x.values.contains(itemlist?.values?[index].id)
                                      ? Colors.blue
                                      : Colors.white,
                              borderColor: Colors.grey,
                              textColor: Colors.black,
                              cardText: itemlist?.values?[index].name ?? "",
                            ),
                          )),
                ),
                const Gap(20),
              ],
            );
          },
        );
      default:
        return BlocConsumer<SellOperationCubit, SellOperationState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: double.infinity),
                Text(itemlist?.name ?? '',
                    style: const TextStyle(color: Colors.black)),
                const Gap(5),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: List.generate(
                      itemlist?.values?.length ?? 0,
                      (index) => InkWell(
                            onTap: () {
                              SellOperationCubit.get(context).addtoSell(
                                  itemlist?.values?[index].id ?? '',
                                  x,
                                  itemlist!.id!);
                              if (x.keys.contains(itemlist.id!)) {
                                x.update(
                                  itemlist.id!,
                                  (value) =>
                                      itemlist.values![index].id!.toString(),
                                );
                              } else {
                                x.addAll({
                                  itemlist.id!:
                                      itemlist.values![index].id!.toString(),
                                });
                              }
                            },
                            child: RoundedCardWithText(
                              backgroundColor:
                                  x.values.contains(itemlist?.values?[index].id)
                                      ? Colors.blue
                                      : Colors.white,
                              borderColor: Colors.grey,
                              textColor: Colors.black,
                              cardText: itemlist?.values?[index].value ?? "",
                            ),
                          )),
                ),
                const Gap(20),
              ],
            );
          },
        );
    }
  }
}

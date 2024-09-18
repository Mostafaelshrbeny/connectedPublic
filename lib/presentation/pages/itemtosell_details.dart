import 'package:easy_localization/easy_localization.dart';
import 'package:elconnected/constant/app_theme.dart';
import 'package:elconnected/data/core/lang/locale_keys.g.dart';
import 'package:elconnected/domain/use_cases/phone_code.dart';
import 'package:elconnected/domain/use_cases/sell_details.dart';
import 'package:elconnected/presentation/blocs/AdditionalServCubit/additional_services_cubit.dart';
import 'package:elconnected/presentation/blocs/SellOperationCubit/sell_operation_cubit.dart';
import 'package:elconnected/presentation/blocs/SellOperationCubit/sell_operation_state.dart';
import 'package:elconnected/presentation/pages/additionalservice_screen.dart';
import 'package:elconnected/presentation/widgets/cutsombutton.dart';
import 'package:elconnected/presentation/widgets/phonetextfield.dart';
import 'package:elconnected/presentation/widgets/textfield_withlabel.dart';
import 'package:elconnected/presentation/widgets/uploadmediacard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
//import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';

class ItemToSellDetailsScreen extends StatefulWidget {
  const ItemToSellDetailsScreen(
      {super.key, required this.id, required this.name});
  final String id, name;

  @override
  State<ItemToSellDetailsScreen> createState() =>
      _ItemToSellDetailsScreenState();
}

class _ItemToSellDetailsScreenState extends State<ItemToSellDetailsScreen> {
  GlobalKey<FormState> fKey = GlobalKey();
  TextEditingController titleCon = TextEditingController();
  TextEditingController describeCon = TextEditingController();
  TextEditingController priceCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();
  // final FlutterContactPicker _contactPicker = FlutterContactPicker();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SellOperationCubit, SellOperationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("${LocaleKeys.adda.tr()} ${widget.name}",
                style: Theme.of(context).textTheme.headlineLarge),
            leading: InkWell(
                onTap: () => {Navigator.pop(context)},
                child: Icon(Icons.close, color: AppThemeData.appBlue)),
          ),
          body: SellOperationCubit.get(context).loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppThemeData.appBlue,
                  ),
                )
              : Form(
                  key: fKey,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 40),
                    children: [
                      UplaodMedia(
                        image: "assets/images/pick image.svg",
                        type: LocaleKeys.uploadImage.tr(),
                        maxSize: LocaleKeys.onlyjpg.tr(),
                        picked:
                            SellOperationCubit.get(context).images.isNotEmpty,
                        pickedMedia:
                            SellOperationCubit.get(context).images.isNotEmpty
                                ? SellOperationCubit.get(context).images
                                : null,
                        isVideo: false,
                      ),
                      const Gap(40),
                      InkWell(
                        onTap: () => SellOperationCubit.get(context)
                            .pickMedia(isVideo: true),
                        child: UplaodMedia(
                          image: 'assets/images/pick video.svg',
                          type: LocaleKeys.uploadvideo.tr(),
                          maxSize: LocaleKeys.onlymp4.tr(),
                          picked: SellDetails.videos.isNotEmpty,
                          pickedMedia: const [],
                          isVideo: true,
                        ),
                      ),
                      const Gap(40),
                      TextFieldWithLabel(
                          controller: titleCon,
                          validate: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return "This field is required";
                            }
                            return null;
                          },
                          removeInit: true,
                          label: LocaleKeys.title.tr(),
                          hint: LocaleKeys.typetitle.tr()),
                      const Gap(24),
                      TextFieldWithLabel(
                          controller: describeCon,
                          validate: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return "This field is required";
                            }
                            return null;
                          },
                          removeInit: true,
                          label: LocaleKeys.description.tr(),
                          hint: LocaleKeys.typedescription.tr()),
                      const Gap(24),
                      TextFieldWithLabel(
                          inputType: TextInputType.number,
                          controller: priceCon,
                          validate: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return "This field is required";
                            }
                            return null;
                          },
                          removeInit: true,
                          label: LocaleKeys.price.tr(),
                          hint: LocaleKeys.price.tr()),
                      const Gap(24),
                      PhoneTextField(
                          validate: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return "This field is required";
                            }
                            return null;
                          },
                          onChange: (p0) {
                            PhoneCode.setCode(
                                newCode: p0.countryCode, pNumber: p0.number);
                          },
                          controller: phoneCon,
                          withInitial: false,
                          hint: LocaleKeys.typeorchoosecontact.tr(),
                          sufIcon: IconButton(
                              onPressed: () async {
                                // var contact =
                                //     await _contactPicker.selectContact();

                                // contact == null
                                //     ? null
                                //     : phoneCon.text = PhoneCode.handelNum(
                                //         contact.phoneNumbers![0]);
                              },
                              icon: Icon(
                                Icons.person_pin_rounded,
                                color: Colors.grey.withOpacity(0.8),
                              ))),
                      SellOperationCubit.get(context).sellreq == null
                          ? const SizedBox()
                          : SellOperationCubit.get(context).sellreq!,
                      AppCustomButton(
                          buttonChild: Text(LocaleKeys.checkout.tr(),
                              style: AppThemeData.buttonTextThem(context)),
                          ontap: () {
                            // else if (SellOperationCubit.get(context)
                            //         .requiredItems
                            //         .length >
                            //     GenerateSellPage.x.values.length) {
                            //   print(SellOperationCubit.get(context)
                            //       .requiredItems);
                            //   ScaffoldMessenger.of(context)
                            //       .showSnackBar(const SnackBar(
                            //     content: Text(
                            //       "Complete all Details",
                            //       style: TextStyle(color: Colors.white),
                            //     ),
                            //     backgroundColor: Colors.red,
                            //   ));
                            // }

                            if (fKey.currentState!.validate()) {
                              if (SellDetails.photos.length >= 3) {
                                SellDetails.setCatId(widget.id);
                                SellDetails.setData(
                                    itemTitle: titleCon.text,
                                    itemDesc: describeCon.text,
                                    itemPrice: double.parse(priceCon.text),
                                    code: PhoneCode.code ?? "+20",
                                    phone: PhoneCode.phone ?? phoneCon.text);

                                SellOperationCubit.get(context)
                                        .uploadmedialoading
                                    ? ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                        content: Text(
                                          "Uploading image is running",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.red,
                                      ))
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => BlocProvider(
                                                  create: (context) =>
                                                      AdditionalServicesCubit()
                                                        ..getAdditionalService(
                                                            widget.id),
                                                  child:
                                                      AdditionalServiceScreen(
                                                          id: widget.id),
                                                )));
                              } else if (titleCon.text.length < 5) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                    "Title must be 5 letters or more",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.red,
                                ));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                    "Photos must be at least 3",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            }
                          })
                    ],
                  ),
                ),
        );
      },
    );
  }
}


/*

 Text(
          LocaleKeys.location.tr(),
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.white),
        ),
        const Gap(4),
        Container(
          height: Device.deviceHeight(context: context, percent: 1 / 4),
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/Field.png'))),
        ),
        const Gap(12),
        AppCustomButton(
            backgroundColor: Colors.transparent,
            buttonChild: Text(
              LocaleKeys.sellwordschooselocation.tr(),
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.white),
            ),
            ontap: () {}),


*/





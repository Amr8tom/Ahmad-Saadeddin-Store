// ignore_for_file: prefer_const_constructors, avoid_print, must_be_immutable

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/core/model/save_address_model.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/utils/validator.dart';
import 'package:gostore_app/view/widget/common_button.dart';
import 'package:gostore_app/view/widget/icon_and_image.dart';
import 'package:gostore_app/view/widget/common_text_field.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/view/screen/my_cart/select_place_screen.dart';

import '../../../core/controller/cart_controller/checkout_controller.dart';

class AddressWidget extends StatefulWidget {
  final TabController tabController;
  final CheckoutController checkoutController;

  const AddressWidget(
      {Key? key, required this.tabController, required this.checkoutController})
      : super(key: key);

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAddress();
    });
  }

  getAddress() {
    widget.checkoutController.getSaveAddressList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextField(
                controller: widget.checkoutController.fNameController,
                labelText: 'First Name'.tr,
                hintText: 'Enter your first name',
                validator: (value) {
                  return Validator.validateName(value!, 'First name');
                },
              ),
              verticalSpace(10),
              CommonTextField(
                controller: widget.checkoutController.lNameController,
                labelText: 'Last Name'.tr,
                hintText: 'Enter your last name',
                validator: (value) {
                  return Validator.validateName(value!, 'Last name');
                },
              ),
              verticalSpace(10),
              CommonTextField(
                controller: widget.checkoutController.phoneNoController,
                labelText: 'Phone number'.tr,
                hintText: 'Enter your Phone number',
                keyboardType: TextInputType.number,
                maxLength: 10,
                validator: (value) {
                  return Validator.validateMobile(value!);
                },
              ),
              verticalSpace(10),
              CommonTextField(
                controller: widget.checkoutController.emailController,
                labelText: 'Email'.tr,
                hintText: 'company@company.com',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  return Validator.validateEmail(value!);
                },
              ),
              verticalSpace(15),
              Text(
                "Select Saved Address".tr,
                style: pBold14,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.checkoutController.addressList.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    AddressData address =
                        widget.checkoutController.addressList[index];
                    return buildSavedAddress(
                        value: address.isSelected ?? false,
                        onChanged: (value) {
                          for (int j = 0;
                              j < widget.checkoutController.addressList.length;
                              j++) {
                            if (index == j) {
                              address.isSelected = value;
                              widget.checkoutController.address_1.value = address.address!;
                              widget.checkoutController.address_title.value = address.addressTitle!;
                              print(widget.checkoutController.address_1.value);
                            } else {
                              widget.checkoutController.addressList[j]
                                  .isSelected = false;
                            }
                          }
                          widget.checkoutController.addressList.refresh();
                        },
                        title: address.addressTitle,
                        address: address.address);
                  }),
              verticalSpace(15),
              mapWidget(onTap: () {
                Get.to(() => SelectPlaceScreen())!
                    .then((value) => getAddress());
              }),
              verticalSpace(15),
              horizontalDivider(),
              verticalSpace(15),
              CommonIconBorderButton(
                onPressed: () {
                  if (formKey.currentState!.validate() &
                      widget.checkoutController.address_1.value.isNotEmpty) {
                    widget.checkoutController.shippingMap.addAll({
                      "first_name":
                          widget.checkoutController.fNameController.text.trim(),
                      "last_name":
                          widget.checkoutController.lNameController.text.trim(),
                      "address_1": widget.checkoutController.address_1.value,
                      "address_2": widget.checkoutController.address_2.value,
                      "city": widget.checkoutController.city.value,
                      "state": widget.checkoutController.state.value,
                      "postcode": widget.checkoutController.postcode.value,
                      "country": widget.checkoutController.country.value,
                      "email":
                          widget.checkoutController.emailController.text.trim(),
                      "phone": widget.checkoutController.phoneNoController.text
                          .trim()
                    });
                    print("========>:${widget.checkoutController.shippingMap}");
                    widget.tabController.animateTo(1);
                  }
                },
                title: 'Go to Shipping'.tr,
                iconData: DefaultImages.arrowRightIcn,
                btnColor: AppColor.blueThemeColor,
                textColor: AppColor.cBtnTxt,
              )
            ],
          );
        }),
      ),
    );
  }

  Widget mapWidget({void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: AppColor.cBackGround,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColor.blueThemeColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Or Select from the map".tr,
              style: pBold12.copyWith(fontSize: 10, color: AppColor.cText),
            ),
            horizontalSpace(10),
            assetSvdImageWidget(
              image: DefaultImages.mapPinIcn,
              colorFilter:
                  ColorFilter.mode(AppColor.blueThemeColor, BlendMode.srcIn),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSavedAddress(
      {bool? value,
      ValueChanged<bool?>? onChanged,
      String? title,
      String? address}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 67.74,
        width: Get.width,
        decoration: BoxDecoration(
            color: value == true ? AppColor.cLightBlue : AppColor.cWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.blueThemeColor)),
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              child: Checkbox(
                value: value,
                onChanged: onChanged,
                checkColor: AppColor.cBtnTxt,
                activeColor: AppColor.blueThemeColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                side: BorderSide(color: AppColor.blueThemeColor, width: 1.5),
              ),
            ),
            horizontalSpace(8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: pBold12.copyWith(fontSize: 10),
                  ),
                  verticalSpace(4),
                  Text(
                    address!,
                    style: pMedium10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

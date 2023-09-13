// ignore_for_file: must_be_immutable, avoid_print, invalid_use_of_protected_member, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'dart:ui' as ui;
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gostore_app/core/model/save_address_model.dart';
import 'package:gostore_app/utils/colors.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/text_style.dart';
import 'package:gostore_app/view/widget/common_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gostore_app/view/widget/common_appbar_widget.dart';
import 'package:gostore_app/view/widget/common_snak_bar_widget.dart';
import 'package:gostore_app/view/widget/common_space_divider_widget.dart';
import 'package:gostore_app/core/controller/cart_controller/checkout_controller.dart';
import 'package:gostore_app/view/widget/common_text_field.dart';
import 'package:gostore_app/view/widget/custom_google_places_autocomplete_text_field.dart';
import 'package:gostore_app/view/widget/icon_and_image.dart';
import 'package:gostore_app/view/widget/loading_widget.dart';

class SelectPlaceScreen extends StatefulWidget {
  SelectPlaceScreen({Key? key}) : super(key: key);

  @override
  State<SelectPlaceScreen> createState() => _SelectPlaceScreenState();
}

class _SelectPlaceScreenState extends State<SelectPlaceScreen> {
  CheckoutController checkoutController = Get.find();
  late GoogleMapController mapController;
  late CameraPosition cameraPosition;

  LatLng _center = const LatLng(21.211927862026563, 72.86513675726218);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _add();
  }

  Future<void> _add() async {
    var markerIdVal = "1";
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: _center,
      icon: await createMarkerImageFromAsset(context, DefaultImages.markerIcn),
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () {},
    );

    checkoutController.markers.value[markerId] = marker;
    checkoutController.markers.refresh();
  }

  // Position? currentPosition;
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Location permissions are denied', '');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Location permissions are permanently denied, we cannot request permissions.', '');

      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
      // setState(() => currentPosition = position);
      _getAddressFromLatLng(LatLng(position.latitude, position.longitude), true);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(LatLng latLng, bool isAdd) async {
    Loader.showLoader();
    await placemarkFromCoordinates(latLng.latitude, latLng.longitude).then((List<Placemark> placeMarks) {
      Placemark place = placeMarks[0];
      print("place===== $place");
      _center = LatLng(latLng.latitude, latLng.longitude);
      _add();
      cameraPosition = CameraPosition(target: _center, zoom: 14.0);
      mapController.moveCamera(CameraUpdate.newCameraPosition(cameraPosition));
      Get.back();
      if (isAdd == true) {
        checkoutController.currentAddress.value =
            '${place.street}, ${place.name}, ${place.subAdministrativeArea}, ${place.postalCode}';
        checkoutController.address_1.value = '${place.street},${place.name} ${place.subLocality}';
        checkoutController.postcode.value = '${place.postalCode}';
        checkoutController.country.value = '${place.isoCountryCode}';
        checkoutController.state.value = '${place.administrativeArea}';
        checkoutController.city.value = '${place.locality}';
      }
    }).catchError((e) {
      Get.back();

      debugPrint(e.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentPosition();
    cameraPosition = CameraPosition(target: _center, zoom: 14.0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mapController.dispose();
  }
  final yourGoogleAPIKey = 'AIzaSyCkB-DOHe10da6eN4qBVOSJgWOy_cmYd5o';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Obx(() {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        commonMenuIconWidget(
                          onTap: () {
                            Get.back();
                          },
                          icon: DefaultImages.backIcn,
                          color: AppColor.cLightBlue,
                          bColor: AppColor.cLightBlue,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              height: 43,
                              child: CustomGooglePlacesAutoCompleteTextFormField(
                                textEditingController: checkoutController.searchPlace,
                                googleAPIKey: yourGoogleAPIKey,
                                // proxyURL: _yourProxyURL,
                                maxLines: 1,
                                isLatLngRequired: true,
                                getPlaceDetailWithLatLng: (postalCodeResponse) {
                                  print("postalCodeResponse---------($postalCodeResponse)");
                                  print("description---------(${postalCodeResponse.description})");
                                  print("postalCodeResponse1---------(${postalCodeResponse.lat})");
                                  print("postalCodeResponse2---------(${postalCodeResponse.lng})");
                                  checkoutController.searchPlace.text = postalCodeResponse.description!;
                                  checkoutController.currentAddress.value = postalCodeResponse.description!;
                                  _getAddressFromLatLng(LatLng(double.parse(postalCodeResponse.lat!), double.parse(postalCodeResponse.lng!)), false);
                                },
                                itmClick: (postalCodeResponse) {
                                  print("itmClick---------($postalCodeResponse)");
                                },
                                overlayContainer: (child) => Material(
                                  elevation: 1.0,
                                  color:AppColor.cBackGround,
                                  borderRadius: BorderRadius.circular(12),
                                  shadowColor: AppColor.cShadow,
                                  textStyle: pMedium12,
                                  child: child,
                                ),

                                inputDecoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColor.cWhite,
                                  hintText: 'Search...',
                                  hintStyle: pMedium12,
                                  prefixIcon: assetSvdImageWidget(
                                      image: DefaultImages.searchIcn,
                                      colorFilter: ColorFilter.mode(AppColor.cBlack, BlendMode.srcIn)),
                                  prefixIconConstraints: BoxConstraints(minWidth: 43, maxWidth: 45),
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.clear, color: AppColor.cGreyFont),
                                    onPressed: () {
                                      checkoutController.searchPlace.clear();
                                    },
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: AppColor.cBorder)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: AppColor.cBorder)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: AppColor.cBorder)),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: AppColor.cBorder)),
                                ),
                              ),
                              // child: searchWidget(
                              //   checkoutController.searchPlace,
                              //   bColor: AppColor.cBorder,
                              // ),
                            ),
                          ),
                        ),
                        commonMenuIconWidget(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: AppColor.cTransparent,
                              barrierColor: AppColor.cDarkGrey,
                              constraints: BoxConstraints(maxHeight: Get.height - 200, minHeight: Get.height - 200),
                              isScrollControlled: true,
                              isDismissible: false,
                              enableDrag: false,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10),
                                ),
                              ),
                              builder: (context) {
                                return savedAddressWidget();
                              },
                            );
                          },
                          icon: DefaultImages.filtersIcn,
                        ),
                      ],
                    ),
                    verticalSpace(15),
                    Text(
                      "Select place from the map".tr,
                      style: pBold14,
                    ),
                    verticalSpace(15),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: 330,
                        child: GoogleMap(
                          onMapCreated: _onMapCreated,
                          onTap: (latLang) {
                            _center = latLang;
                            _add();
                            _getAddressFromLatLng(latLang, true);
                          },
                          markers: Set<Marker>.of(checkoutController.markers.values),
                          // YOUR MARKS IN MAP
                          initialCameraPosition: cameraPosition,
                        ),
                      ),
                    ),
                    verticalSpace(15),
                    CommonTextField(
                      hintText: 'Enter title..',
                      labelText: 'Title:',
                      controller: checkoutController.titleController.value,
                      maxLines: 1,
                      onChanged: (value) {
                        checkoutController.titleController.refresh();
                      },
                    ),
                    addressWidget(
                        title: checkoutController.titleController.value.text,
                        subTitle: "${checkoutController.currentAddress}"),
                    CommonIconBorderButton(
                      title: 'Save Address'.tr,
                      iconData: DefaultImages.doneIcn,
                      btnColor: checkoutController.currentAddress.value == ''
                          ? AppColor.cCategoryLabel
                          : AppColor.blueThemeColor,
                      textColor: AppColor.cBtnTxt,
                      onPressed: () {
                        checkoutController.currentAddress.value == ''
                            ? commonToast('Please select address.')
                            : checkoutController.saveAddress();
                      },
                    )
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget savedAddressWidget() {
    return Column(
      children: [
        Center(
          child: CommonIconBorderButton(
            width: 125,
            radius: 20,
            iconData: DefaultImages.cancelIcn,
            btnColor: AppColor.cDarkGrey,
            title: 'Cancel'.tr,
            onPressed: () {
              Get.back();
            },
          ),
        ),
        verticalSpace(15),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.cWhite,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Save Address".tr,
                  style: pBold14,
                ),
                verticalSpace(15),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: checkoutController.addressList.length,
                    itemBuilder: (context, index) {
                      AddressData address = checkoutController.addressList[index];
                      return addressWidget(title: address.addressTitle, subTitle: address.address);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget addressWidget({String? title, String? subTitle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 67.74,
        width: Get.width,
        decoration: BoxDecoration(
            color: AppColor.cLightBlue,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.blueThemeColor)),
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            SizedBox(width: 24, child: Image.asset(DefaultImages.markerIcn)),
            horizontalSpace(8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: pBold12.copyWith(fontSize: 11),
                  ),
                  verticalSpace(4),
                  Text(
                    subTitle!,
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

Future<BitmapDescriptor> createMarkerImageFromAsset(BuildContext context, String image) async {
  final Uint8List markerIcon = await getBytesFromAsset(image, 100);
  return BitmapDescriptor.fromBytes(markerIcon);
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
}

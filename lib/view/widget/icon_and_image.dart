// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gostore_app/view/widget/loading_widget.dart';

Widget assetSvdImageWidget({
  String? image,
  double? width,
  double? height,
  BoxFit? fit,
  final ColorFilter? colorFilter,
  Clip clipBehavior = Clip.hardEdge,
}) =>
    Align(
      child: SvgPicture.asset(
        image!,
        fit: fit ?? BoxFit.contain,
        height: height,
        width: width,
        colorFilter: colorFilter,
        clipBehavior: clipBehavior,
      ),
    );

Widget buildCachedNetworkImage({
  required String imageUrl,
  double? height,
  double? width,
  BoxFit? fit,
}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    height: height,
    width: width,
    fit: fit ?? BoxFit.fill,
    placeholder: (context, url) => LoadingWidget(),
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}

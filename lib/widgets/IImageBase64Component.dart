import 'dart:convert';

import 'package:flutter/widgets.dart';

class IImageBase64Component extends StatelessWidget {
  final String image;
  final BoxFit fit;
  final double? width;
  final double? height;

  const IImageBase64Component(
      {Key? key,
      required this.image,
      required this.fit,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !image.contains("https")
        ? image.contains("data")
            ? Image.memory(
                base64Decode(image.split(",")[1]),
                fit: fit,
                width: width,
                height: height,
              )
            : Image.memory(
                base64Decode(image),
                fit: fit,
                width: width,
                height: height,
              )
        : Image.network(
            image,
            fit: fit,
            width: width,
            height: height,
          );
  }
}

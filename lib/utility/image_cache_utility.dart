import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

CachedNetworkImage cacheImage(String imageUrl) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    // progressIndicatorBuilder: (context, url, downloadProgress) =>
    //           CircularProgressIndicator(value: downloadProgress.progress),
    // how the image look like in UI (decoration of image)
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
          // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
        ),
      ),
    ),
    // when image is being downloaded
    placeholder: (context, url) => const LinearProgressIndicator(),
    // when error occur (invalid url etc)
    errorWidget: (context, url, error) => const Icon(Icons.error),
    // errorWidget: (context, url, error) {
    // error is a HttpExceptionWithStatus object and
    // has properties:
    // message → String; runtimeType → Type;
    // statusCode → int; uri → Uri
    //   var _errorText = "Image unavailable\n";
    //   if (error.statusCode == 403 || error.statusCode == 404) {

    //   }
    //   return Center(
    //     child: Text(
    //       _errorText,
    //       style: TextStyle(
    //           color: Colors.redAccent[700], fontWeight: FontWeight.bold),
    //     ),
    //   );
    // }
  );
}

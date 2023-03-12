<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->
# Incento Flutter

Flutter plugin for Incento SDK.

This package can be easily integrated in any flutter application for generation and redeeming coupon codes for various e-commerce merchants and small scale businesses.

## Installation

This plugin is available on Pub: [https://pub.dev/packages/incento](https://pub.dev/packages/incento)

Add this to `dependencies` in your app's `pubspec.yaml`

```yaml
incento: ^0.0.1
```

## Usage

Sample code to integrate can be found in [example/lib/main.dart](example/lib/main.dart).

#### Import package

```dart
import 'package:incento/incento.dart';
```

#### Create Incento SDK instance

```dart
incentoSDK = IncentoSDK();
```

#### Setup options

```dart
var options = {
   "company_name": "API_KEY",
    "coupon_code": "###-###-####",
"category": "YOUR_PRODUCT_CATEGORY",
"uid": "UNIQUE_UID"
  };
```

## Features

1. Easy and seamless integration of coupon codes
2. Simple UI to display all available coupons
3. Obtain API_KEY to get started.

## Getting started

Users can get the API_KEY after registration of their company on our portal . The same API_KEY can be used for further usage of this package.

## Usage

There are two ways to get started:

1. Using the provided built-in widget Coupons to access list of available coupons as per your API_KEY
2. Using a user-defined voucher code and calling in the (verify) and (redeem) methods along with your payment service

The handlers would be defined somewhere as

```dart

 Future<Map<String, dynamic>> verify(Map<String, dynamic> options) async {
    // To be called when coupon code needs to be verified
 }

Future<Map<String, dynamic>> redeem(Map<String, dynamic> options) async {
    // To be called when coupon code needs to be redeemed
 }

MyCoupons() // To be called when list of available coupons need to be displayed

```

## Additional information

Issues and pull requests are always welcome 😄

If you find this package useful for you and liked it, give it a like ❤️ and star the repo ⭐️ it would mean a lot!

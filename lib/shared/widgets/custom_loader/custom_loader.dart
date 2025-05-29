import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:secure_vault/core/constants/app_colors.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    // Using SpinKitSpinningLines animation from flutter_spinkit package
    // size: controls the size of the spinner
    // color: uses the white color defined in app colors constants
    return SpinKitSpinningLines(
      size: 150,
      color: AppColors.white,
    );
  }
}

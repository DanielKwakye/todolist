import 'package:flutter/material.dart';
import 'package:todolist/core/utils/constants.dart';
import 'package:todolist/core/utils/theme.dart';
import 'package:todolist/features/shared/presentation/widgets/custom_gradient_border_widget.dart';

class CustomDefaultLogoWidget extends StatelessWidget {

  final bool setGradientBorder;
  final double size;

  const CustomDefaultLogoWidget({this.size = 70, this.setGradientBorder = true, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final icon = Image.asset(kAppIcon);

    return SizedBox(
      width: size,
      height: size,
      child: setGradientBorder ?
      CustomGradientBorderWidget(
          padding: 20,
          gradient: kAppLinearGradient, child: icon ) : icon,
    );
  }


}

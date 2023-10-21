import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todolist/core/utils/constants.dart';

class EmptyTaskWidget extends StatelessWidget {
  const EmptyTaskWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(kEmptyContentJson),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:  RichText(
            text: TextSpan(
              text: "Empty List",
              style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 24, ),
              children: [
                const TextSpan(text: "\n"),
                TextSpan(text: "Use the plus button at the button right to add new task", style: theme.textTheme.bodyMedium?.copyWith())
              ],

            ),
            textAlign: TextAlign.center,
          ),
          // Text("Empty list.\nUse the plus button at the button right to add new task", style: theme.textTheme.bodyMedium, textAlign: TextAlign.center,),
        )
      ],
    );
  }
}

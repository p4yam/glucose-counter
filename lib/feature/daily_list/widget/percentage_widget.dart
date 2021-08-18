import 'package:flutter/material.dart';
import 'package:glucose_counter/core/utils/app_colors.dart';
import 'package:glucose_counter/core/utils/text_themes.dart';

class PercentageWidget extends StatelessWidget {
  final int percentage;

  const PercentageWidget({Key key, this.percentage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SizedBox(
          width: 42,
          height: 42,
          child: Stack(
            children: [
              SizedBox(
                width: 42,
                height: 42,
                child: CircularProgressIndicator(
                  value: percentage/100,
                  color: (percentage>=80 && percentage<=110)?AppColor.Green:AppColor.RedAccent,
                  backgroundColor: AppColor.GrayLight,
                ),
              ),
              SizedBox(
                width: 42,
                height: 42,
                child: Center(
                  child: Text(
                    '$percentage',
                    textAlign: TextAlign.center,
                    style: TextThemes.blackNormal19,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

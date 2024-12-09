import 'package:flutter/material.dart';

class ScreenContainer extends StatelessWidget {

  final Widget? child;
  const ScreenContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
                /*width: ScreenUtil.getResponsiveWidth(context, percentage: 0.9),
                height: ScreenUtil.getResponsiveHeight(context, 0.9),*/
                margin: const EdgeInsetsDirectional.all(32),
                padding: const EdgeInsetsDirectional.all(8),
                decoration: BoxDecoration(
                    color: Colors.black26,
                    border: Border.all(color: Colors.black87),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(8))),
                child: child
      ),
    );
  }
}

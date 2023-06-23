import 'package:flutter/material.dart';

import '../Components/ui_widgets.dart';
import '../Constants/colors.dart';

class OptionsPage extends StatelessWidget {
  final Widget pageOptions;
  const OptionsPage({
    required this.pageOptions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: CustomScrollView(
          slivers: [
            // 1 AppBar
            customAppbar(context: context, title: "Options"),

            // 1 Body
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    child: Column(
                      children: [
                        // 1 Page Options
                        pageOptions,
                      ],
                    ),
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

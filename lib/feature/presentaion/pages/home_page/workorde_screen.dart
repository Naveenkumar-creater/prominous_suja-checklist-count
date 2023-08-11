import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_providers.dart';
import '../../../../constant/utils/font_styles.dart';
import '../../../../constant/utils/qr_code/qrcode_scaner.dart';
import '../../../../constant/utils/theme_styles.dart';
import '../widget/home_page_widget/workorder_widget/workorder_res_gridview.dart';

class WorkOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Headings(
              heading: 'Work Schedule',
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            WorkOrdersGridView(),
            const SizedBox(
              height: defaultPadding,
            ),
            Headings(
              subHeading: 'Scan Machine Code',
            ),
            const SizedBox(height: defaultPadding * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QrScanner(),
                        ));
                  },
                  child: Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                          color: themeState.isDarkTheme
                              ? const Color(0xFF424242)
                              : const Color(0xFFECF0F6),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            //   BoxShadow(
                            //       color: Colors.grey.shade400,
                            //       offset: Offset(4.0, 4.0),
                            //       blurRadius: 15.0,
                            //       spreadRadius: 1.0),
                            //   BoxShadow(
                            //       color: Colors.white,
                            //       offset: Offset(-4.0, -4.0),
                            //       blurRadius: 15.0,
                            //       spreadRadius: 1.0)
                            // ])

                            BoxShadow(
                                color: themeState.isDarkTheme
                                    ? const Color(0xFF0d0d0d)
                                    : Colors.grey.shade400,
                                offset: const Offset(5.0, 5.0),
                                blurRadius: 15.0,
                                spreadRadius: 1.0),
                            // BoxShadow(
                            //     color: themeState.isDarkTheme
                            //         ? const Color(0xFF0d0d0d)
                            //         : Colors.grey.shade400,
                            //     offset: const Offset(-5.0, -5.0),
                            //     blurRadius: 15.0,
                            //     spreadRadius: 1.0)
                          ]),
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Icon(
                          Icons.qr_code_outlined,
                          color: Colors.blue,
                          size: 150,
                        ),
                      )

                      //  Lottie.asset(
                      //     'assets/animations/5427-scan-qr-code.json'),
                      ),
                ),
              ],
            ),
            SizedBox(
              height: defaultPadding * 2,
            )
          ],
        ),
      ),
    );
  }
}

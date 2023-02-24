import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:petshop/app/modules/setting/views/setting_view.dart';
import 'package:petshop/app/theme/theme.dart';
import 'package:petshop/app/utils/loading.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

import '../controllers/dashboard_admin_controller.dart';

class DashboardAdminView extends GetView<DashboardAdminController> {
  DashboardAdminView({Key? key}) : super(key: key);
  final DashboardAdminController controller =
      Get.put(DashboardAdminController());

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: StreamBuilder<DocumentSnapshot<Object?>>(
            stream: controller.getUserDoc(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return LoadingView();
              }
              if (snap.hasData) {
                var nama = snap.data!.get("name");
                var alamat = snap.data!.get("alamat");

                var defaultImage =
                    "https://ui-avatars.com/api/?name=${nama}&background=fff38a&color=5175c0&font-size=0.33";
                return LayoutBuilder(builder: (context, constraints) {
                  final textScale = MediaQuery.of(context).textScaleFactor;
                  final bodyHeight = MediaQuery.of(context).size.height;
                  -MediaQuery.of(context).padding.top;
                  final bodyWidth = MediaQuery.of(context).size.width;
                  return SingleChildScrollView(
                    padding: EdgeInsets.only(
                      left: bodyWidth * 0.05,
                      right: bodyWidth * 0.05,
                      bottom: bodyHeight * 0.01,
                    ),
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minWidth: constraints.maxHeight),
                      child: IntrinsicHeight(
                          child: Column(
                        children: [
                          SizedBox(
                            height: bodyHeight * 0.07,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: bodyHeight * 0.005,
                              ),
                              Container(
                                width: bodyWidth * 1,
                                height: bodyHeight * 0.085,
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  onTap: () {
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);

                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                  },
                                  style: TextStyle(color: dark),
                                  decoration: InputDecoration(
                                      prefixIcon: Align(
                                          widthFactor: 1.0,
                                          heightFactor: 1.0,
                                          child: FaIcon(
                                            FontAwesomeIcons.searchengin,
                                            color: Red1,
                                          )),
                                      hintText: 'Cari Barang',
                                      hintStyle: heading6.copyWith(
                                          color: Grey1,
                                          fontSize: 14 * textScale),
                                      focusColor: Blue1,
                                      fillColor: light,
                                      filled: true,
                                      errorStyle: TextStyle(
                                        fontSize: 13.5 * textScale,
                                        color: light,
                                        background: Paint()
                                          ..strokeWidth = 13
                                          ..color = errorBg
                                          ..style = PaintingStyle.stroke
                                          ..strokeJoin = StrokeJoin.round,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: errorBg, width: 1.8),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          gapPadding: 2),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: error, width: 1.8),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Blue1, width: 1.8),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                ),
                              ),
                              SizedBox(
                                height: bodyHeight * 0.008,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: bodyHeight * 0.01,
                                  left: bodyWidth * 0.05,
                                  right: bodyWidth * 0.05,
                                ),
                                width: bodyWidth * 0.8,
                                height: bodyHeight * 0.40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              10), // Image border
                                          child: SizedBox.fromSize(
                                            // Image radius
                                            child: Image.asset(
                                              'assets/images/foto1.jpg',
                                              height: 250,
                                              width: 270,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: bodyHeight * 0.01,
                                        ),
                                        Text(
                                          'Ini Adalah Kucing',
                                          style: TextStyle(
                                              fontSize: 20, color: Purple),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.paw,
                                          color: Red1,
                                        ),
                                        SizedBox(
                                          width: bodyWidth * 0.02,
                                        ),
                                        Text(
                                          'Harga Kucing Ini',
                                          style: TextStyle(
                                              fontSize: 20, color: Purple),
                                        ),
                                        ClipOval(
                                          child: Material(
                                            color: Colors.transparent,
                                            child: IconButton(
                                              onPressed: () => () {},
                                              icon: FaIcon(
                                                FontAwesomeIcons.pencil,
                                                color: Red1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        ClipOval(
                                          child: Material(
                                            color: Colors.transparent,
                                            child: IconButton(
                                              onPressed: () => () {},
                                              icon: FaIcon(
                                                FontAwesomeIcons.trash,
                                                color: Red1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: bodyHeight * 1,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: bodyHeight * 0.01,
                                  left: bodyWidth * 0.05,
                                  right: bodyWidth * 0.05,
                                ),
                                width: bodyWidth * 0.8,
                                height: bodyHeight * 0.40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              10), // Image border
                                          child: SizedBox.fromSize(
                                            // Image radius
                                            child: Image.asset(
                                              'assets/images/foto1.jpg',
                                              height: 250,
                                              width: 270,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: bodyHeight * 0.01,
                                        ),
                                        Text(
                                          'Ini Adalah Kucing',
                                          style: TextStyle(
                                              fontSize: 20, color: Purple),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.paw,
                                          color: Red1,
                                        ),
                                        SizedBox(
                                          width: bodyWidth * 0.02,
                                        ),
                                        Text(
                                          'Harga Kucing Ini',
                                          style: TextStyle(
                                              fontSize: 20, color: Purple),
                                        ),
                                        ClipOval(
                                          child: Material(
                                            color: Colors.transparent,
                                            child: IconButton(
                                              onPressed: () => () {},
                                              icon: FaIcon(
                                                FontAwesomeIcons.pencil,
                                                color: Red1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        ClipOval(
                                          child: Material(
                                            color: Colors.transparent,
                                            child: IconButton(
                                              onPressed: () => () {},
                                              icon: FaIcon(
                                                FontAwesomeIcons.trash,
                                                color: Red1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: bodyHeight * 1,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: bodyHeight * 0.01,
                                  left: bodyWidth * 0.05,
                                  right: bodyWidth * 0.05,
                                ),
                                width: bodyWidth * 0.8,
                                height: bodyHeight * 0.40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              10), // Image border
                                          child: SizedBox.fromSize(
                                            // Image radius
                                            child: Image.asset(
                                              'assets/images/foto1.jpg',
                                              height: 250,
                                              width: 270,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: bodyHeight * 0.01,
                                        ),
                                        Text(
                                          'Ini Adalah Kucing',
                                          style: TextStyle(
                                              fontSize: 20, color: Purple),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.paw,
                                          color: Red1,
                                        ),
                                        SizedBox(
                                          width: bodyWidth * 0.02,
                                        ),
                                        Text(
                                          'Harga Kucing Ini',
                                          style: TextStyle(
                                              fontSize: 20, color: Purple),
                                        ),
                                        ClipOval(
                                          child: Material(
                                            color: Colors.transparent,
                                            child: IconButton(
                                              onPressed: () => () {},
                                              icon: FaIcon(
                                                FontAwesomeIcons.pencil,
                                                color: Red1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        ClipOval(
                                          child: Material(
                                            color: Colors.transparent,
                                            child: IconButton(
                                              onPressed: () => () {},
                                              icon: FaIcon(
                                                FontAwesomeIcons.trash,
                                                color: Red1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                    ),
                  );
                });
              } else {
                return LoadingView();
              }
            }));
  }
}

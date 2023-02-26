import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/rendering.dart';
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
        body: StreamBuilder<QuerySnapshot<Object?>>(
            stream: controller.getUserDoc(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return LoadingView();
              }
              if (snap.hasData) {
                var listAllDocs = snap.data!.docs;

                return LayoutBuilder(
                  builder: (context, constraints) {
                    final textScale = MediaQuery.of(context).textScaleFactor;
                    final bodyHeight = MediaQuery.of(context).size.height;
                    -MediaQuery.of(context).padding.top;
                    final bodyWidth = MediaQuery.of(context).size.width;
                    return SingleChildScrollView(
                      reverse: false,
                      padding: EdgeInsets.only(
                        left: bodyWidth * 0.05,
                        right: bodyWidth * 0.05,
                        bottom: bodyHeight * 0.01,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: bodyHeight * 0.06,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: bodyWidth * 0.9,
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
                            ],
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.only(
                                  bottom: bodyHeight * 0.015,
                                  top: bodyHeight * 0.01),
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: listAllDocs.length,
                              // itemCount: 20,
                              itemBuilder: (context, index) {
                                var nama = {
                                  (listAllDocs[index].data()
                                      as Map<String, dynamic>)["name"]
                                };
                                var defaultImage =
                                    "https://ui-avatars.com/api/?name=${nama}&background=fff38a&color=5175c0&font-size=0.33";
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: bodyHeight * 0.01),
                                  child: Material(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    child: InkWell(
                                      child: SizedBox(
                                        width: bodyWidth * 1,
                                        height: bodyHeight * 0.309,
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10), // Image border
                                              child: SizedBox.fromSize(
                                                // Image radius
                                                child: Image.asset(
                                                  'assets/images/foto1.jpg',
                                                  height: 200,
                                                  width: 220,
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Ini Adalah Kucing',
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Purple),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                  textScaleFactor: 1,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Purple,
                                                  ),
                                                ),
                                                ClipOval(
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        Get.defaultDialog(
                                                            title: "ini dialog",
                                                            content:
                                                                getmasukin(),
                                                            onConfirm: () {},
                                                            onCancel:
                                                                (Get.back));
                                                      },
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
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom *
                                          0.4))
                        ],
                      ),
                    );
                  },
                );
              } else {
                return LoadingView();
              }
            }));
  }

  Widget getmasukin() {
    return Expanded(
      child: Column(
        children: [
          Stack(
            children: [
              GetBuilder<DashboardAdminController>(
                builder: (c) {
                  if (c.image != null) {
                    return Center(
                      child: Container(
                        width: 150,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade200,
                        ),
                        child: Image.file(
                          File(c.image!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Container(
                        width: 150,
                        height: 90,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    );
                  }
                },
              ),
              //button untuk ganti foto profil
              Positioned(
                child: ClipOval(
                  child: Material(
                    color: backgroundOrange,
                    child: IconButton(
                      onPressed: () {
                        controller.pickImage();
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.camera,
                        color: light,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            // controller:
            //     controller.alamatC,

            // validator: controller
            //     .alamatValidator,
            style: TextStyle(color: dark),
            decoration: InputDecoration(
                prefixIcon: Align(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: Icon(
                      Icons.input_sharp,
                      color: Red1,
                    )),
                hintText: 'Nama Barang',
                hintStyle: heading6.copyWith(color: Grey1, fontSize: 14),
                focusColor: Blue1,
                fillColor: light,
                filled: true,
                errorStyle: TextStyle(
                  fontSize: 13.5,
                  color: light,
                  background: Paint()
                    ..strokeWidth = 13
                    ..color = errorBg
                    ..style = PaintingStyle.stroke
                    ..strokeJoin = StrokeJoin.round,
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: errorBg, width: 1.8),
                    borderRadius: BorderRadius.circular(12),
                    gapPadding: 2),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: error, width: 1.8),
                    borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Blue1, width: 1.8),
                    borderRadius: BorderRadius.circular(12)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            // controller:
            //     controller.alamatC,

            // validator: controller
            //     .alamatValidator,
            style: TextStyle(color: dark),
            decoration: InputDecoration(
                prefixIcon: Align(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: FaIcon(
                      FontAwesomeIcons.moneyBill1,
                      color: Red1,
                    )),
                hintText: 'Harga Barang',
                hintStyle: heading6.copyWith(color: Grey1, fontSize: 14),
                focusColor: Blue1,
                fillColor: light,
                filled: true,
                errorStyle: TextStyle(
                  fontSize: 13.5,
                  color: light,
                  background: Paint()
                    ..strokeWidth = 13
                    ..color = errorBg
                    ..style = PaintingStyle.stroke
                    ..strokeJoin = StrokeJoin.round,
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: errorBg, width: 1.8),
                    borderRadius: BorderRadius.circular(12),
                    gapPadding: 2),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: error, width: 1.8),
                    borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Blue1, width: 1.8),
                    borderRadius: BorderRadius.circular(12)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
        ],
      ),
    );
  }
}

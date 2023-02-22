import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
        body: FutureBuilder<DocumentSnapshot<Object?>>(
            future: controller.getUserDoc(),
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
                              AnimSearchBar(
                                width: 400,
                                textController: textController,
                                onSuffixTap: () {},
                                color: Yellow1,
                                onSubmitted: Get.to,
                              )
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

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:seller/common/widgets/appbar.dart';
import 'package:seller/config/colors.dart';

class DetailBudidayaPage extends StatelessWidget {
  const DetailBudidayaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: CustomAppbar(appbarText: 'Detail Budidaya'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:seller/common/widgets/appbar.dart';
import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';
import 'package:seller/core/route/bloc_route.dart';
import 'package:seller/core/route/route_page.dart';
import 'package:seller/modules/pond/bloc/bloc_pond.dart';
import 'package:seller/modules/pond/model/model_pond.dart';

class ProductSettingPage extends StatelessWidget {
  const ProductSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pondBloc = context.read<PondBloc>();
    return Scaffold(
      appBar: const CustomAppbar(appbarText: 'Pengaturan Produk'),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        color: CustomColor.white,
        child: Column(
          children: [
            _ItemCategori(
              text: 'Kolam',
              subText: 'Tambahkan Daftar kolam Anda',
              onTap: () => RouteBloc().push(RouteListPool()),
            ),
            _ItemCategori(
              text: 'Jenis Ikan',
              subText: 'Daftar jenis ikan yang Anda kelola',
              onTap: () {},
            ),
            _ItemCategori(
              text: 'Budidaya',
              subText: 'Tambahkan daftar budidaya saat ini',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemCategori extends StatelessWidget {
  const _ItemCategori({
    Key? key,
    required this.text,
    required this.subText,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final String subText;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: CustomTextStyle.body1Medium,
                ),
                SizedBox(height: 6),
                Text(
                  subText,
                  style: CustomTextStyle.body3Medium
                      .copyWith(color: CustomColor.fadedGrey),
                ),
              ],
            ),
            Spacer(),
            Visibility(
              visible: false,
              child: Container(
                padding: EdgeInsets.all(6),
                child: Text(
                  '2',
                  style: CustomTextStyle.body2Medium.copyWith(
                    color: CustomColor.white,
                  ),
                ),
                decoration: BoxDecoration(
                    color: CustomColor.red, shape: BoxShape.circle),
              ),
            ),
            SizedBox(width: 8.0),
            Icon(
              IconlyLight.arrow_right_2,
              color: CustomColor.grey,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:seller/common/custom/empty_data.dart';

import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';
import 'package:seller/core/route/bloc_route.dart';
import 'package:seller/core/route/route_page.dart';
import 'package:seller/modules/budidaya/bloc/bloc_budidaya.dart';
import 'package:seller/modules/budidaya/model/model_budidaya.dart';
import 'package:seller/modules/edit_profile/bloc/bloc_edit_profile.dart';
import 'package:seller/modules/edit_profile/model/model_profile.dart';
import 'package:seller/modules/home/model/model_status.dart';
import 'package:seller/modules/budidaya/widget/w_budidaya_card.dart';
import 'package:seller/modules/pond/bloc/bloc_pond.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final blocPond = PondBloc();
    final blocbudidaya = context.read<BudidayaBloc>();
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: const _AppbarHome(),
      body: RefreshIndicator(
        onRefresh: () async {
          blocPond.getPond().catchError((e) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.message)));
          });
          blocbudidaya.getListBudidaya().catchError((e) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.message)));
          });
        },
        child: Column(
          children: [
            StreamBuilder<String>(
                stream: blocPond.status.stream,
                initialData: blocPond.status.value,
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  if (data == null || data == '') {
                    return const _SubmisionInfo();
                  }
                  if (data == StatusSubmission.actived) {
                    return const SizedBox();
                  }
                  return _SubmisionInfoInReview(status: data);
                }),
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                child: Column(
                  children: [
                    // _SubmisionInfoInReview(),
                    // _SubmisionInfoRejected(),
                    const SizedBox(height: 8),
                    const _WCategori(),
                    const SizedBox(height: 12.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Produk Anda',
                            style: CustomTextStyle.body2SemiBold,
                          ),
                          InkWell(
                            onTap: () => RouteBloc().push(RouteBudidaya()),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Text(
                                'Lihat Semua',
                                style: CustomTextStyle.body2SemiBold.copyWith(
                                  color: CustomColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    SizedBox(
                      height: 208,
                      child: StreamBuilder<List<BudidayaModel>>(
                          stream: blocbudidaya.listBudidaya.stream,
                          initialData: blocbudidaya.listBudidaya.value,
                          builder: (context, snapshot) {
                            final listData = snapshot.data;
                            if (listData == null || listData.isEmpty) {
                              return EmptyData(
                                label: 'Belum ada budidaya',
                                onRefresh: () async {},
                              );
                            }
                            return ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              itemBuilder: (context, index) {
                                return WBudidayaCard(
                                  budidayaModel: listData[index],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(width: 8.0);
                              },
                              itemCount: listData.length,
                            );
                          }),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubmisionInfo extends StatelessWidget {
  const _SubmisionInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          RouteBloc().push(RouteFormSubmission());
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 26),
          color: CustomColors.yellow,
          child: Text(
            'Silakan isi formulir pengajuan terlebih dahulu agar akun dapat digunakan.',
            textAlign: TextAlign.center,
            style: CustomTextStyle.body2Regular
                .copyWith(color: CustomColors.white),
          ),
        ));
  }
}

class _SubmisionInfoInReview extends StatelessWidget {
  const _SubmisionInfoInReview({
    Key? key,
    required this.status,
  }) : super(key: key);

  final String status;

  @override
  Widget build(BuildContext context) {
    final blocPond = PondBloc();
    return InkWell(
        onTap: () {
          blocPond.getPond();
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 26),
          color: StatusSubmission.statusColor(status),
          child: Text(
            StatusSubmission.statusInfo(status),
            textAlign: TextAlign.center,
            style: CustomTextStyle.body2Regular
                .copyWith(color: CustomColors.white),
          ),
        ));
  }
}

class _WCategori extends StatelessWidget {
  const _WCategori({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final blocPond = PondBloc();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: CustomColors.white,
      child: Column(
        children: [
          StreamBuilder<String>(
              stream: blocPond.status.stream,
              initialData: blocPond.status.value,
              builder: (context, snapshot) {
                final data = snapshot.data;
                if (data == null || data == '') {
                  return _ItemCategori(
                    text: 'Formulir Pengajuan',
                    subText: 'Pengajuan Untuk Mengaktifkan Akun',
                    iconData: IconlyBold.paper,
                    onTap: () => RouteBloc().push(RouteFormSubmission()),
                  );
                }
                return const SizedBox();
              }),
          _ItemCategori(
            text: 'Pesanan',
            subText: 'Daftar Pesanan Anda',
            iconData: IconlyBold.bag,
            onTap: () => RouteBloc().push(RouteOrder()),
          ),
          _ItemCategori(
            text: 'Pesan',
            subText: 'Pesan Pelanggan Anda',
            iconData: IconlyBold.chat,
            onTap: () => RouteBloc().push(RouteListChat()),
          ),
          _ItemCategori(
            text: 'Pengaturan Produk',
            subText: 'Atur Produk Anda',
            iconData: IconlyBold.setting,
            onTap: () => RouteBloc().push(RouteProductSetting()),
          ),
          _ItemCategori(
            text: 'Profile',
            subText: 'Atur Profile Anda',
            iconData: IconlyBold.profile,
            onTap: () => RouteBloc().push(RouteEditProfile()),
          ),
        ],
      ),
    );
  }
}

class _ItemCategori extends StatelessWidget {
  const _ItemCategori({
    Key? key,
    required this.text,
    required this.subText,
    required this.iconData,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final String subText;
  final IconData iconData;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: CustomColors.background,
              ),
              child: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) {
                  return const RadialGradient(
                    center: Alignment.bottomRight,
                    radius: 3,
                    colors: [
                      CustomColors.primary,
                      CustomColors.white,
                    ],
                    tileMode: TileMode.clamp,
                  ).createShader(bounds);
                },
                child: Icon(
                  iconData,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: CustomTextStyle.body1Medium,
                ),
                const SizedBox(height: 6),
                Text(
                  subText,
                  style: CustomTextStyle.body3Medium
                      .copyWith(color: CustomColors.fadedGrey),
                ),
              ],
            ),
            const Spacer(),
            Visibility(
              visible: false,
              child: Container(
                padding: const EdgeInsets.all(6),
                child: Text(
                  '2',
                  style: CustomTextStyle.body2Medium.copyWith(
                    color: CustomColors.white,
                  ),
                ),
                decoration: const BoxDecoration(
                    color: CustomColors.red, shape: BoxShape.circle),
              ),
            ),
            const SizedBox(width: 8.0),
            const Icon(
              IconlyLight.arrow_right_2,
              color: CustomColors.grey,
            )
          ],
        ),
      ),
    );
  }
}

class _AppbarHome extends StatelessWidget implements PreferredSizeWidget {
  const _AppbarHome({
    Key? key,
  }) : super(key: key);

// 101
  @override
  Size get preferredSize => const Size(double.infinity, 78);
  // Size get preferredSize => const Size(double.infinity, 124);

  @override
  Widget build(BuildContext context) {
    final blocProfile = context.read<EditProfileBloc>();
    return Column(
      children: [
        Container(
          height: 101,
          color: CustomColors.primary,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  // Icon(IconlyLight.arrow_left),
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: CustomColors.grey,
                    backgroundImage: AssetImage('assets/default_profile.png'),
                  ),
                  const SizedBox(width: 12.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat Datang,',
                        style: CustomTextStyle.body3Regular
                            .copyWith(color: CustomColors.white),
                      ),
                      const SizedBox(height: 2.0),
                      StreamBuilder<ProfileModel?>(
                          stream: blocProfile.profile.stream,
                          initialData: blocProfile.profile.value,
                          builder: (context, snapshot) {
                            final data = snapshot.data;
                            if (data == null) {
                              return Text(
                                '-',
                                style: CustomTextStyle.body1Medium
                                    .copyWith(color: CustomColors.white),
                              );
                            }
                            return Text(
                              data.name ?? '-',
                              style: CustomTextStyle.body1Medium
                                  .copyWith(color: CustomColors.white),
                            );
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

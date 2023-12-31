import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seller/common/custom/empty_data.dart';
import 'package:seller/common/widgets/appbar.dart';
import 'package:seller/common/widgets/button.dart';
import 'package:seller/config/colors.dart';
import 'package:seller/core/route/bloc_route.dart';
import 'package:seller/core/route/route_page.dart';
import 'package:seller/modules/fish/bloc/bloc_fish.dart';
import 'package:seller/modules/fish/model/model_fish.dart';
import 'package:seller/modules/fish/widget/w_fish.dart';

class ListFishPage extends StatelessWidget {
  const ListFishPage({super.key});

  @override
  Widget build(BuildContext context) {
    final blocFish = context.read<FishBloc>();
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: const CustomAppbar(appbarText: 'Jenis Ikan'),
      body: StreamBuilder<List<FishModel>>(
          stream: blocFish.listFish.stream,
          initialData: blocFish.listFish.value,
          builder: (context, snapshot) {
            final listData = snapshot.data;
            if (listData == null || listData.isEmpty) {
              return EmptyData(
                label: 'Belum ada Jenis Ikan',
                onRefresh: () => blocFish.getFishes(),
              );
            }
            return RefreshIndicator(
              onRefresh: () => blocFish.getFishes(),
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                itemBuilder: (context, index) {
                  return WFish(
                    fishModel: listData[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 12);
                },
                itemCount: listData.length,
              ),
            );
          }),
      bottomNavigationBar: Container(
        color: CustomColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: CustomButton(
          textButton: 'Tambah Jenis Ikan',
          onTap: () async => RouteBloc().push(RouteCreateFish()),
        ),
      ),
    );
  }
}

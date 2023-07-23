import 'package:flutter/material.dart';

import 'package:seller/common/widgets/appbar.dart';
import 'package:seller/common/widgets/button.dart';
import 'package:seller/common/widgets/text_input.dart';
import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';
import 'package:seller/modules/submission/bloc/bloc_submission.dart';

class PoolPage extends StatelessWidget {
  const PoolPage({
    Key? key,
    required this.submissionBloc,
  }) : super(key: key);

  final SubmissionBloc submissionBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.background,
      appBar: const CustomAppbar(appbarText: 'Tambah Kolam'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextInput(
                sStream: submissionBloc.poolName,
                label: 'Nama Kolam',
                hint: 'Masukkan Nama',
              ),
            ),
            const SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextInput(
                sStream: submissionBloc.poolLength,
                label: 'Pajang Kolam (dalam satuan meter)',
                hint: 'Masukkan Panjang',
              ),
            ),
            const SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextInput(
                sStream: submissionBloc.poolWidth,
                label: 'Pajang Kolam (dalam satuan meter)',
                hint: 'Masukkan Lebar',
              ),
            ),
            const SizedBox(height: 26),
            const _WPhoto(),
            const SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: CustomButton(
                textButton: 'Tambah',
                onTap: () async {},
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _WPhoto extends StatelessWidget {
  const _WPhoto({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: CustomColor.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Foto Kolam',
            style: CustomTextStyle.body2SemiBold.copyWith(
              color: CustomColor.primary,
            ),
          ),
          const Divider(),
          Text(
            'Silahkan upload Foto Kolam dengan cara menyentuh area/foto dibawah ini :',
            style: CustomTextStyle.body2Regular.copyWith(
              color: CustomColor.grey,
            ),
          ),
          const SizedBox(height: 8),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: CustomColor.fadedGrey),
                  color: CustomColor.fadedGrey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: Text(
                  'Pilih Gambar',
                  style: CustomTextStyle.body2SemiBold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

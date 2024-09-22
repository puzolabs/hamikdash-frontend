
import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/widgets/korban_widget.dart';
import 'package:hamikdash_sheli/korban.dart';

class KorbansWidget extends StatelessWidget {
  const KorbansWidget({
    super.key,
    required this.korbanot,
  });

  final List<Korban> korbanot;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.all(8),
      itemCount: korbanot.length,
      itemBuilder: (BuildContext context, int index) {
        return KorbanWidget(korban: korbanot[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 30,
      )
    );
  }
}

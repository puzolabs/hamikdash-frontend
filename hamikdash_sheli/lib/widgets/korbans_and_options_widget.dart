
import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/dataTypes/korban.dart';
import 'package:hamikdash_sheli/dataTypes/korbans_option.dart';
import 'package:hamikdash_sheli/widgets/korban_widget.dart';
import 'package:hamikdash_sheli/widgets/korbans_option_widget.dart';

class KorbansAndOptionsWidget extends StatelessWidget {
  const KorbansAndOptionsWidget({
    super.key,
    required this.korbanot,
    required this.explainer,
    required this.korbanotOptions,
    required this.onOptionSelected,
  });

  final List<Korban> korbanot;
  final Widget explainer;
  final List<KorbansOption> korbanotOptions;
  final Function(KorbansOption) onOptionSelected;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: korbanot.length + 1 + korbanotOptions.length, // +1 is for the explainer widget
      itemBuilder: (BuildContext context, int index) {
        return
          index < korbanot.length
          ? KorbanWidget(korban: korbanot[index])
          : index == korbanot.length
            ? explainer
            : KorbansOptionWidget(
                korbanotOption: korbanotOptions[index - korbanot.length - 1],
                onOptionSelected: onOptionSelected,
              );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      )
    );
  }
}

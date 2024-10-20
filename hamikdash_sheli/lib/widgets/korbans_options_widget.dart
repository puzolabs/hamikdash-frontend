
import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/korban.dart';
import 'package:hamikdash_sheli/widgets/korbans_option_widget.dart';

class KorbansOptionsWidget extends StatelessWidget {
  const KorbansOptionsWidget({
    super.key,
    required this.korbanotOptions,
    required this.onOptionSelected,
  });

  final List<KorbansOption> korbanotOptions;
  final Function(KorbansOption) onOptionSelected;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: korbanotOptions.length,
      itemBuilder: (BuildContext context, int index) {
        return KorbansOptionWidget(
          korbanotOption: korbanotOptions[index],
          onOptionSelected: onOptionSelected,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 250,
      )
    );
  }
}

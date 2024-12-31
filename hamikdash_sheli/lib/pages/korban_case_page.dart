import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/app_state.dart';
import 'package:hamikdash_sheli/calApi/date_selection_page.dart';
import 'package:hamikdash_sheli/dataTypes/korban_case.dart';
import 'package:hamikdash_sheli/dataTypes/korbans_option.dart';
import 'package:hamikdash_sheli/widgets/korbans_widget.dart';
import 'package:hamikdash_sheli/widgets/korbans_options_widget.dart';

class KorbanCasePage extends StatefulWidget {
  const KorbanCasePage({super.key, required this.korbanCase});

  final KorbanCase korbanCase;

  @override
  State<KorbanCasePage> createState() => _KorbanCasePageState();
}

class _KorbanCasePageState extends State<KorbanCasePage> {

  void _goToDateSelectionPage()
  {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
            return const DateSelectionPage(mode: DateSelectionMode.create);
        }
      )
    );
  }

  List<Widget> _buildPanel(BuildContext context)
  {
      if(widget.korbanCase.isSingleOptionKorbanCase)
      {
        return [
          Text(
            "עליכם להגיע למקדש עם הפריטים הבאים:",
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: KorbansWidget(korbanot: widget.korbanCase.korbanot!)
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: ElevatedButton(
                onPressed: () {
                  appState.currentVisit!.optionCode = OptionCodes.none;
                  _goToDateSelectionPage();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                ),
                child: const Text("המשך")
              ),
            ),
          ),
        ];
      }
      else if(widget.korbanCase.isMultiOptionsKorbanCase)
      {
        return [
          Text(
            "ביחרו אחת מהאפשרויות הבאות:",
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: KorbansOptionsWidget(
              korbanotOptions: widget.korbanCase.korbanotOptions!,
              onOptionSelected: (option) {
                appState.currentVisit!.optionCode = option.code;
                _goToDateSelectionPage();
              },
            ),
          ),
        ];
      }
      else if(widget.korbanCase.isComplexKorbanCase)
      {
        return [
          Text(
            "עליכם להגיע למקדש עם הפריטים הבאים:",
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: KorbansWidget(korbanot: widget.korbanCase.korbanot!),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(right: 25, top: 25),
              child: const Text(
                "בנוסף, ביחרו אחת מהאפשרויות הבאות:",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          Expanded(
            child: KorbansOptionsWidget(korbanotOptions: widget.korbanCase.korbanotOptions!,
              onOptionSelected: (option) {
                appState.currentVisit!.optionCode = option.code;
                _goToDateSelectionPage();
              },
            ),
          ),
        ];
      }
      else
      {
        return [];
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Directionality(
          textDirection: TextDirection.rtl,
          child:Text("המקדש שלי"),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: _buildPanel(context)
          ),
        ),
      )
    );
  }
}

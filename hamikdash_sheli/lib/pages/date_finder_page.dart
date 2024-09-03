
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hamikdash_sheli/cal/calcom_embed.dart';
import 'package:hamikdash_sheli/cal/calcom_embed_options.dart';
import 'coming_options_page.dart';
import '../utills/screen_dimension.dart';


class DateFinderPage extends StatelessWidget {
  const DateFinderPage({
    super.key,
  });

  void _goToComingOptionsPage(BuildContext context)
  {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
            return const ComingOptionsPage();
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    var embed = CalcomEmbed(CalcomEmbedOptions(CalcomEmbedSize(100, 100), "https://26cb-85-250-233-8.ngrok-free.app", "bet-hamikdash", "minha", "month_view", false));
    var html = embed.build();

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
            children: [
              Text(
                "מתי יהיה לכם נח להגיע?",
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                width: 99.percentOfScreenHeight(context),
                height: 70.percentOfScreenHeight(context),
                child: InAppWebView(
                  onReceivedServerTrustAuthRequest: (controller, challenge) async {
                    print("challenge: $challenge");
                    return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
                  },
                  onReceivedError: (controller, request, error) => {
                    print("onReceivedError error message: $error")
                  },
                  onReceivedHttpError: (controller, request, errorResponse) => {
                    print("onReceivedHttpError error message: $errorResponse")
                  },
                  onDidReceiveServerRedirectForProvisionalNavigation: (controller) => {
                    print("redirect")
                  },
                  initialData: InAppWebViewInitialData(data: html),
                  onWebViewCreated: (controller) {
                    controller.addJavaScriptHandler(
                        handlerName: 'handlerFoo',
                        callback: (args) {
                          print('got args $args');
                          // return data to the JavaScript side!
                          return {'bar': 'bar_value', 'baz': 'baz_value'};
                        });

                    controller.addJavaScriptHandler(
                        handlerName: 'handlerFooWithArgs',
                        callback: (args) {
                          print('got args $args');
                          // it will print: [1, true, [bar, 5], {foo: baz}, {bar: bar_value, baz: baz_value}]
                        });
                    },
                    onConsoleMessage: (controller, consoleMessage) {
                      print(consoleMessage);
                      // it will print: {message: {"bar":"bar_value","baz":"baz_value"}, messageLevel: 1}
                    },
                  ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  child:ElevatedButton(
                    onPressed: () {
                      _goToComingOptionsPage(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                    ),
                    child: const Text("המשך")
                  ),
                ),
              ),
            ]
          ),
        ),
      )
    );
  }
}

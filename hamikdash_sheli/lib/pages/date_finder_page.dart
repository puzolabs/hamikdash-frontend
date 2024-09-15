
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hamikdash_sheli/cal/calcom_embed.dart';
import 'package:hamikdash_sheli/cal/calcom_embed_options.dart';
import 'summery_page.dart';
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

  void _goToSummeryPage(BuildContext context)
  {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
            return const SummeryPage();
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    var embed = CalcomEmbed(CalcomEmbedOptions(CalcomEmbedSize(100, 100), "https://engaging-repeatedly-sloth.ngrok-free.app", "bet-hamikdash", "minha", "month_view", false));
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
              Container(
                padding: EdgeInsets.fromLTRB(2.percentOfScreenHeight(context), 0, 2.percentOfScreenHeight(context), 0),
                child: SizedBox(
                  width: 99.percentOfScreenHeight(context), //double.infinity,
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
                    //initialUrlRequest: URLRequest(
                      //url: WebUri("https://app.cal.com/rick/get-rick-rolled")
                      //url: WebUri("https://engaging-repeatedly-sloth.ngrok-free.app/team/bet-hamikdash/minha")
                    //),
                    onWebViewCreated: (controller) {
                      controller.addJavaScriptHandler(
                          handlerName: 'bookingSuccessful',
                          callback: (args) {
                            print('got args $args'); // it will print the selected date
                            _goToSummeryPage(context);
                          });
                      },
                      onConsoleMessage: (controller, consoleMessage) {
                        print(consoleMessage);
                      },
                    ),
                )
              ),
            ]
          ),
        ),
      )
    );
  }
}


import 'package:hamikdash_sheli/dataTypes/user.dart';

class CalcomEmbedSize {
  CalcomEmbedSize(this.width, this.height);

  int width = 100;
  int height = 100;
}

class CalcomEmbedOptions {
  CalcomEmbedOptions(this.size, this.host, this.teamName, this.eventTitle, this.layout, this.hideEventTypeDetails, this.user);

  CalcomEmbedSize size;
  String host; // "http://localhost:3000";
  String teamName; // "beit-hamikdash";
  String eventTitle; // "minha";
  String layout; // "month_view";
  bool hideEventTypeDetails = false;
  User user;
    //styles,
    //dark \ light theme
    //success callbacks

  Map<String, dynamic> toMap() {
    return {
      'size': {
        'width': size.width,
        'height': size.height,
      },
      'host': host,
      'teamName': teamName,
      'eventTitle': eventTitle,
      'layout': layout,
      'hideEventTypeDetails': hideEventTypeDetails,
      'user': {
        'name': user.name,
        'email': user.email,
      },
    };
  }
}
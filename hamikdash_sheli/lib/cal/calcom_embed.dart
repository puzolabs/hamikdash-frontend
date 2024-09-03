import 'dart:io';

import 'package:hamikdash_sheli/app_state.dart';
import 'package:mustache_template/mustache_template.dart';

import 'calcom_embed_options.dart';

class CalcomEmbed {
  CalcomEmbed(this.options);

  CalcomEmbedOptions options;

  String build() {
    var map = options.toMap();

    String text = appState.calTemplate;
    var template = Template(text);
    var output = template.renderString(map);
    
    return output;
  }
}

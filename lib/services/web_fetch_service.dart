import 'dart:convert'; // Contains the JSON encoder
import 'package:http/http.dart'; // Contains a client for making API calls
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart'; // Contains DOM related classes for extracting data from elements

Future initiate() async {
  var client = Client();
  Response response = await client.get(Uri.parse('https://leekduck.com/boss/'));

  print(response.body);

  // Use html parser
  var document = parse(response.body);
  List<Element> linksWithName = document.querySelectorAll('.boss-name');
  List<Element> linksWithSprite = document.querySelectorAll('.boss-img img:not(.shiny-icon)');
  print(linksWithName.length.toString() + ' - ' + linksWithSprite.length.toString());

  print(linksWithSprite[1].attributes.values);

  List<Map<String, dynamic>> bosses = [];

  for (var i = 0 ; i < linksWithName.length; i++) {
    bosses.add({
      'name': linksWithName[i].text,
      'sprite': 'https:'+linksWithSprite[i].attributes.values.first,
    });
  }

  return json.encode(bosses);
}
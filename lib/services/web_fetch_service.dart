import 'package:http/http.dart'; // Contains a client for making API calls
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart'; // Contains DOM related classes for extracting data from elements

class WebFetchService {



  Future fetchDataFromLeekDuck() async {
    try {
      var client = Client();
      Response response = await client.get(Uri.parse('https://leekduck.com/boss/'));

      // Use html parser
      var document = parse(response.body);

      // Query for names
      List<Element> linksWithName = document.querySelectorAll('.boss-name');
      // Query for sprites
      List<Element> linksWithSprite = document.querySelectorAll('.boss-img img:not(.shiny-icon)');

      // prints for debug
      // print(linksWithName.length.toString() + ' - ' + linksWithSprite.length.toString());
      // print(linksWithSprite[1].attributes.values);

      // Bosses in json
      List<Map<String, dynamic>> bosses = [];

      // Data processing
      for (var i = 0 ; i < linksWithName.length; i++) {
        bosses.add({
          'name': linksWithName[i].text,
          'sprite': 'https:'+linksWithSprite[i].attributes.values.first,
        });
      }

      return bosses;
    } on Exception catch (e) {
      print('Erro no service');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> fetchDataFromMestrePokemon() async {
    print('Fethcing data from MestrePokemon');

    try {
      var client = Client();
      Response response = await client.get(Uri.parse('https://mestrepokemongo.com.br/chefes-de-raid/'));

      // Use html parser
      var document = parse(response.body);

      // Query for names
      List<Element> linksWithName = document.querySelectorAll('.pokemon-name');

      // Query for sprites
      List<Element> linksWithSprite = document.querySelectorAll('.pkm-img');

      // Bosses in json
      List<Map<String, dynamic>> bosses = [];

      // Data processing
      for (var i = 0 ; i < linksWithName.length; i++) {
        bosses.add({
          'name': linksWithName[i].text,
          'sprite': linksWithSprite[i].attributes['src'],
        });
      }

      return bosses;
    } on Exception catch (e) {
      print('Erro no service');
      return null;
    }
  }
}

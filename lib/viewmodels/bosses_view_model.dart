import 'package:raid_list/initialize_get_it.dart';
import 'package:raid_list/services/web_fetch_service.dart';

class BossesViewModel {
  List<Map<String, dynamic>> bosses;
  WebFetchService service;

  BossesViewModel() {
    service = getIt.get<WebFetchService>();
  }

  setBosses(List<Map<String, dynamic>> _bosses){
    bosses = _bosses;
  }

  Future<Null> onAppStart() async {
    await service.fetchDataFromMestrePokemon().then((value) {
      setBosses(value);
    });
  }
}

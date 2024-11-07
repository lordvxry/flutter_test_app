import 'models/models.dart';

abstract class AbstractCoinsRepository {
  Future<CryptoCoin> getCoinDetails(String currencyCode);
  Future<List<CryptoCoin>> getCoinsList();
}
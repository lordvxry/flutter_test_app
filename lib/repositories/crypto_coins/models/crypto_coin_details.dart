import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_coin_details.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class CryptoCoinDetail extends Equatable {
  const CryptoCoinDetail({
    required this.priceInUSD,
    required this.imageUrl,
    required this.toSymbol,
    required this.high24Hour,
    required this.low24Hour,
    required this.lastUpdate,
  });

  @HiveField(0)
  @JsonKey(name: 'TOSYMBOL')
  final String toSymbol;

  @HiveField(1)
  @JsonKey(name: 'HIGH24HOUR')
  final double high24Hour;

  @HiveField(2)
  @JsonKey(name: 'LOW24HOUR')
  final double low24Hour;

  @HiveField(3)
  @JsonKey(name: 'PRICE')
  final double priceInUSD;

  @HiveField(4)
  @JsonKey(name: 'IMAGEURL')
  final String imageUrl;

  @HiveField(5)
  @JsonKey(
    name: 'LASTUPDATE',
    toJson: _dateTimeToJson,
    fromJson: _dateTimeFromJson,
  )
  final DateTime lastUpdate;

  String get fullImageUrl => 'https://www.cryptocompare.com/$imageUrl';

  factory CryptoCoinDetail.fromJson(Map<String, dynamic> json) =>
      _$CryptoCoinDetailFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoCoinDetailToJson(this);

  static int _dateTimeToJson(DateTime time) => time.millisecondsSinceEpoch;

  static DateTime _dateTimeFromJson(int milliseconds) =>
      DateTime.fromMicrosecondsSinceEpoch(milliseconds);

  @override
  List<Object> get props => [
        toSymbol,
        high24Hour,
        low24Hour,
        priceInUSD,
        imageUrl,
        lastUpdate,
      ];
}

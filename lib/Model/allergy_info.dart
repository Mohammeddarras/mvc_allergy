
import 'dart:convert';

// GetAllergy getAllergyFromJson(String str) => GetAllergy.fromJson(json.decode(str));
//
// String getAllergyToJson(GetAllergy data) => json.encode(data.toJson());
//
// class GetAllergy {
//   GetAllergy({
//     required this.allergy,
//   });
//
//   List<Allergy> allergy;
//
//   factory GetAllergy.fromJson(Map<String, dynamic> json) => GetAllergy(
//     allergy: List<Allergy>.from(json["allergy"].map((x) => Allergy.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "allergy": List<Allergy>.from(allergy.map((x) => x.toJson())),
//   };
// }

class Allergy {
  Allergy({
    required this.id,
    required this.arabicName,
    required this.englishName,
    this.value = false,
    required this.itemID
  });

  int id,itemID;
  String arabicName;
  String englishName;
  bool value;

  factory Allergy.fromJson(Map<String, dynamic> json) => Allergy(
      id: json["id"],
      arabicName: json["arabic_name"] ?? '',
      englishName: json["english_name"] ?? '',
      itemID: json['item_id'] ?? 0
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "arabic_name": arabicName,
    "english_name": englishName,
  };
}

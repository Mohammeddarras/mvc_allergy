class HistoryModel{
  final String request_items,allergy_items,created_at;

  HistoryModel({required this.request_items,required this.allergy_items,required this.created_at});

  factory HistoryModel.fromJson(final Map<String,dynamic> json){

    return HistoryModel(
      allergy_items: json['allergy_items']??'',
      request_items: json['request_items']?? '',
      created_at: json['created_at']??'',
    );
  }
}
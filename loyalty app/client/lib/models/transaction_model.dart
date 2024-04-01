/// _id : "65f23055036e172da62ffe94"
/// userId : "65f22ff9036e172da62ffe8d"
/// item_name : "Macbook cover"
/// price : 400
/// transactionDate : "2024-03-13T23:01:41.360Z"
/// __v : 0
/// full_name : "Sajid Ali"

class TransactionModel {
  TransactionModel({
      String? id, 
      String? userId, 
      String? itemName, 
      num? price, 
      String? transactionDate, 
      num? v, 
      String? fullName,}){
    _id = id;
    _userId = userId;
    _itemName = itemName;
    _price = price;
    _transactionDate = transactionDate;
    _v = v;
    _fullName = fullName;
}

  TransactionModel.fromJson(dynamic json) {
    _id = json['_id'];
    _userId = json['userId'];
    _itemName = json['item_name'];
    _price = json['price'];
    _transactionDate = json['transactionDate'];
    _v = json['__v'];
    _fullName = json['full_name'];
  }
  String? _id;
  String? _userId;
  String? _itemName;
  num? _price;
  String? _transactionDate;
  num? _v;
  String? _fullName;
TransactionModel copyWith({  String? id,
  String? userId,
  String? itemName,
  num? price,
  String? transactionDate,
  num? v,
  String? fullName,
}) => TransactionModel(  id: id ?? _id,
  userId: userId ?? _userId,
  itemName: itemName ?? _itemName,
  price: price ?? _price,
  transactionDate: transactionDate ?? _transactionDate,
  v: v ?? _v,
  fullName: fullName ?? _fullName,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get itemName => _itemName;
  num? get price => _price;
  String? get transactionDate => _transactionDate;
  num? get v => _v;
  String? get fullName => _fullName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['userId'] = _userId;
    map['item_name'] = _itemName;
    map['price'] = _price;
    map['transactionDate'] = _transactionDate;
    map['__v'] = _v;
    map['full_name'] = _fullName;
    return map;
  }

}
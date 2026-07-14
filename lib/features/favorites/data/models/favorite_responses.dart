class FavoriteResponses {
  FavoriteResponses({
      this.totalElements, 
      this.totalPages, 
      this.pageable, 
      this.first, 
      this.last, 
      this.size, 
      this.content, 
      this.number, 
      this.sort, 
      this.numberOfElements, 
      this.empty,});

  FavoriteResponses.fromJson(dynamic json) {
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
    pageable = json['pageable'] != null ? Pageable.fromJson(json['pageable']) : null;
    first = json['first'];
    last = json['last'];
    size = json['size'];
    if (json['content'] != null) {
      content = [];
      json['content'].forEach((v) {
        content?.add(Content.fromJson(v));
      });
    }
    number = json['number'];
    sort = json['sort'] != null ? Sort.fromJson(json['sort']) : null;
    numberOfElements = json['numberOfElements'];
    empty = json['empty'];
  }
  num? totalElements;
  num? totalPages;
  Pageable? pageable;
  bool? first;
  bool? last;
  num? size;
  List<Content>? content;
  num? number;
  Sort? sort;
  num? numberOfElements;
  bool? empty;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalElements'] = totalElements;
    map['totalPages'] = totalPages;
    if (pageable != null) {
      map['pageable'] = pageable?.toJson();
    }
    map['first'] = first;
    map['last'] = last;
    map['size'] = size;
    if (content != null) {
      map['content'] = content?.map((v) => v.toJson()).toList();
    }
    map['number'] = number;
    if (sort != null) {
      map['sort'] = sort?.toJson();
    }
    map['numberOfElements'] = numberOfElements;
    map['empty'] = empty;
    return map;
  }

}

/// unsorted : true
/// sorted : true
/// empty : true

class Sort {
  Sort({
      this.unsorted, 
      this.sorted, 
      this.empty,});

  Sort.fromJson(dynamic json) {
    unsorted = json['unsorted'];
    sorted = json['sorted'];
    empty = json['empty'];
  }
  bool? unsorted;
  bool? sorted;
  bool? empty;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unsorted'] = unsorted;
    map['sorted'] = sorted;
    map['empty'] = empty;
    return map;
  }

}

/// id : "3fa85f64-5717-4562-b3fc-2c963f66afa6"
/// userId : "3fa85f64-5717-4562-b3fc-2c963f66afa6"
/// userName : "string"
/// userPhone : "string"
/// userVerified : true
/// categoryId : "3fa85f64-5717-4562-b3fc-2c963f66afa6"
/// categoryName : "string"
/// title : "string"
/// slug : "string"
/// seoTitle : "string"
/// seoDescription : "string"
/// seoKeywords : "string"
/// description : "string"
/// price : 0
/// currency : {"id":"3fa85f64-5717-4562-b3fc-2c963f66afa6","code":"string","name":"string","symbol":"string"}
/// listingType : "SALE"
/// condition : "NEW"
/// status : "PENDING"
/// latitude : 0.1
/// longitude : 0.1
/// city : {"id":"3fa85f64-5717-4562-b3fc-2c963f66afa6","name":"string","country":"string","countryCode":"string","region":"string","isActive":true,"createdAt":"2026-07-14T11:52:21.150Z","updatedAt":"2026-07-14T11:52:21.152Z"}
/// createdAt : "2026-07-14T11:52:21.152Z"
/// updatedAt : "2026-07-14T11:52:21.152Z"
/// expiryDate : "2026-07-14T11:52:21.152Z"
/// expired : true
/// attributes : [{"attributeId":"3fa85f64-5717-4562-b3fc-2c963f66afa6","attributeName":"string","attributeType":"string","valueString":"string","valueNumber":0,"iconUrl":"string","valueBoolean":true,"unit":"string"}]
/// imageUrls : ["string"]
/// isFeatured : true
/// featuredStartDate : "2026-07-14T11:52:21.152Z"
/// featuredEndDate : "2026-07-14T11:52:21.152Z"
/// featuredDurationWeeks : 1073741824
/// viewCount : 9007199254740991
/// leadCount : 9007199254740991
/// soldByLavent : true
/// soldAt : "2026-07-14T11:52:21.152Z"
/// serviceEnabled : true
/// bookingEnabled : true
/// hourlyRate : 0
/// workerRate : 0
/// minimumPrice : 0
/// favorite : true

class Content {
  Content({
      this.id, 
      this.userId, 
      this.userName, 
      this.userPhone, 
      this.userVerified, 
      this.categoryId, 
      this.categoryName, 
      this.title, 
      this.slug, 
      this.seoTitle, 
      this.seoDescription, 
      this.seoKeywords, 
      this.description, 
      this.price, 
      this.currency, 
      this.listingType, 
      this.condition, 
      this.status, 
      this.latitude, 
      this.longitude, 
      this.city, 
      this.createdAt, 
      this.updatedAt, 
      this.expiryDate, 
      this.expired, 
      this.attributes, 
      this.imageUrls, 
      this.isFeatured, 
      this.featuredStartDate, 
      this.featuredEndDate, 
      this.featuredDurationWeeks, 
      this.viewCount, 
      this.leadCount, 
      this.soldByLavent, 
      this.soldAt, 
      this.serviceEnabled, 
      this.bookingEnabled, 
      this.hourlyRate, 
      this.workerRate, 
      this.minimumPrice, 
      this.favorite,});

  Content.fromJson(dynamic json) {
    id = json['id'];
    userId = json['userId'];
    userName = json['userName'];
    userPhone = json['userPhone'];
    userVerified = json['userVerified'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    title = json['title'];
    slug = json['slug'];
    seoTitle = json['seoTitle'];
    seoDescription = json['seoDescription'];
    seoKeywords = json['seoKeywords'];
    description = json['description'];
    price = json['price'];
    currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;
    listingType = json['listingType'];
    condition = json['condition'];
    status = json['status'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    expiryDate = json['expiryDate'];
    expired = json['expired'];
    if (json['attributes'] != null) {
      attributes = [];
      json['attributes'].forEach((v) {
        attributes?.add(Attributes.fromJson(v));
      });
    }
    imageUrls = json['imageUrls'] != null ? json['imageUrls'].cast<String>() : [];
    isFeatured = json['isFeatured'];
    featuredStartDate = json['featuredStartDate'];
    featuredEndDate = json['featuredEndDate'];
    featuredDurationWeeks = json['featuredDurationWeeks'];
    viewCount = json['viewCount'];
    leadCount = json['leadCount'];
    soldByLavent = json['soldByLavent'];
    soldAt = json['soldAt'];
    serviceEnabled = json['serviceEnabled'];
    bookingEnabled = json['bookingEnabled'];
    hourlyRate = json['hourlyRate'];
    workerRate = json['workerRate'];
    minimumPrice = json['minimumPrice'];
    favorite = json['favorite'];
  }
  String? id;
  String? userId;
  String? userName;
  String? userPhone;
  bool? userVerified;
  String? categoryId;
  String? categoryName;
  String? title;
  String? slug;
  String? seoTitle;
  String? seoDescription;
  String? seoKeywords;
  String? description;
  num? price;
  Currency? currency;
  String? listingType;
  String? condition;
  String? status;
  num? latitude;
  num? longitude;
  City? city;
  String? createdAt;
  String? updatedAt;
  String? expiryDate;
  bool? expired;
  List<Attributes>? attributes;
  List<String>? imageUrls;
  bool? isFeatured;
  String? featuredStartDate;
  String? featuredEndDate;
  num? featuredDurationWeeks;
  num? viewCount;
  num? leadCount;
  bool? soldByLavent;
  String? soldAt;
  bool? serviceEnabled;
  bool? bookingEnabled;
  num? hourlyRate;
  num? workerRate;
  num? minimumPrice;
  bool? favorite;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userId'] = userId;
    map['userName'] = userName;
    map['userPhone'] = userPhone;
    map['userVerified'] = userVerified;
    map['categoryId'] = categoryId;
    map['categoryName'] = categoryName;
    map['title'] = title;
    map['slug'] = slug;
    map['seoTitle'] = seoTitle;
    map['seoDescription'] = seoDescription;
    map['seoKeywords'] = seoKeywords;
    map['description'] = description;
    map['price'] = price;
    if (currency != null) {
      map['currency'] = currency?.toJson();
    }
    map['listingType'] = listingType;
    map['condition'] = condition;
    map['status'] = status;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    if (city != null) {
      map['city'] = city?.toJson();
    }
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['expiryDate'] = expiryDate;
    map['expired'] = expired;
    if (attributes != null) {
      map['attributes'] = attributes?.map((v) => v.toJson()).toList();
    }
    map['imageUrls'] = imageUrls;
    map['isFeatured'] = isFeatured;
    map['featuredStartDate'] = featuredStartDate;
    map['featuredEndDate'] = featuredEndDate;
    map['featuredDurationWeeks'] = featuredDurationWeeks;
    map['viewCount'] = viewCount;
    map['leadCount'] = leadCount;
    map['soldByLavent'] = soldByLavent;
    map['soldAt'] = soldAt;
    map['serviceEnabled'] = serviceEnabled;
    map['bookingEnabled'] = bookingEnabled;
    map['hourlyRate'] = hourlyRate;
    map['workerRate'] = workerRate;
    map['minimumPrice'] = minimumPrice;
    map['favorite'] = favorite;
    return map;
  }

}

/// attributeId : "3fa85f64-5717-4562-b3fc-2c963f66afa6"
/// attributeName : "string"
/// attributeType : "string"
/// valueString : "string"
/// valueNumber : 0
/// iconUrl : "string"
/// valueBoolean : true
/// unit : "string"

class Attributes {
  Attributes({
      this.attributeId, 
      this.attributeName, 
      this.attributeType, 
      this.valueString, 
      this.valueNumber, 
      this.iconUrl, 
      this.valueBoolean, 
      this.unit,});

  Attributes.fromJson(dynamic json) {
    attributeId = json['attributeId'];
    attributeName = json['attributeName'];
    attributeType = json['attributeType'];
    valueString = json['valueString'];
    valueNumber = json['valueNumber'];
    iconUrl = json['iconUrl'];
    valueBoolean = json['valueBoolean'];
    unit = json['unit'];
  }
  String? attributeId;
  String? attributeName;
  String? attributeType;
  String? valueString;
  num? valueNumber;
  String? iconUrl;
  bool? valueBoolean;
  String? unit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['attributeId'] = attributeId;
    map['attributeName'] = attributeName;
    map['attributeType'] = attributeType;
    map['valueString'] = valueString;
    map['valueNumber'] = valueNumber;
    map['iconUrl'] = iconUrl;
    map['valueBoolean'] = valueBoolean;
    map['unit'] = unit;
    return map;
  }

}

/// id : "3fa85f64-5717-4562-b3fc-2c963f66afa6"
/// name : "string"
/// country : "string"
/// countryCode : "string"
/// region : "string"
/// isActive : true
/// createdAt : "2026-07-14T11:52:21.150Z"
/// updatedAt : "2026-07-14T11:52:21.152Z"

class City {
  City({
      this.id, 
      this.name, 
      this.country, 
      this.countryCode, 
      this.region, 
      this.isActive, 
      this.createdAt, 
      this.updatedAt,});

  City.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    countryCode = json['countryCode'];
    region = json['region'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? name;
  String? country;
  String? countryCode;
  String? region;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['country'] = country;
    map['countryCode'] = countryCode;
    map['region'] = region;
    map['isActive'] = isActive;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

}

/// id : "3fa85f64-5717-4562-b3fc-2c963f66afa6"
/// code : "string"
/// name : "string"
/// symbol : "string"

class Currency {
  Currency({
      this.id, 
      this.code, 
      this.name, 
      this.symbol,});

  Currency.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    symbol = json['symbol'];
  }
  String? id;
  String? code;
  String? name;
  String? symbol;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['code'] = code;
    map['name'] = name;
    map['symbol'] = symbol;
    return map;
  }

}

/// unpaged : true
/// paged : true
/// pageNumber : 1073741824
/// pageSize : 1073741824
/// offset : 9007199254740991
/// sort : {"unsorted":true,"sorted":true,"empty":true}

class Pageable {
  Pageable({
      this.unpaged, 
      this.paged, 
      this.pageNumber, 
      this.pageSize, 
      this.offset, 
      this.sort,});

  Pageable.fromJson(dynamic json) {
    unpaged = json['unpaged'];
    paged = json['paged'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    offset = json['offset'];
    sort = json['sort'] != null ? Sort.fromJson(json['sort']) : null;
  }
  bool? unpaged;
  bool? paged;
  num? pageNumber;
  num? pageSize;
  num? offset;
  Sort? sort;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unpaged'] = unpaged;
    map['paged'] = paged;
    map['pageNumber'] = pageNumber;
    map['pageSize'] = pageSize;
    map['offset'] = offset;
    if (sort != null) {
      map['sort'] = sort?.toJson();
    }
    return map;
  }

}

class CarModel {
  String modelName;
  String engineDisplacement;
  String maxPower;
  String maxTorque;
  String zeroToHundred;
  String seatingCapacity;
  String numberPlate;
  String fuelTankCapacity;
  String groundClearance;
  String gearbox;
  String overview;
  List<String> favourites = [];
  String pricePerDay;
  String mainImage;
  List<String> additionalImages;
  String companyName;
  String category;
  String fuelType;
  String transmissionType;

  CarModel({
    required this.modelName,
    required this.engineDisplacement,
    required this.maxPower,
    required this.maxTorque,
    required this.zeroToHundred,
    required this.seatingCapacity,
    required this.numberPlate,
    required this.fuelTankCapacity,
    required this.groundClearance,
    required this.gearbox,
    required this.overview,
    required this.pricePerDay,
    required this.mainImage,
    required this.additionalImages,
    required this.companyName,
    required this.category,
    required this.fuelType,
    required this.transmissionType,
  });

  Map<String, dynamic> toMap() {
    return {
      'modelName': modelName,
      'engineDisplacement': engineDisplacement,
      'maxPower': maxPower,
      'maxTorque': maxTorque,
      'zeroToHundred': zeroToHundred,
      'seatingCapacity': seatingCapacity,
      'numberPlate': numberPlate,
      'favourites': favourites,
      'fuelTankCapacity': fuelTankCapacity,
      'groundClearance': groundClearance,
      'gearbox': gearbox,
      'overview': overview,
      'pricePerDay': pricePerDay,
      'mainImage': mainImage,
      'additionalImages': additionalImages,
      'companyName': companyName,
      'category': category,
      'fuelType': fuelType,
      'transmissionType': transmissionType,
    };
  }
}

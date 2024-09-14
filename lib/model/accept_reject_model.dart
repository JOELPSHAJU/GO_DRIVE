class BookingAcceptRejectModel {
  String companyName;
  String modelName;
  String numberplate;
  String pickupdate;
  String dropoffdate;
  String image;
  String fullName;
  String status;
  String profilePicture;
  String emailAddress;
  String phoneNumber;
  String price;

  BookingAcceptRejectModel(
      {required this.companyName,
      required this.modelName,
      required this.dropoffdate,
      required this.emailAddress,
      required this.fullName,
      required this.profilePicture,
      required this.status,
      required this.numberplate,
      required this.phoneNumber,
      required this.pickupdate,
      required this.price,
      required this.image});
  Map<String, dynamic> toMap() {
    return {
      'dropOffDate': dropoffdate,
      'emailAddress': emailAddress,
      'phoneNumber': phoneNumber,
      'fullName': fullName,
      'profilePicture': profilePicture,
      'pickUpDate': pickupdate,
      'price': price,
      'status': status,
      'image': image,
      'numberPlate': numberplate,
      'companyName': companyName,
      'modelName': modelName,
    };
  }
}

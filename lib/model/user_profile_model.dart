class ProfileModel {
   String fullName;
   String phoneNumber;
   String address;
   String pincode;
   String profilePicture;
   String coverPicture;

  ProfileModel(
      {required this.fullName,
      required this.phoneNumber,
      required this.profilePicture,
      required this.coverPicture,
      required this.address,
      required this.pincode});

  Map<String,dynamic> toMap(){
    return{
      'fullName':fullName,
      'phoneNumber':phoneNumber,
      'address':address,
      'pincode':pincode,
      'profilePicture':profilePicture,
      'coverPicture':coverPicture

    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      fullName: map['fullName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
      pincode: map['pincode'] ?? '',
      profilePicture: map['profilePicture'] ?? '',
      coverPicture: map['coverPicture'] ?? '',
    );
  }
}

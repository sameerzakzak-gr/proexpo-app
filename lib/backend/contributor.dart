import 'package:proexpo/backend/product.dart';

class Contributor {


  String contributorName;
  String contributorDomain;
  String contributorImage;
  String contributorRate;
  String contributorNumberOfRatings;
  String contributorHall;
  String contributorNumberOfEmployees;
  String ceoName;
  String ceoImage;
  String contributorAbout;
  String contributorLocation;
  String contributorPhoneNumber;
  String contributorWebsite;
  String contributorEmail;
  String contributorFacebook;
  List<Product> contributorProducts= [];
  String contributorExhibition;
  String serviceNumOfRatings;
  String serviceSumRating;


  //exhibitor constructor
  Contributor({this.contributorName,this.contributorDomain,this.contributorImage,this.contributorRate,this.contributorNumberOfRatings,this.contributorHall,this.contributorNumberOfEmployees,this.ceoName,this.ceoImage,this.contributorAbout,this.contributorLocation,this.contributorPhoneNumber,this.contributorEmail,this.contributorWebsite,this.contributorFacebook,this.contributorProducts,this.contributorExhibition});

  // void chooseLocationOnMap(){
  //
  // }
  // //exhibitor adding a product to a list
  // void addProduct(Product product) {
  //   _products.add(product);
  //   //TODO: add to Firebase FireStore
  // }


}



class Service{

  String serviceName;
  String serviceType;
  String serviceImage;
  String servicePhoneNumber;
  String serviceWebsite;
  String serviceEmail;
  String serviceFacebook;
  String serviceExhibition;
  String serviceProviderName;
  String serviceRate;
  String serviceNumOfRatings;
  String serviceSumRating;


  //constructor
  Service({this.serviceNumOfRatings,this.serviceRate,this.serviceName,this.serviceType,this.serviceImage,this.servicePhoneNumber,this.serviceWebsite,this.serviceEmail,this.serviceFacebook,this.serviceExhibition,this.serviceProviderName, this.serviceSumRating});

  Map<String, dynamic> toMap() {
    return {
      'servicename': serviceName,
      'servicetype': serviceType,
      'serviceimage': serviceImage,
      'serviceproviderphonenumber': servicePhoneNumber,
      'serviceproviderwebsite': serviceWebsite,
      'serviceprovideremail': serviceEmail,
      'serviceproviderfacebook': serviceFacebook,
      'serviceexhibition': serviceExhibition,
      'serviceprovidername': serviceProviderName,
      'servicerate': serviceRate,
      'servicenumberofratings': serviceNumOfRatings,
      'servicesumrating' : serviceSumRating,
    };
  }


  }

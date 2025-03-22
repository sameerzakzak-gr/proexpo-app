class Product{

  String productName;
  String productCategory;
  String productImage;
  String productPrice;
  double productRate;
  int productNumberOfRatings;
  String productExhibitorName;
  String productExhibitorImage;
  String productHall;
  String productQuantity;
  String productAbout;
  String productExhibition;
  String productExhibitorEmail;
  String serviceNumOfRatings;
  String serviceSumRating;

  //constructor
  Product({this.productName,this.productCategory,this.productImage,this.productPrice,this.productRate,this.productNumberOfRatings,this.productExhibitorName,this.productExhibitorImage,this.productHall,
    this.productQuantity,this.productAbout,this.productExhibition, this.productExhibitorEmail});
  Map<String, dynamic> toMap() {
    return {
      'productname': productName,
      'productcategory': productCategory,
      'productimage': productImage,
      'productprice': productPrice,
      'productrate': productRate,
      'productnumberofratings': productNumberOfRatings,
      'productcontributorname': productExhibitorName,
      'productcontributorImage': productExhibitorImage,
      'producthall': productHall,
      'productquantity': productQuantity,
      'productabout': productAbout,
      'productexhibition': productExhibition,
      'productexhibitoremail': productExhibitorEmail,
    };
  }

// checks if the order is possible
// bool acceptOrder(User client, int desiredQuantity){
//   if(this.quantityLeft> desiredQuantity){
//     _quantityLeft-= desiredQuantity;
//     orders.add(new Order(this, client, desiredQuantity));
//     return true;
//   }
//   return false;
// }
//
// //deletes a pending order
// deleteOrder(Order order){
//   _quantityLeft += order.desiredQuantity;
//   orders.remove(order);
// }

}
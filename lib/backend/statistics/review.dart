// class Review{
//   List<int> reviewCounters = [0,0,0,0,0,0,0,0,0,0];
//
//   Review(this.reviewCounters);
//
//   // accepts a new rating and adds it to the counters list
//   acceptRating(double rating){
//     reviewCounters[(rating*2).toInt() -1 ]++;
//     // calcRating();
//   }
//
//   // calculates the total rating
//   double calcRating(){
//     double coefficient = 0.5;
//     double sum=0;
//     double totalReviews=0;
//     for(int i = 0; i< reviewCounters.length; i++){
//       sum += reviewCounters[i] * coefficient;
//       totalReviews += reviewCounters[i];
//       coefficient += 0.5;
//     }
//     return sum/totalReviews;
//   }
//
//   int calcReviews(){
//     int sum = 0;
//     for(int i=0;i<reviewCounters.length; i++){
//       sum += reviewCounters[i];
//     }
//     return sum;
//   }
//
// }
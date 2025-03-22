class Expo {
  String name;
  String description;
  DateTime expoDate;
  String image;
  String image1;
  String location;
  String organizer;
  num price;

  Expo(
      {this.expoDate,
      this.image,
      this.image1,
      this.location,
      this.name,
      this.organizer,
      this.price,
      this.description});
}

// dataList.add(Expo(
// Colors.white,
// 'Damascus International Expo',
// 'This Expo is the most Important of all expos held in Syria especially damascus. ',
// '22',
// 'Sep',
// '2021',
// 'Damascus FairGround',
// 'assets/images/expo.png'));
//
// dataList.add(Expo(
// Colors.white,
// 'LIFE STYLE',
// 'This Expo is the most Important of all expos held in Syria especially damascus. ',
// '24',
// 'Jun',
// '2021',
// 'Damascus FairGround',
// 'assets/images/lsty.png'));
// dataList.add(Expo(
// Colors.white,
// 'BuildEx Expo',
// 'This Expo is the most Important of all expos held in Syria especially damascus. ',
// '24',
// 'Jun',
// '2021',
// 'Damascus FairGround',
// 'assets/images/buiex.png'));
// dataList.add(Expo(
// Colors.white,
// 'HVACW Expo',
// 'This Expo is the most Important of all expos held in Syria especially damascus. ',
// '24',
// 'Jun',
// '2021',
// 'Damascus FairGround',
// 'assets/images/hvac.png'));
// dataList.add(Expo(
// Colors.white,
// 'Syria HiTech Expo',
// 'This Expo is the most Important of all expos held in Syria especially damascus. ',
// '24',
// 'Jun',
// '2021',
// 'Damascus FairGround',
// 'assets/images/htech.png'));
// dataList.add(Expo(
// Colors.white,
// 'Health Care Expo',
// 'This Expo is the most Important of all expos held in Syria especially damascus. ',
// '15',
// 'Sep',
// '2021',
// 'Sheraton Hotel Aleppo',
// 'assets/images/hcare.png'));
// dataList.add(Expo(
// Colors.white,
// 'Dental Care Expo',
// 'This Expo is the most Important of all expos held in Syria especially damascus. ',
// '18',
// 'Oct',
// '2021',
// 'Sheraton Hotel Aleppo',
// 'assets/images/dcare.png'));
// dataList.add(Expo(
// Colors.white,
// 'Syria Lab Expo',
// 'This Expo is the most Important of all expos held in Syria especially damascus. ',
// '25',
// 'Oct',
// '2021',
// 'Sheraton Hotel Aleppo',
// 'assets/images/slab.png'));
final List<Expo> upcomingEvents = [
  Expo(
      name: "Damascus International Expo",
      expoDate: DateTime.now().add(const Duration(days: 24)),
      image: 'assets/images/expo.png',
      description:
          "This Expo is the most Important of all expos held in Syria especially damascus.",
      location: "Damascus FairGround",
      organizer: "Al-Arabya Group",
      price: 30,
      image1: 'assets/images/map-s.jpg'),
  Expo(
      name: "LIFE STYLE",
      expoDate: DateTime.now().add(const Duration(days: 33)),
      image: 'assets/images/lsty.png',
      description:
          "The pretty reckless is an American rock band from New york city, Formed in 2009. The",
      location: "Damascus FairGround",
      organizer: "Al-Arabya Group",
      price: 30,
      image1: 'assets/images/map-s.jpg'),
  Expo(
      name: "BuildEx Expo",
      expoDate: DateTime.now().add(const Duration(days: 12)),
      image: 'assets/images/buiex.png',
      description:
          "The pretty reckless is an American rock band from New york city, Formed in 2009. The",
      location: "Damascus FairGround",
      organizer: "Al-Arabya Group",
      price: 30,
      image1: 'assets/images/map-s.jpg'),
  Expo(
      name: "HVACW Expo",
      expoDate: DateTime.now().add(const Duration(days: 24)),
      image: 'assets/images/hvac.png',
      description:
          "This Expo is the most Important of all expos held in Syria especially damascus.",
      location: "Damascus FairGround",
      organizer: "Al-Arabya Group",
      price: 30,
      image1: 'assets/images/map-s.jpg'),
  Expo(
      name: "Syria HiTech Expo",
      expoDate: DateTime.now().add(const Duration(days: 24)),
      image: 'assets/images/htech.png',
      description:
          "This Expo is the most Important of all expos held in Syria especially damascus.",
      location: "Damascus FairGround",
      organizer: "Al-Arabya Group",
      price: 30,
      image1: 'assets/images/map-s.jpg'),
  Expo(
      name: "Health Care Expo",
      expoDate: DateTime.now().add(const Duration(days: 24)),
      image: 'assets/images/hcare.png',
      description:
          "This Expo is the most Important of all expos held in Syria especially damascus.",
      location: "Sheraton Hotel Aleppo",
      organizer: "Al-Arabya Group",
      price: 30,
      image1: 'assets/images/map-h.png'),
  Expo(
      name: "Dental Care Expo",
      expoDate: DateTime.now().add(const Duration(days: 24)),
      image: 'assets/images/dcare.png',
      description:
          "This Expo is the most Important of all expos held in Syria especially damascus.",
      location: "Sheraton Hotel Aleppo",
      organizer: "Al-Arabya Group",
      price: 30,
      image1: 'assets/images/map-h.png'),
  Expo(
      name: "Syria Lab Expo",
      expoDate: DateTime.now().add(const Duration(days: 24)),
      image: 'assets/images/slab.png',
      description:
          "This Expo is the most Important of all expos held in Syria especially damascus.",
      location: "Sheraton Hotel Aleppo",
      organizer: "Al-Arabya Group",
      price: 30,
      image1: 'assets/images/map-h.png'),
];

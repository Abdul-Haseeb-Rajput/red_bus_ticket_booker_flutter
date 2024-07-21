class Bus {
  String id;
  String routeName;
  double price;
  List<String> routes;
  String startTime;
  String endTime;

  Bus({
    required this.id,
    required this.routeName,
    required this.price,
    required this.routes,
    required this.startTime,
    required this.endTime,
  });

  factory Bus.fromMap(Map<String, dynamic> data) {
    return Bus(
      id: data['id'],
      routeName: data['routeName'],
      price: data['price'],
      routes: List<String>.from(data['routes']),
      startTime: data['startTime'],
      endTime: data['endTime'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'routeName': routeName,
      'price': price,
      'routes': routes,
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}

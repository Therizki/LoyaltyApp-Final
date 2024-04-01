
class DashboardModel {
  String full_name;
  int loyalty_level;
  double loyalty_balance;

  DashboardModel(
      {required this.full_name,
        required this.loyalty_balance,
        required this.loyalty_level});

  @override
  String toString() {
    return 'DashboardModel { full_name: $full_name, loyalty_balance: $loyalty_balance, loyalty_level: $loyalty_level }';
  }
}
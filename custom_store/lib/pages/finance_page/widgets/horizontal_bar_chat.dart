/// Sample ordinal data type.
class OrdinalSales implements Comparable {
  final String month;
  final double sales;
  final Map monthsMap = {
    "JAN": 1,
    "FEV": 2,
    "MAR": 3,
    "ABR": 4,
    "MAI": 5,
    "JUN": 6,
    "JUL": 7,
    "AGO": 8,
    "SET": 9,
    "OUT": 10,
    "NOV": 11,
    "DEZ": 12,
  };

  OrdinalSales(this.month, this.sales);

  @override
  String toString() {
    return "${this.month} : {Value: ${this.sales}}";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrdinalSales &&
          runtimeType == other.runtimeType &&
          month == other.month;

  @override
  int get hashCode => month.hashCode;

  @override
  int compareTo(other) {
    if (this.monthsMap[this.month] == null ||
        other.monthsMap[other.month] == null) {
      return null;
    }

    if (this.monthsMap[this.month] < other.monthsMap[other.month]) {
      return -1;
    }

    if (this.monthsMap[this.month] > other.monthsMap[other.month]) {
      return 1;
    }

    if (this.monthsMap[this.month] == other.monthsMap[other.month]) {
      return 0;
    }

    return null;
  }
}

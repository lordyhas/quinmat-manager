part of 'filter_cubit.dart';


class Filter extends Equatable {
  final double maxPrice;
  final double minPrice;
  final double maxDistance;
  final double minDistance;
  final double exchangeRate;
  final List<Category> category;
  const Filter._({
      this.maxPrice = maximumPrice,
      this.minPrice = 0.0,
      this.maxDistance = 0.0,
      this.minDistance = 0.0,
      this.exchangeRate = 0.0,
      this.category = const[],
  });

  const Filter.unknown() : this._();
  const Filter.values({
    required double maxPrice,
    required double minPrice,
    required double exchangeRate,
    required double maxDistance,
    required double minDistance,
    required List<Category> categoryList,
  }) : this._(
      maxPrice: maxPrice,
      minPrice: minPrice,
      maxDistance: maxDistance,
      minDistance: minDistance,
      category: categoryList,
  );

  Filter copyWith({
    double? maxPrice,
    double? minPrice,
    double? exchangeRate,
    double? maxDistance,
    double? minDistance,
    List<Category>? category,
  }) => Filter.values(
    maxPrice: maxPrice ?? this.maxPrice,
    minPrice: minPrice ?? this.minPrice,
    exchangeRate: exchangeRate ?? this.exchangeRate,
    maxDistance: maxDistance ?? this.maxDistance,
    minDistance: minDistance ?? this.minDistance,
    categoryList: category ?? this.category,
  );


  @override
  List<Object> get props => [
    maxPrice, minPrice, maxDistance, minDistance, category
  ];
}






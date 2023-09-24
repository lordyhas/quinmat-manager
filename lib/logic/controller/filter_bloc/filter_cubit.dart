
import "package:equatable/equatable.dart";
import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qmt_manager/logic/values.dart';





part 'filter_data.dart';
part 'filter_state.dart';

class FilterCubit extends Cubit<Filter> {
  FilterCubit({Filter? filter}) : super(
    filter ?? const Filter.values(
      maxPrice: 1200.0,
      minPrice: 50,
      exchangeRate: 1/2475.60,
      maxDistance: 1.0,
      minDistance: 0.0,
      categoryList: [],
    ),
  );

  void change({
    double? maxPrice,
    double? minPrice,
    double? exchangeRate,
    double? maxDistance,
    double? minDistance,
    List<Category>? categories,
  }){
    emit(state.copyWith(
      maxPrice: maxPrice,
      minPrice: minPrice,
      maxDistance: maxDistance,
      minDistance: minDistance,
      category: categories,
    ));
  }

  /// A function that takes the amount of money in CDF and the exchange
  /// rate from CDF to USD as parameters
  /// and returns the converted amount of money in USD
  double cdfToUsd(double cdf) {
    double rate = state.exchangeRate;
    /// Print a message to show the input values
    if (kDebugMode) {
      print('Converting $cdf CDF to USD at the rate of $rate USD/CDF');
    }
    /// Calculate the converted amount by multiplying the CDF by the rate
    double usd = cdf * rate;
    /// Return the converted amount
    return usd;
  }

  /// A function that takes the amount of money in USD and the exchange
  /// rate from USD to CDF as parameters
  /// and returns the converted amount of money in CDF
  double usdToCdf(double usd) {
    double rate = state.exchangeRate;
    /// Print a message to show the input values
    if (kDebugMode) {
      print('Converting $usd USD to CDF at the rate of $rate CDF/USD');
    }
    /// Calculate the converted amount by dividing the USD by the rate
    double cdf = usd / rate;
    /// Return the converted amount
    return cdf;
  }


}

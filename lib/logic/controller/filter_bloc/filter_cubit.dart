
import "package:equatable/equatable.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qmt_manager/logic/values.dart';





part 'filter_data.dart';
part 'filter_state.dart';

class FilterCubit extends Cubit<Filter> {
  FilterCubit({Filter? filter}) : super(
    filter ?? const Filter.values(
      maxPrice: 1200.0,
      minPrice: 50,
      maxDistance: 1.0,
      minDistance: 0.0,
      categoryList: []),
  );

  void change({
    double? maxPrice,
    double? minPrice,
    double? maxDistance,
    double? minDistance,
    List<Category> categories = const<Category>[],
  }){
    emit(state.copyWith(
      maxPrice: maxPrice,
      minPrice: minPrice,
      maxDistance: maxDistance,
      minDistance: minDistance,
      category: categories,
    ));
  }


}

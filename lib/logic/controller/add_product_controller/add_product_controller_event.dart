part of 'add_product_controller_bloc.dart';

abstract class ProductControllerEvent extends Equatable {
  const ProductControllerEvent();

  @override
  List<Object> get props => [];
}


class ProductPassed extends ProductControllerEvent {
  final Product rental;

  const ProductPassed(this.rental);

  @override
  List<Object> get props => [rental];
}

class ProductImaged extends ProductControllerEvent {
  final Product rental;

  const ProductImaged(this.rental);

  @override
  List<Object> get props => [rental];
}

class ProductCompleted extends ProductControllerEvent {
  final Product rental;

  const ProductCompleted(this.rental);

  @override
  List<Object> get props => [rental];
}

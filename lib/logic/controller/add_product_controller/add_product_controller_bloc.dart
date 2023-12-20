import 'package:equatable/equatable.dart';
import 'package:qmt_manager/logic/model/data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_product_controller_event.dart';

part 'add_product_controller_state.dart';


/// goal to save the state [AddRentPage] form while editing till end send it to
/// a database
///
/// [AddProductControllerBloc] is a form state saver
class AddProductControllerBloc
    extends Bloc<ProductControllerEvent, ProductControllerState> {
  AddProductControllerBloc({Product? product}) : super(
      product == null
          ?  const ProductControllerState.initial()
          :  ProductControllerState.product(product)
  ) {
    on<ProductPassed>(_onPassed);
    on<ProductImaged>(_onImaged);
    on<ProductCompleted>(_onCompleted);
  }

  //RentalType get rentalType => state.rentalType;
  //bool get isMovable => state.isMovable;
  //bool get isImmovable => !state.isMovable;

  Product get product =>  state._product;
  //RentalSpace get space =>  state._space;


  void _onPassed(ProductPassed event,
      Emitter<ProductControllerState> emit){
    emit(ProductControllerState.product(event.product));
  }
  void addProductPassed(Product r) => add(ProductPassed(r));

  void refreshProduct(Product r) => add(ProductPassed(r));

  void _onImaged(ProductImaged event,
      Emitter<ProductControllerState> emit){
    emit(ProductControllerState.product(
        event.rental,
        status: RentalControllerStatus.addingImages
    ));
  }
  void addProductImaged(Product r) => add(ProductImaged(r));

  void _onCompleted(ProductCompleted event,
      Emitter<ProductControllerState> emit){
    emit(ProductControllerState.complete(event.rental));
  }

  void addProductCompleted(Product r) =>
      add(ProductCompleted(r));
  




}

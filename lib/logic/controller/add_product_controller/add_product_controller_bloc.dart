import 'package:equatable/equatable.dart';
import 'package:qmt_manager/logic/model/data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_product_controller_event.dart';

part 'add_product_controller_state.dart';


/// goal to save the state [AddRentPage] form while editing till end send it to
/// a database
///
/// [RentalControllerBloc] is a form state saver
class RentalControllerBloc
    extends Bloc<ProductControllerEvent, RentalControllerState> {
  RentalControllerBloc() : super(const RentalControllerState.initial()) {
    //on<SpaceRentalPassed>(_onSpaceRentalPassed);
    //on<SpaceRentalImaged>(_onSpaceRentalImaged);
    //on<SpaceRentalCompleted>(_onSpaceRentalCompleted);
    on<ProductPassed>(_onVehicleRentalPassed);
    on<ProductImaged>(_onVehicleRentalImaged);
    on<ProductCompleted>(_onVehicleRentalCompleted);
  }

  //RentalType get rentalType => state.rentalType;
  bool get isMovable => state.isMovable;
  bool get isImmovable => !state.isMovable;

  Product get vehicle =>  state._product;
  //RentalSpace get space =>  state._space;


  void _onVehicleRentalPassed(ProductPassed event,
      Emitter<RentalControllerState> emit){
    emit(RentalControllerState.product(event.rental));
  }
  void addVehicleRentalPassed(Product r) => add(ProductPassed(r));

  void _onVehicleRentalImaged(ProductImaged event,
      Emitter<RentalControllerState> emit){
    emit(RentalControllerState.product(
        event.rental,
        status: RentalControllerStatus.addingImages
    ));
  }
  void addVehicleRentalImaged(Product r) => add(ProductImaged(r));

  void _onVehicleRentalCompleted(ProductCompleted event,
      Emitter<RentalControllerState> emit){
    emit(RentalControllerState.complete(event.rental));
  }

  void addVehicleRentalCompleted(Product r) =>
      add(ProductCompleted(r));
  




}

part of 'add_product_controller_bloc.dart';

enum RentalControllerStatus{initial, addingInfo, addingImages, checkingAll}

class RentalControllerState extends Equatable {
  //final RentalSpace _space;
  final Product _product;
  final RentalControllerStatus status;
  final bool isCompleted;
  final bool _isMovable;

  const RentalControllerState._({
    //RentalSpace space =  RentalSpace.empty,
    Product product = Product.empty,
    this.status = RentalControllerStatus.initial,
    this.isCompleted = false,
    bool isMovable = false,
  }) :  _isMovable = isMovable,
        _product = product;
  const RentalControllerState.initial() : this._();

  const RentalControllerState.product(
      Product vehicleRental,{
        RentalControllerStatus status = RentalControllerStatus.addingInfo,
      }) : this._(product: vehicleRental, status: status, isMovable: true);

  const RentalControllerState.complete(rental, {
        RentalControllerStatus status = RentalControllerStatus.checkingAll,
      }) : this._(
      product: rental is Product ? rental : Product.empty,
      status: status,
      isCompleted: true,
      isMovable: rental is Product);

  bool get isMovable => _isMovable;
  bool get isImmovable => !_isMovable;

  Product get product =>  _product;

  @override
  List<Object> get props => [isCompleted];

}




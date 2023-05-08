part of 'rental_controller_bloc.dart';

enum RentalControllerStatus{initial, addingInfo, addingImages, checkingAll}

class RentalControllerState extends Equatable {
  //final RentalSpace _space;
  final Product _vehicle;
  final RentalControllerStatus status;
  final bool isCompleted;
  final bool _isMovable;

  const RentalControllerState._({
    //RentalSpace space =  RentalSpace.empty,
    Product vehicle = Product.empty,
    this.status = RentalControllerStatus.initial,
    this.isCompleted = false,
    bool isMovable = false,
  }) :  _isMovable = isMovable,
        //_space = space,
        _vehicle = vehicle;

  const RentalControllerState.initial() : this._();

  /*const RentalControllerState.space(
      RentalSpace spaceRental, {
        RentalControllerStatus status = RentalControllerStatus.addingInfo,
      }) : this._(space: spaceRental, status: status, isMovable: false);*/

  const RentalControllerState.vehicle(
      Product vehicleRental,{
        RentalControllerStatus status = RentalControllerStatus.addingInfo,
      }) : this._(vehicle: vehicleRental, status: status, isMovable: true);

  const RentalControllerState.complete(rental, {
        RentalControllerStatus status = RentalControllerStatus.checkingAll,
      }) : this._(
      //space: rental is RentalSpace ? rental : RentalSpace.empty,
      vehicle: rental is Product ? rental : Product.empty,
      status: status,
      isCompleted: true,
      isMovable: rental is Product);

  bool get isMovable => _isMovable;
  bool get isImmovable => !_isMovable;

  //Product get rental => _isMovable ? _vehicle  : _space;
  Product get vehicle =>  _vehicle;
  //RentalSpace get space =>  _space;




  /*const RentalControllerState.modify(): this._(
    isCompleted: true,
    status: RentalControllerStatus.
  );*/

  @override
  List<Object> get props => [isCompleted];

  //RentalType get rentalType => rental.rentalType;
}




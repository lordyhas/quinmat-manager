part of 'add_product_controller_bloc.dart';

enum RentalControllerStatus{initial, addingInfo, addingImages, checkingAll}

class ProductControllerState extends Equatable {
  //final RentalSpace _space;
  final Product _product;
  final RentalControllerStatus status;
  final bool isCompleted;


  const ProductControllerState._({
    Product product = Product.empty,
    this.status = RentalControllerStatus.initial,
    this.isCompleted = false,
  }) :
        _product = product;
  const ProductControllerState.initial() : this._();

  const ProductControllerState.product(
      Product product,{
        RentalControllerStatus status = RentalControllerStatus.addingInfo,
      }) : this._(product: product, status: status);

  const ProductControllerState.complete(rental, {
        RentalControllerStatus status = RentalControllerStatus.checkingAll,
      }) : this._(
      product: rental is Product ? rental : Product.empty,
      status: status,
      isCompleted: true,
  );



  Product get product =>  _product;

  @override
  List<Object> get props => [isCompleted];

}




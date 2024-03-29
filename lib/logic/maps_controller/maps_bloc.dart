part of data.maps;

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  MapsBloc() : super(MapsState.unknown()) {
    on<MapsDataLoad>(_updateToCart);
  }


  void _updateToCart(MapsDataLoad event, Emitter<MapsState> emit) {
    emit(MapsState.loaded(event.location));
  }

  void load({required GPS position}) =>
      add(MapsDataLoad(MapsData(currentPosition: position,)));



}

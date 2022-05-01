import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/model/model.dart';

// CLASE ASLIE BLOC
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  List<Product> cardProducts = [];

  ProductBloc() : super(LoadingProductState()) {
    on<AddProduct>(
      (event, emit) {
        cardProducts.add(event.prd);
        emit(SuccessProductState(count: cardProducts.length));
        print('MAN injammmmmmmMM!!!');
      },
    );
  }

// void _handleEventA(AddProduct event, Emitter<ProductState> emit) {
//   cardProducts.add(event.prd);
//   print(cardProducts.length);
//   // emit(SuccessProductState(count: cardProducts.length));
//   emit(ErrorProductState(error: Error));
// }

// @override
// Stream<ProductState> mapEventToState(ProductEvent event) async* {
//   yield LoadingProductState();
//   // try {
//     if (event is AddProduct) {
//       cardProducts.add(event.prd);
//       // print(event.prd.name);
//     } else if (event is RemoveProduct) {
//       cardProducts.remove(event.prd);
//     } else if (event is ClearProduct) {
//       cardProducts.clear();
//     }
//     yield SuccessProductState(count: cardProducts.length);
//   // } catch (e) {
//   //   yield ErrorProductState(error: e);
//   //   if (kDebugMode) {
//   //     print(e);
//   //   }
//   // }
// }
}

// BLOC STATE CLASSES
abstract class ProductState {}

class LoadingProductState extends ProductState {}

class SuccessProductState extends ProductState {
  int? count;

  SuccessProductState({this.count});
}

class ErrorProductState extends ProductState {
  Object? error;

  ErrorProductState({this.error});
}

// BLOC EVENT CLASSES
abstract class ProductEvent {}

class ClearProduct extends ProductEvent {
  ClearProduct();
}

class AddProduct extends ProductEvent {
  Product prd;

  AddProduct({required this.prd});
}

class RemoveProduct extends ProductEvent {
  Product prd;

  RemoveProduct(this.prd);
}

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/datasources/product_remote_datasource.dart';
import '../../data/models/add_product_response_model.dart';
import '../../data/models/request/product_request_model.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';
part 'add_product_bloc.freezed.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  AddProductBloc() : super(const _Initial()) {
    on<_Create>((event, emit) async {
      emit(const _Loading());
      final response =
          await ProductRemoteDatasource().addProduct(event.request);
      response.fold(
        (l) => emit(const _Error()),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}


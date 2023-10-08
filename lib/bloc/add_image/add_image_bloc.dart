import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/datasources/product_remote_datasource.dart';
import '../../data/models/image_response_model.dart';

part 'add_image_event.dart';
part 'add_image_state.dart';
part 'add_image_bloc.freezed.dart';

class AddImageBloc extends Bloc<AddImageEvent, AddImageState> {
  AddImageBloc() : super(const _Initial()) {
    on<_AddImage>((event, emit) async {
      emit(const _Loading());
      final response = await ProductRemoteDatasource().addImage(event.image);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}


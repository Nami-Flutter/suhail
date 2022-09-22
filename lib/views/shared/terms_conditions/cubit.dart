import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soheel_app/core/dio_manager/dio_manager.dart';
import 'package:soheel_app/views/shared/terms_conditions/model.dart';

part 'states.dart';

class TermsCubit extends Cubit<TermsStates> {
  TermsCubit() : super(TermsInit());

  static TermsCubit of(context) => BlocProvider.of(context);

  TermsModel? termsModel;

  Future<void> getTerms({required int id}) async {
    emit(TermsLoading());
    final response = await DioHelper.post(
      'information',
      data: {
        'information_id': id,
      },
    );
    termsModel = TermsModel.fromJson(response.data);
    emit(TermsInit());
  }
}

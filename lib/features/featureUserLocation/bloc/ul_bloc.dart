import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wdywtg/features/featureUserLocation/bloc/ul_event.dart';
import 'package:wdywtg/features/featureUserLocation/bloc/ul_state.dart';

class UserLocationBloc extends Bloc<UserLocationEvent, UserLocationState>{

  UserLocationBloc(): super(UserLocationState.empty());

}
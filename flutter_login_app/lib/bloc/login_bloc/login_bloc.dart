import 'package:bloc/bloc.dart';
import 'package:provider/provider.dart';
import '../../provider/login_data_provider.dart';
import 'login_event.dart';
import 'login_state.dart';

String validation(GetLogin data) {
  if (data.email?.isEmpty == true) {
    return 'Please Enter Your Email';
  }
  if (data.password?.isEmpty == true) {
    return 'Please Enter Your Password';
  }
  else {
    return '';
  }
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<GetLogin>((event, emit) async {
      String value = validation(event);
      if (value != '') {
        emit(LoginValidation(value.toString()));
      } else {
        emit(LoginLoaded());
        // Notify listeners of email and password changes
        Provider.of<LoginDataProvider>(event.context, listen: false)
            .updateLoginData(event.email, event.password, event.country);

      }
    });
  }
}

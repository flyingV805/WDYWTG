import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wdywtg/features/featureMain/bloc/main_bloc.dart';

class SearchField extends StatelessWidget {

  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    /*final displayError = context.select(
          (LoginBloc bloc) => bloc.state.username.displayError,
    );*/

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        key: const Key('loginForm_usernameInput_textField'),
        onChanged: (username) {
          //context.read<MainBloc>().add(LoginUsernameChanged(username));
        },
        decoration: InputDecoration(
          labelText: 'username',
          errorText: null,
        ),
      ),
    );
  }

}
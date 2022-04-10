import 'package:api_cubit/cubit/authentication_cubit.dart';
import 'package:api_cubit/view/screen/page_vew.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        switch (state.status) {
          case AuthStatus.unauthenticated:
            return Scaffold(
              body: Center(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          color: Colors.blueAccent,
                          child: ElevatedButton(
                              onPressed: () async {
                                await BlocProvider.of<AuthenticationCubit>(
                                        context)
                                    .facebokSignIn();
                              },
                              child: const Text(
                                'Facebook',
                                style: TextStyle(color: Colors.white),
                              ))),
                      Container(
                          color: Colors.redAccent,
                          child: ElevatedButton(
                              onPressed: () async {
                                await BlocProvider.of<AuthenticationCubit>(
                                        context)
                                    .googleSignIn();
                              },
                              child: const Text(
                                'Google',
                                style: TextStyle(color: Colors.white),
                              )))
                    ],
                  ),
                ),
              ),
            );

          case AuthStatus.authenticated:
            {
              return WeatherPageView(index: 0);
            }
          case AuthStatus.loading:
            return Material(child: Center(child: CircularProgressIndicator()));

          default:
            return const Material(
              child: Center(
                child: Text('something went wrong'),
              ),
            );
        }
      },
    );
  }
}

import 'package:api_cubit/data/data_provider/database/user_table.dart';
import 'package:api_cubit/data/model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit()
      : super(const AuthenticationState(status: AuthStatus.loading)) {
    _googleSignIn = GoogleSignIn();
    checkTheCurrentUser();
  }
  late GoogleSignIn _googleSignIn;

  void checkTheCurrentUser() async {
    int? records = await UserDBTable().fetchTotalUserRecordsLength();
    if (records! > 0) {
      User? user = await UserDBTable().getCurrentSignedUser();
      if (user != null) {
        emit(state.copyWith(status: AuthStatus.authenticated, user: user));
      } else {
        emit(state.copyWith(status: AuthStatus.unauthenticated, user: user));
      }
    } else {
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
      ));
    }

    // bool isSigned = await _googleSignIn.isSignedIn();
    // if (isSigned) {
    //   final result = await _googleSignIn.signInSilently();
    //   emit(state.copyWith(
    //       status: AuthStatus.authenticated,
    //       logedInPlatform: 'google',
    //       user: convertUserAccountToUser(result!)));
    // }
    // bool? _isLogged = await FacebookAuth.instance.accessToken != null;
    // if (_isLogged) {
    //   final requestData = await FacebookAuth.instance.getUserData(
    //     fields: "name,email,picture.width(200),id",
    //   );
    //   emit(state.copyWith(
    //       status: AuthStatus.authenticated,
    //       logedInPlatform: 'facebook',
    //       user: convertFacebookAccountToUser(requestData)));
    // }
    // if (!isSigned && !_isLogged) {
    //   emit(state.copyWith(
    //     status: AuthStatus.unauthenticated,
    //   ));
    // }
  }

  Future<void> googleSignIn() async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      final result = await _googleSignIn.signIn();
      if (result != null) {
        emit(state.copyWith(
            status: AuthStatus.authenticated,
            logedInPlatform: 'google',
            user: convertUserAccountToUser(result)));
        await UserDBTable().addSignedInUser(convertUserAccountToUser(result));
      } else {
        emit(state.copyWith(status: AuthStatus.unknown));
      }
    } catch (error) {
      emit(state.copyWith(status: AuthStatus.unknown));
    }
  }

  Future facebokSignIn() async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['public_profile', 'email'],
      );
      if (result.status == LoginStatus.success) {
        // final AccessToken accessToken = result.accessToken!;
        Map<String, dynamic> requestData = await FacebookAuth.i
            .getUserData(fields: "name,email,picture.width(200),id");
        await UserDBTable()
            .addSignedInUser(convertFacebookAccountToUser(requestData));
        emit(state.copyWith(
            status: AuthStatus.authenticated,
            user: convertFacebookAccountToUser(requestData)));
      } else {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      }
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }

  Future signOut() async {
    String? ol = state.user!.logedInPlatform;
    print(ol);
    try {
      if (state.user!.logedInPlatform == "facebook") {
        await FacebookAuth.instance.logOut();
        await UserDBTable().deleteCurrentSignedUser(state.user!.email!);
      }
      if (state.user!.logedInPlatform == "google") {
        await _googleSignIn.disconnect();
        await UserDBTable().deleteCurrentSignedUser(state.user!.email!);
      }
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    } catch (error) {
      emit(state.copyWith(status: AuthStatus.unknown));
    }
  }

  User convertUserAccountToUser(GoogleSignInAccount userAccount) {
    Map<String, dynamic> userData = <String, dynamic>{};
    userData['displayName'] = userAccount.displayName;
    userData['email'] = userAccount.email;
    userData['userId'] = userAccount.id.toString();
    userData['photoUrl'] = userAccount.photoUrl;
    userData['logedInPlatform'] = 'google';
    return User.fromJson(userData);
  }

  User convertFacebookAccountToUser(Map<String, dynamic> requestData) {
    String imageUrl = requestData['picture']['data']['url'];
    Map<String, dynamic> userData = <String, dynamic>{};
    userData['displayName'] = requestData['name'];
    userData['email'] = requestData['email'].toString();
    userData['userId'] = requestData['id'].toString();
    userData['photoUrl'] = imageUrl;
    userData['logedInPlatform'] = 'facebook';

    // userData['photoUrl'] =
    //     "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-High-Quality-Image.png";
    return User.fromJson(userData);
  }
}

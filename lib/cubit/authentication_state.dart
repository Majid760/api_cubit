part of 'authentication_cubit.dart';

enum AuthStatus { authenticated, unauthenticated, unknown, loading }

class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.status = AuthStatus.unauthenticated,
    this.logedInPlatform,
    this.user,
  });

  final AuthStatus status;
  final User? user;
  final String? logedInPlatform;

  AuthenticationState copyWith(
      {AuthStatus? status, User? user, String? logedInPlatform}) {
    return AuthenticationState(
        status: status ?? this.status,
        user: user ?? this.user,
        logedInPlatform: logedInPlatform ?? logedInPlatform);
  }

  @override
  List<Object?> get props => [user, status, logedInPlatform];
}

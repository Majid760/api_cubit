import 'package:api_cubit/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomeDrawer extends StatelessWidget {
  const CustomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        switch (state.status) {
          case AuthStatus.authenticated:
            return Drawer(
              child: ListView(
                children: [
                  state.user!.photoUrl != null
                      ? UserAccountsDrawerHeader(
                          accountName: Text(state.user!.displayName.toString(),
                              style: const TextStyle(color: Colors.white)),
                          accountEmail: Text(state.user!.email.toString(),
                              style: const TextStyle(color: Colors.white)),
                          currentAccountPicture: CircleAvatar(
                            backgroundImage:
                                NetworkImage(state.user!.photoUrl.toString()),
                          ),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/background1.jpg'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      : UserAccountsDrawerHeader(
                          accountName: Text(state.user!.displayName.toString(),
                              style: const TextStyle(color: Colors.white)),
                          accountEmail: Text(state.user!.email.toString(),
                              style: const TextStyle(color: Colors.white)),
                          currentAccountPicture: CircleAvatar(
                            child: Center(
                              child: Text(state.user!.displayName![0],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 32)),
                            ),
                          ),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://cdn.wallpapersafari.com/12/28/0objwK.jpg",
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text("Home"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_box),
                    title: const Text("About"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.grid_3x3_outlined),
                    title: const Text("Products"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.contact_mail),
                    title: const Text("Contact"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout_outlined),
                    title: const Text("Sign Out"),
                    onTap: () async {
                      await BlocProvider.of<AuthenticationCubit>(context)
                          .signOut();
                    },
                  )
                ],
              ),
            );
          case AuthStatus.loading:
            return Material(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          default:
            return const Center(
              child: Text('no data found!'),
            );
        }
      },
    );
  }
}

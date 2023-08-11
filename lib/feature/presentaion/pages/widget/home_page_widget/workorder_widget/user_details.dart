import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suja_shoie_app/feature/presentaion/api_services/login_api_service.dart';
import 'package:suja_shoie_app/feature/presentaion/api_services/user_service.dart';

import '../../../../providers/theme_providers.dart';

class UserDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeProvider>(context);
    final Login_auth_Screen authservice = Login_auth_Screen();

    void signOut() {
      authservice.logOutUSer(context);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PopupMenuButton<String>(
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              color: Colors.grey,
            ),
          ),
          offset: const Offset(0, 50),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'account',
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(
                                'assets/images/Suji shoie1.jpg'), // Replace with your image asset
                            radius: 50,
                          ),
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.camera_alt,
                              size: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      const Text('Name'),
                      const SizedBox(height: 8.0),
                      Container(
                        height: 2,
                        width: double.infinity,
                        color: themeState.isDarkTheme
                            ? const Color(0xFF0d0d0d)
                            : Colors.grey.shade400,
                      ),
                    ],
                  ),
                ),
              ),
              PopupMenuItem<String>(
                child: Container(
                  alignment: Alignment.center,
                  child: const Text('Employee Id'),
                ),
              ),
              PopupMenuItem<String>(
                value: 'signOut',
                child: GestureDetector(
                  onTap: () {
                    signOut();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text('Sign Out'),
                  ),
                ),
              ),
              PopupMenuItem<String>(
                enabled: true,
                value: 'account',
                child: Container(
                  alignment: Alignment.center,
                  width: 200,
                  height: 150,
                ),
              ),
            ];
          },
          onSelected: null,
        ),
      ],
    );
  }
}

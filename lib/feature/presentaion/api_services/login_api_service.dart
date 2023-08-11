// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:suja_shoie_app/feature/presentainon/pages/home_page/main_screen.dart';
// import 'package:suja_shoie_app/feature/presentainon/pages/spalsh_screen.dart';

// import '../feature/presentainon/providers/userprovider.dart';
// import '../utils/error_handle.dart';

// class AuthServices {
//   void signInUser({
//     required BuildContext context,
//     required String email,
//     required String password,
//   }) async {
//     try {
//       http.Response res = await http.post(
//         Uri.parse('http://192.168.0.103:3000/api/signin'),
//         body: jsonEncode({"email": email, "password": password}),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//       );

//       // ignore: use_build_context_synchronously
//       httpErrorHandle(
//         response: res,
//         context: context,
//         onSuccess: () async {
//           SharedPreferences pref = await SharedPreferences.getInstance();
//           Provider.of<UserProvider>(context, listen: false).setUser(res.body);
//           await pref.setString("auth-token", jsonDecode(res.body)["token"]);
//           // ignore: use_build_context_synchronously
//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => MainScreen(),
//               ),
//               (route) => false);
//         },
//       );
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//   }

//   void logOutUSer(
//     BuildContext context,
//   ) async {
//     try {
//       SharedPreferences sharedPreferences =
//           await SharedPreferences.getInstance();
//       await sharedPreferences.setString("auth-token", "");
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//             builder: (context) => SplashScreen(),
//           ),
//           (route) => false);

//       // ignore: use_build_context_synchronously
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//   }

//   void getUserData(
//     BuildContext context,
//   ) async {
//     try {
//       SharedPreferences pref = await SharedPreferences.getInstance();
//       String? token = pref.getString("auth-token");

//       if (token == null) {
//         pref.setString("auth-token", "");
//       }

//       var tokenRes = await http.post(
//           Uri.parse("http://192.168.0.103:3000/api/tokenValidate"),
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8',
//             'auth-token': token!,
//           });

//       var response = jsonDecode(tokenRes.body);

//       if (response == true) {
//         http.Response userRes = await http.get(
//             Uri.parse("http://192.168.0.103:3000/api/"),
//             headers: <String, String>{
//               'Content-Type': 'application/json; charset=UTF-8',
//               'auth-token': token,
//             });

//         // ignore: use_build_context_synchronously
//         var userProvid = Provider.of<UserProvider>(context, listen: false);

//         userProvid.setUser(userRes.body);
//       }
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//   }
// }

// void showSnackBar(BuildContext? context, String message) {
//   if (context != null) {
//     final snackBar = SnackBar(
//       content: Text(message),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }

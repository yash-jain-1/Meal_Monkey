import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:monkey_app_demo/widgets/customTextInput.dart';

import '../utils/helper.dart';
import '../widgets/customNavBar.dart';
import 'cartScreen.dart';
import 'loginScreen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);
  static const routeName = "/profileScreen";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              height: Helper.getScreenHeight(context),
              width: Helper.getScreenWidth(context),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Profile",
                            style: Helper.getTheme(context).headlineSmall,
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(CartScreen.routeName);
                            },
                            icon: Icon(Icons.shopping_cart_outlined),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CircleAvatar(
                        radius: 50,
                        onBackgroundImageError: (exception, stackTrace) => "https://images.pexels.com/photos/15332188/pexels-photo-15332188.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                        backgroundImage: NetworkImage(currentUser.photoURL ?? "https://images.pexels.com/photos/15332188/pexels-photo-15332188.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
                      ),
                      Text(currentUser.displayName ?? "Name"),
                      Text(currentUser.email ?? "Email"),
                      Text(currentUser.phoneNumber ?? "Phone Number"),
                      // Text(currentUser.address ?? "Address"),
                      Text(currentUser.uid ?? "UID"),

                      // CustomTextInput(
                      //   label: "Name",
                      //   hintText: "Enter your name",
                      //   textEditingController: TextEditingController(
                      //       text: currentUser.displayName ?? "Name"),
                      // ),
                      Column(
                        children: [
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .where('email', isEqualTo: currentUser.email)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                // return Column(
                                //   children: snapshot.data.docs.map((doc) {
                                //     return Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: Card(
                                //         child: ListTile(
                                //           leading: CircleAvatar(
                                //             backgroundImage: NetworkImage(doc['photoUrl']),
                                //           ),
                                //           title: Text(doc['displayName']),
                                //           subtitle: Text(doc['email']),
                                //         ),
                                //       ),
                                //     );
                                //   }).toList(),
                                // );
                                return Column(
                                  children: [
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Text("YOUR FOODIE PROFILE"),
                                   ),
                                    Center(
                                      child: Card(
                                        child: Column(
                                          children: snapshot.data.docs
                                              .map(
                                                (e) => Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      children: [
                                                        // CircleAvatar(
                                                        //   backgroundImage:
                                                        //       NetworkImage(
                                                        //           e['photoUrl']),
                                                        // ),
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text(
                                                            'Name: ${e['name']}',
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text(
                                                            'Email: ${e['email']}',
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                         Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text(
                                                            'Address: ${e['address'] ?? "No address"}',
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                       
                                                        // Text(
                                                        //   "Address: ${e['address'] ?? "No address"}",

                                                        // ),
                                                        //                               CustomFormImput(
                                                        //   label: "Name",
                                                        //   value: _name,
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            await GoogleSignIn().signOut();
                            Navigator.of(context)
                                .pushReplacementNamed(LoginScreen.routeName);
                          },
                          child: Text('Sign out'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: CustomNavBar(
              profile: true,
            ),
          ),
        ],
      ),
    );
  }
}































// // import 'dart:js';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:monkey_app_demo/const/colors.dart';
// import 'package:monkey_app_demo/screens/cartScreen.dart';
// import 'package:monkey_app_demo/utils/helper.dart';
// import 'package:monkey_app_demo/widgets/customNavBar.dart';
// import 'package:rive/rive.dart';
// import 'loginScreen.dart';

// class ProfileScreen extends StatefulWidget {
//   static const routeName = "/profileScreen";

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   String _name;
//   String _email;
//   String _photo;
//   String _password;
//   String _address;
//   String _mobile;

//   @override
//   void initState() {
//     super.initState();
//     _getUserDetails();
//   }

//   Future<void> _getUserDetails() async {
//     var collection = FirebaseFirestore.instance
//         .collection('users')
//         .doc(FirebaseAuth.instance.currentUser.uid);
//     var documentSnapshot = await collection.get();
//     if (documentSnapshot.exists) {
//       Map<String, dynamic> data = documentSnapshot.data();
//       setState(
//         () {
//           _name = data['name'];
//           // _photo = data['photoUrl'];
//           // _email = data['email'];
//           // _password = data['password'];
//           // _address = data['address'];
//           // _mobile = data['mobile'];
//         },
//       );
//       print(data);
//     } else {
//       // Handle case where driver does not exist
//       return AlertDialog(
//         title: RiveAnimation.asset("assets/4954-10032-fire-skull.riv"),
//         content: Text("User does not exist"),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text("OK"),
//           ),
//         ],
//       );
//     }
//   }

//   // User currentUser = FirebaseAuth.instance.currentUser;
//   @override
//   Widget build(BuildContext context) {
//     // return Scaffold(
//     //   body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//     //     stream: FirebaseFirestore.instance.collection('users').snapshots(),
//     //     builder: (_, snapshot) {
//     //       if (snapshot.hasError) return Text('Error = ${snapshot.error}');

//     //       if (snapshot.hasData) {
//     //         final docs = snapshot.data.docs;
//     //         return ListView.builder(
//     //           itemCount: docs.length,
//     //           itemBuilder: (_, i) {
//     //             final data = docs[i].data();
//     //             return ListTile(
//     //               title: Text(data['name']),
//     //               subtitle: Text(data['mobile']),
//     //             );
//     //           },
//     //         );
//     //       }

//     //       return Center(child: CircularProgressIndicator());
//     //     },
//     //   ),
//     // );
//     return Scaffold(
//       body: Stack(
//         children: [
//           SafeArea(
//             child: Container(
//               height: Helper.getScreenHeight(context),
//               width: Helper.getScreenWidth(context),
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 20.0, vertical: 10),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Profile",
//                             style: Helper.getTheme(context).headlineSmall,
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               Navigator.of(context)
//                                   .pushReplacementNamed(CartScreen.routeName);
//                             },
//                             icon: Icon(Icons.shopping_cart_outlined),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       ClipOval(
//                         child: Stack(
//                           children: [
//                             Container(
//                               height: 200,
//                               width: 200,
//                               child: RiveAnimation.asset('assets/4785-9651-chachu.riv',                             
//                                 fit: BoxFit.cover,
//                                 placeHolder: Icon(Icons.abc),
//                               ),
//                             ),
//                             // Positioned(
//                             //   bottom: 0,
//                             //   child: Container(
//                             //     height: 20,
//                             //     width: 80,
//                             //     color: Colors.black.withOpacity(0.3),
//                             //     child: Image.asset(Helper.getAssetName(
//                             //         "camera.png", "virtual")),
//                             //   ),
//                             // )
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       // Row(
//                       //   mainAxisAlignment: MainAxisAlignment.center,
//                       //   children: [
//                       //     IconButton(
//                       //         onPressed: () {},
//                       //         icon: Icon(
//                       //           Icons.edit,
//                       //           color: AppColor.orange,
//                       //         )),
//                       //     Text(
//                       //       "Edit Profile",
//                       //       style: TextStyle(color: AppColor.orange),
//                       //     ),
//                       //   ],
//                       // ),
//                       // SizedBox(
//                       //   height: 10,
//                       // ),
//                       Text("$_name"
//                           // getUserData().name,
//                           // style: Helper.getTheme(context).headline4.copyWith(
//                           //       color: AppColor.primary,
//                           //     ),
//                           ),
//                       // SizedBox(
//                       //   height: 5,
//                       // ),
//                       // Text("Sign Out"),
//                       SizedBox(
//                         height: 40,
//                       ),
//                       CustomFormImput(
//                         label: "Name",
//                         value: _name,
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       CustomFormImput(
//                         label: "Email",
//                         value: _email,
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       CustomFormImput(
//                         label: "Mobile No",
//                         value: _mobile,
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       CustomFormImput(
//                         label: "Address",
//                         value: _address,
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       CustomFormImput(
//                         label: "Password",
//                         // value: getUserData().password,
//                         isPassword: true,
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       SizedBox(
//                         height: 50,
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             return AlertDialog(
//                               title: Text("Update Profile"),
//                               content: Text("Are you sure you want to update?"),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: Text("Cancel"),
//                                 ),
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: Text("Update"),
//                                 ),
//                               ],
//                             );
//                           },
//                           child: Text("Update"),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       SizedBox(
//                         height: 50,
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             await FirebaseAuth.instance.signOut();
//                             await GoogleSignIn().signOut();
//                             Navigator.of(context)
//                                 .pushReplacementNamed(LoginScreen.routeName);
//                           },
//                           child: Text('Sign out'),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             child: CustomNavBar(
//               profile: true,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CustomFormImput extends StatelessWidget {
//   const CustomFormImput({
//     Key key,
//     String label,
//     String value,
//     bool isPassword = false,
//   })  : _label = label,
//         _value = value,
//         _isPassword = isPassword,
//         super(key: key);

//   final String _label;
//   final String _value;
//   final bool _isPassword;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 50,
//       padding: const EdgeInsets.only(left: 40),
//       decoration: ShapeDecoration(
//         shape: StadiumBorder(),
//         color: AppColor.placeholderBg,
//       ),
//       child: TextFormField(
//         decoration: InputDecoration(
//           border: InputBorder.none,
//           labelText: _label,
//           contentPadding: const EdgeInsets.only(
//             top: 10,
//             bottom: 10,
//           ),
//         ),
//         obscureText: _isPassword,
//         initialValue: _value,
//         style: TextStyle(
//           fontSize: 14,
//         ),
//       ),
//     );
//   }
// }

// getUserData() async {
//   User currentUser = FirebaseAuth.instance.currentUser;
//   DocumentReference userRef =
//       FirebaseFirestore.instance.collection('users').doc(currentUser.uid);
//   DocumentSnapshot userSnapshot = await userRef.get();

//   if (!userSnapshot.exists) {
//     print("No user found");
//     return AlertDialog(
//       title: Text("Error"),
//       content: Text("No user found"),
//       actions: [
//         ElevatedButton(
//           onPressed: () {
//             // Navigator.pop(context);
//           },
//           child: Text("Ok"),
//         )
//       ],
//     );
//   } else {
//     print("User data fetched successfully");
//   }
// }

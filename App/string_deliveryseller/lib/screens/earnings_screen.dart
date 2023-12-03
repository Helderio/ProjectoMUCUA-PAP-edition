 import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:flutter/material.dart';
 import 'package:sellers_food_app/global/global.dart';

 import '../screens/home_screen.dart';

 // ignore: use_key_in_widget_constructors
 class EarningsScreen extends StatefulWidget {
   @override
   _EarningsScreenState createState() => _EarningsScreenState();
 }

 class _EarningsScreenState extends State<EarningsScreen> {
   double sellerTotalEarnings = 0;

   retrieveSellerEarnings() async {
     await FirebaseFirestore.instance
         .collection("sellers")
         .doc(sharedPreferences!.getString("uid"))
         .get()
         .then((snap) {
       setState(() {
         sellerTotalEarnings = double.parse(snap.data()!["earnings"].toString());
       });
     });
   }

   @override
   void initState() {
     super.initState();

     retrieveSellerEarnings();
   }

   @override
   Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.black,
       body: Container(
         decoration: const BoxDecoration(           gradient: LinearGradient(
             begin: FractionalOffset(-1.0, 0.0),
             end: FractionalOffset(5.0, -1.0),
             colors: [
    Color(0xFF4285F4), // azul
    Color(0xFF0D47A1), // azul escuro
]
           ),
         ),
         child: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text(
                 "\$" + sellerTotalEarnings.toString(),
                 style: const TextStyle(
                   fontSize: 80,
                  color: Colors.black,
                   fontFamily: "Signatra",
                ),
               ),
               const SizedBox(height: 10),
               const Text(
                 "Total ganho ",
                 style: TextStyle(
                   fontSize: 20,
                   color: Colors.black,
                   fontWeight: FontWeight.bold,
                   letterSpacing: 3,
                 ),
               ),
               const SizedBox(
                 height: 20,
                 width: 200,
                 child: Divider(
                   color: Colors.white,
                   thickness: 2,
                 ),
               ),
               const SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const HomeScreen())));
                  },
                  child: Card(
                    color: Colors.blue.withOpacity(0.8),
                    margin: const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 140,
                    ),
                    child: const ListTile(
                      leading: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      title: Text(
                       "Voltar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                     ),
                   ),
                  ),
                )
            ],
           ),
         ),
       ),
     );
   }
 }

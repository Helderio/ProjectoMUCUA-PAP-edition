import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sellers_food_app/global/global.dart';
import 'package:sellers_food_app/models/items.dart';
import 'package:sellers_food_app/widgets/my_drawer.dart';
import 'package:sellers_food_app/widgets/progress_bar.dart';
import 'package:sellers_food_app/widgets/seller_info.dart';

import '../upload_screens/items_upload_screen.dart';
import '../widgets/info_design.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset(-2.0, 0.0),
            end: FractionalOffset(5.0, -1.0),
           colors: [
    Color(0xFF4285F4), // azul
    Color(0xFF0D47A1), // azul escuro
         ]
          )
        )
        )
      


  
       child: CustomScrollView(
  slivers: [
    //appbar
    SliverAppBar(
      elevation: 1,
      pinned: true,
      backgroundColor: const Color(0xFF4285F4),
      foregroundColor: Colors.black,
      expandedHeight: 50,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset(-1.0, 0.0),
            end: FractionalOffset(4.0, -1.0),
            colors: [
              Color(0xFF4285F4), // azul
              Color(0xFF0D47A1), // azul escuro
            ],
          ),
        ),
        child: FlexibleSpaceBar(
          title: Text(
            'String',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          centerTitle: false,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: const Icon(Icons.add),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => const ItemsUploadScreen(),
                ),
              );
            },
          ),
        ),
      ],
    ),
    // Seller info is displayed here
    const SliverToBoxAdapter(
      child: SellerInfo(),
    ),
    StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("items")
          .orderBy("publishedDate", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SliverToBoxAdapter(
            child: Center(
              child: circularProgress(),
            ),
          );
        } else if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        } else if (snapshot.data!.size == 0) {
          return SliverToBoxAdapter(
            child: const Center(
              child: Text("No items available."),
            ),
          );
        } else {
          return SliverStaggeredGrid.countBuilder(
            staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
            crossAxisCount: 1,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            itemBuilder: (context, index) {
              Items model = Items.fromJson(
                snapshot.data!.docs[index].data() as Map<String, dynamic>,
              );
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InfoDesignWidget(
                  model: model,
                  context: context,
                ),
              );
            },
            itemCount: snapshot.data!.size,
          );
        }
      },
    ),
  ],
),

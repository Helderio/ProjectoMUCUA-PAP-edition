// ignore_for_file: library_prefixes

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellers_food_app/global/global.dart';
import 'package:sellers_food_app/widgets/progress_bar.dart';
import 'package:firebase_storage/firebase_storage.dart' as storageRef;

import '../models/menus.dart';
import '../widgets/error_dialog.dart';

class ItemsUploadScreen extends StatefulWidget {
  final Menus? model;

  const ItemsUploadScreen({Key? key, this.model}) : super(key: key);

  @override
  _ItemsUploadScreenState createState() => _ItemsUploadScreenState();
}

class _ItemsUploadScreenState extends State<ItemsUploadScreen> {
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  TextEditingController shortInfoController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  bool uploading = false;

  //unique id for menus
  String uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();

  defaultScreen() {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset(-2.0, 0.0),
              end: FractionalOffset(5.0, -1.0),
              colors: [
    Color(0xFF4285F4), // azul
    Color(0xFF0D47A1), // azul escuro
]

            ),
          ),
        ),
        title: Text(
          "Adicionar novos itens",
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset(-2.0, 0.0),
            end: FractionalOffset(4.0, -1.0),
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
              const Icon(
                Icons.shop_two,
                color: Colors.black,
                size: 150,
              ),
              ElevatedButton(
                onPressed: () {
                  takeImage(context);
                },
                child: Text(
                  "Adicionar novo item",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  takeImage(mcontext) {
    return showDialog(
        context: mcontext,
        builder: (c) {
          return SimpleDialog(
            title: const Text(
              "Imagem do menu",
              style:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            children: [
              SimpleDialogOption(
                child: const Text(
                  "usar a câmera",
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: captureImageWithCamera,
              ),
              SimpleDialogOption(
                child: const Text(
                  "Selecionar da galeria",
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: pickImageFromGallery,
              ),
              SimpleDialogOption(
                child: const Center(
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

//capture with camera
  captureImageWithCamera() async {
    Navigator.pop(context);
    imageXFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 1280,
    );

    setState(() {
      imageXFile;
    });
  }

//select image from gallery
  pickImageFromGallery() async {
    Navigator.pop(context);
    imageXFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 1280,
    );
    setState(() {
      imageXFile;
    });
  }

  itemsUploadFormScreen() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset(-2.0, 0.0),
              end: FractionalOffset(5.0, -1.0),
              colors: [
    Color.fromARGB(255, 255, 255, 255), // azul
    Color(0xFF0D47A1), // azul escuro
]
            ),
          ),
        ),
        title: Text(
          "Formulário de Novo Item",
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            clearMenuUploadFrom();
          },
        ),
        actions: [
          ElevatedButton(
            onPressed:
                //we check if uploading is null (otherwise if user clicks more than 1 time it will upload more than 1 time)
                uploading ? null : () => validateUploadForm(),
            child: Text(
              "Adicionar",
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<CircleBorder>(
                const CircleBorder(),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset(-2.0, 0.0),
            end: FractionalOffset(5.0, -1.0),
           colors: [
    Color(0xFF4285F4), // azul
    Color(0xFF0D47A1), // azul escuro
]
          ),
        ),
        child: ListView(
          children: [
            uploading == true ? linearProgress() : const Text(""),
            SizedBox(
              height: 230,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 16 / 10,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(
                          File(imageXFile!.path),
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(-1, 10),
                          blurRadius: 10,
                        )
                      ],
                      gradient: const LinearGradient(
                        begin: FractionalOffset(-2.0, 0.0),
                        end: FractionalOffset(5.0, -1.0),
                       colors: [
    Color(0xFF4285F4), // azul
    Color(0xFF0D47A1), // azul escuro
]
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 2,
            ),
            ListTile(
              leading: const Icon(
                Icons.perm_device_information,
                color: Colors.black,
              ),
              title: SizedBox(
                width: 250,
                child: TextField(
                  controller: shortInfoController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                      hintText: "Informação",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                ),
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 2,
            ),
            ListTile(
              leading: const Icon(
                Icons.title,
                color: Colors.black,
              ),
              title: SizedBox(
                width: 250,
                child: TextField(
                  controller: titleController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                      hintText: "Titulo",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                ),
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 2,
            ),
            ListTile(
              leading: const Icon(
                Icons.description,
                color: Colors.black,
              ),
              title: SizedBox(
                width: 250,
                child: TextField(
                  controller: descriptionController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                      hintText: "Descrição",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                ),
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 2,
            ),
            ListTile(
              leading: const Icon(
                Icons.monetization_on,
                color: Colors.black,
              ),
              title: SizedBox(
                width: 250,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: priceController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                      hintText: "Preço",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//clearing textfields
  clearMenuUploadFrom() {
    setState(() {
      shortInfoController.clear();
      titleController.clear();
      priceController.clear();
      descriptionController.clear();
      imageXFile = null;
    });
  }

  validateUploadForm() async {
    if (imageXFile != null) {
      if (shortInfoController.text.isNotEmpty &&
          titleController.text.isNotEmpty &&
          descriptionController.text.isNotEmpty &&
          priceController.text.isNotEmpty) {
        // if its true set uploading to true and start process indicator
        setState(() {
          uploading = true;
        });

        //upload image
        String downloadUrl = await uploadImage(File(imageXFile!.path));

        //save info to firestore

        saveInfo(downloadUrl);
      } else {
        showDialog(
          context: context,
          builder: (c) {
            return const ErrorDialog(
              message: "Por favor, escreva o título e as informações para o item.",
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (c) {
          return const ErrorDialog(
            message: "Por favor, escolha uma imagem para o item.",
          );
        },
      );
    }
  }

//uploading image
  uploadImage(mImageFile) async {
    //we are creating seperate folder in firebase
    storageRef.Reference reference =
        storageRef.FirebaseStorage.instance.ref().child("items");

    storageRef.UploadTask uploadTask =
        reference.child(uniqueIdName + ".jpg").putFile(mImageFile);

    storageRef.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

    String downloadingUrl = await taskSnapshot.ref.getDownloadURL();

    return downloadingUrl;
  }

void saveInfo(String downloadUrl) {
  final ref = FirebaseFirestore.instance
      .collection("sellers")
      .doc(sharedPreferences!.getString("uid"))
      .collection("items");

  ref.doc(uniqueIdName).set(
    {
      "itemID": uniqueIdName,
      "sellerUID": sharedPreferences!.getString("uid"),
      "sellerName": sharedPreferences!.getString("name"),
      "shortInfo": shortInfoController.text.toString(),
      "longDescription": descriptionController.text.toString(),
      "price": int.parse(priceController.text),
      "title": titleController.text.toString(),
      "publishedDate": DateTime.now(),
      "status": "available",
      "thumbnailUrl": downloadUrl,
    },
  ).then((_) {
    final itemsRef = FirebaseFirestore.instance.collection("items");
    itemsRef.doc(uniqueIdName).set(
      {
        "itemID": uniqueIdName,
        "sellerUID": sharedPreferences!.getString("uid"),
        "sellerName": sharedPreferences!.getString("name"),
        "shortInfo": shortInfoController.text.toString(),
        "longDescription": descriptionController.text.toString(),
        "price": int.parse(priceController.text),
        "title": titleController.text.toString(),
        "publishedDate": DateTime.now(),
        "status": "available",
        "thumbnailUrl": downloadUrl,
      },
    ).then((_) {
      clearMenuUploadFrom();

      setState(() {
        uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();
        uploading = false;
      });
    }).catchError((error) {
      print("Error saving menu to 'items' collection: $error");
    });
  }).catchError((error) {
    print("Error saving menu to 'sellers/items' subcollection: $error");
  });
}

@override
  Widget build(BuildContext context) {
  return imageXFile == null ? defaultScreen() : itemsUploadFormScreen();
}










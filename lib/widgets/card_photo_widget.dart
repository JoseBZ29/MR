import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecommerce/globals.dart' as globals;

class CardFotos extends StatefulWidget {
  CardFotos({Key key}) : super(key: key);

  @override
  CardFotosState createState() => CardFotosState();
}

class CardFotosState extends State<CardFotos> {
  static File galleryFile;
  static Future<File> imageFile;
  static File galleryFile2;
  static Future<File> imageFile2;

  @override
  void initState() {
    imageFile = null;
    imageFile2 = null;
    super.initState();
  }

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          galleryFile = snapshot.data;
          print(galleryFile);
          globals.imagen = 1;
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
          );
        } else if (snapshot.error != null) {
          globals.imagen = 0;
          return const Text(
            'Error al seleccionar la imagen',
            textAlign: TextAlign.center,
          );
        } else {
          globals.imagen = 0;
          return Image.asset("assets/images/CargaMR.png");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom:MediaQuery.of(context).size.height/50),
                child: Text(
                    'Imagen descriptiva del trabajo.')),
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(10.0),
              child: InkWell(
                onTap: () => pickImageFromGallery(ImageSource.gallery),
                onDoubleTap: () => pickImageFromGallery(ImageSource.camera),
                child: Container(
                  width: 200,
                  height: 200,
                  child: showImage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

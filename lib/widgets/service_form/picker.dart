import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pick extends StatefulWidget {
  @override
  _PickState createState() => _PickState();
}

class _PickState extends State<Pick> {
   static List<Asset> images = List<Asset>();
  static String _error = 'No Error Dectected';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  IconButton(
                icon: Icon(
                  Icons.camera_alt
                ), 
                onPressed: (){
                  loadAssets(context);
                });
        
        // Expanded(
        //   child: buildGridView(),
        // )
      

  }

  Future<void> loadAssets(BuildContext context) async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Selecciona",
          allViewTitle: "Todas las imágenes",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      saveImage(resultList[0],context);
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  Future<String> saveImage(Asset asset,BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ByteData byteData = await asset.requestOriginal();
    List<int> imageData = byteData.buffer.asUint8List();
    StorageReference ref = FirebaseStorage.instance.ref().child("Nombre.jpg");
    StorageUploadTask uploadTask = ref.putData(imageData);
    var downurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    var url = downurl.toString();
    print(url);
    prefs.setString('url', url);
    modal(context);
    return url;
}

  Widget buildGridView() {
    
    return Wrap(
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 200,
          height: 200,
        );
      }),
    );
    
  }

  Widget modal(context){
     showDialog(context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: new Text("Cambiado tu foto Exitoso"),
          content: new Text("Los cambios se han realizado correctamente, tardarán algunos minutos en reflejarse con exito."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Entiendo"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }
}
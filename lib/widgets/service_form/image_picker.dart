import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:async';

class ImgPicker extends StatefulWidget {
  @override
  _ImgPickerState createState() => _ImgPickerState();
}

class _ImgPickerState extends State<ImgPicker> {
  static List<Asset> images = List<Asset>();
  static String _error = 'No Error Dectected';
  

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(left: 10, top: 20),
      child: GestureDetector(
                  onTap: null,
                  child:Row(
                  children: <Widget>[
                    Icon(LineIcons.camera, size: 25,),
                    Text('Agregar imágenes', style: TextStyle(fontSize: 18)),
                  ],
                ),
                ),
    );
            
          
            
            
    // RaisedButton(
    //       child: Text("Pick images"),
    //       onPressed: loadAssets,
    //     );
      
        
        // Expanded(
        //   child: buildGridView(),
        // )
      

  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 3,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat",),
        
        materialOptions: MaterialOptions(
          okButtonDrawable: 'Hola',
          actionBarColor: "#abcdef",
          actionBarTitle: "Selecciona",
          allViewTitle: "Todas las imágenes",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
      print(error);
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
}

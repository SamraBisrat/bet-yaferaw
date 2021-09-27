import 'package:bet_yaferaw/Components/AddRecipeComponent/bloc/add_recipe_bloc.dart';
import 'package:bet_yaferaw/Components/AddRecipeComponent/bloc/add_recipe_state.dart';
import 'package:bet_yaferaw/Repositories/add_recipe_repo.dart';
import 'package:bet_yaferaw/ReusableComponents/bottom_navigation.dart';
import 'package:bet_yaferaw/ReusableComponents/snack_bar.dart';
import 'package:bet_yaferaw/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

class AddRecipe extends StatefulWidget {
  const AddRecipe({Key key}) : super(key: key);

  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final ImagePicker _picker = ImagePicker();
  File imageUrl;

  Future pickImageFromCamera(BuildContext context) async {
    XFile image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _cropImage(image);
      });
    }
  }

  Future pickImageFromGallery(BuildContext context) async {
    XFile image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _cropImage(image);
      });
    }
  }

  Future<Null> _cropImage(XFile cropped) async {
    // var img = Image.file(File(cropped.path));
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: cropped.path,
        cropStyle: CropStyle.rectangle,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
              ]
            : [
                CropAspectRatioPreset.square,
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Color(0xff82B242),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      imageUrl = croppedFile;

      setState(() {
        imageUrl = croppedFile;
      });
    }
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Add profile image"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Use photo in library"),
                      onTap: () {
                        pickImageFromGallery(context);
                        Navigator.of(context).pop();
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Take a new picture"),
                      onTap: () {
                        pickImageFromCamera(context);
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ));
        });
  }

  List<Ingredients> ingredients = [];
  List<Ingredients> uiIngredients = [];

  String categoryController;
  String cookingController;
  String servingController;
  TextEditingController titleController;
  TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocProvider(
              create: (context) =>
                  AddRecipeBloc(addRecipeRepositories: AddRecipeRepositories()),
              child: BlocConsumer<AddRecipeBloc, AddRecipeState>(
                  builder: buildForState,
                  listener: (blocContext, blocState) {
                    
                  }))),
    );
  }

  Widget buildForState(blocContext, AddRecipeState blocState) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: YRBottomNavigation(),
      body: Container(
          height: screenHeight,
          child: ListView(shrinkWrap: true, children: [
            Card(
                child: Column(children: [
              Stack(alignment: Alignment.center, children: [
                Container(
                  height: screenHeight / 2.5,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage("assets/images/post_background.jpg"),
                          fit: BoxFit.fitWidth)),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey.shade800.withOpacity(0.66)),
                      child: ListTile(
                        onTap: () {
                          _showSelectionDialog(context);
                        },
                        dense: true,
                        horizontalTitleGap: 0,
                        leading: Icon(
                          Icons.camera_alt_sharp,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Add Picture',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                )
              ]),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffC4C4C4)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffFD6637)),
                    ),
                    isDense: true,
                    alignLabelWithHint: true,
                    border: UnderlineInputBorder(),
                    labelText: 'Title Here',
                    labelStyle: TextStyle(color: Color(0xffFD6637))),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Category",
                            style: TextStyle(
                                color: Color(0xffFD6637),
                                decorationStyle: TextDecorationStyle.dashed)),
                        Container(
                            width: screenWidth / 2,
                            child: DropdownButtonFormField(
                              decoration:
                                  InputDecoration.collapsed(hintText: ""),
                              value: categoryController,
                              onChanged: (String newValue) {
                                categoryController = newValue;
                              },
                              items: <String>[
                                'Breakfast',
                                'Lunch',
                                'Dinner',
                                'Brunch',
                                'Snack',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    textWidthBasis: TextWidthBasis.parent,
                                    style: TextStyle(color: Color(0xffFD6637)),
                                  ),
                                );
                              }).toList(),
                            )),
                      ])),
              Divider(
                color: Color(0xffC4C4C4),
                thickness: 1,
                height: 0,
              ),
              Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Cooking",
                            style: TextStyle(
                                color: Color(0xffFD6637),
                                decorationStyle: TextDecorationStyle.dashed)),
                        Container(
                            width: screenWidth / 2,
                            child: DropdownButtonFormField(
                              decoration:
                                  InputDecoration.collapsed(hintText: ""),
                              value: cookingController,
                              onChanged: (String newValue) {
                                cookingController = newValue;
                              },
                              items: <String>[
                                'less than 30 mintues',
                                '30 minutes',
                                '45 minutes',
                                '1 hour',
                                '1:30 hour',
                                '2 hours',
                                'Above 2 hours'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    textWidthBasis: TextWidthBasis.parent,
                                    style: TextStyle(color: Color(0xffFD6637)),
                                  ),
                                );
                              }).toList(),
                            )),
                      ])),
              Divider(
                color: Color(0xffC4C4C4),
                thickness: 1,
                height: 0,
              ),
              Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Serving",
                            style: TextStyle(
                                color: Color(0xffFD6637),
                                decorationStyle: TextDecorationStyle.dashed)),
                        Container(
                            width: screenWidth / 2,
                            child: DropdownButtonFormField(
                              itemHeight: 100,
                              // menuMaxHeight: 100,
                              decoration:
                                  InputDecoration.collapsed(hintText: ""),
                              value: servingController,
                              onChanged: (String newValue) {
                                servingController = newValue;
                              },
                              items: getList().map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    textWidthBasis: TextWidthBasis.parent,
                                    style: TextStyle(color: Color(0xffFD6637)),
                                  ),
                                );
                              }).toList(),
                            )),
                      ])),
              Divider(
                color: Color(0xffC4C4C4),
                thickness: 1,
                height: 0,
              ),
              TextFormField(
                controller: descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffC4C4C4)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffFD6637)),
                    ),
                    isDense: true,
                    alignLabelWithHint: true,
                    border: UnderlineInputBorder(),
                    labelText: 'Description',
                    labelStyle: TextStyle(color: Color(0xffFD6637))),
              ),
              Divider(
                color: Color(0xffC4C4C4),
                thickness: 1,
                height: 0,
              ),
              ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  title: const Text(
                    'Add new ingredients',
                    style: TextStyle(
                      color: Color(0xff0BCE83),
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.add_circle_rounded),
                    color: Colors.greenAccent.shade400,
                    onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          addIngredients(context),
                    ),
                  )),
              getIngredientList()
            ]))
          ])),
    );
  }

  Widget addIngredients(BuildContext context) {
    return AlertDialog(
        title: Text('Add ingredients'),
        content: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 48),
            child: IntrinsicWidth(
              child: TextFieldTags(
                  tagsStyler: TagsStyler(
                    showHashtag: false,
                    tagMargin: const EdgeInsets.only(right: 4.0),
                    tagCancelIcon:
                        Icon(Icons.cancel, size: 15.0, color: Colors.white),
                    tagCancelIconPadding: EdgeInsets.only(left: 4.0, top: 2.0),
                    tagPadding: EdgeInsets.only(
                        top: 2.0, bottom: 4.0, left: 8.0, right: 4.0),
                    tagDecoration: BoxDecoration(
                      color: Colors.orange,
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    tagTextStyle: TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.white),
                  ),
                  textFieldStyler: TextFieldStyler(
                    hintText: "",
                    isDense: false,
                    textFieldFocusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 3.0),
                    ),
                    textFieldBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 3.0),
                    ),
                  ),
                  onDelete: (tag) {
                    ingredients.remove(tag);
                  },
                  onTag: (tag) {
                    if ((ingredients.singleWhere((it) => it.ingredient == tag,
                            orElse: () => null)) !=
                        null) {
                      YRSnackBar(
                              title: "Ingredient Already Exists",
                              errorMessage:
                                  "Please enter a different ingredient.")
                          .showSnachkBar(context);
                    } else {
                      ingredients.add(Ingredients(ingredient: tag));
                    }
                  }),
            )),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  uiIngredients = ingredients;
                });
              },
              child: Text('Add')),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'))
        ]);
  }

  List<String> getList() {
    int i = 0;
    List<String> serving = [];
    while (i < 100) {
      i++;
      serving.add(i.toString());
    }
    return serving;
  }

  Widget getIngredientList() {
    return ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: uiIngredients.length,
        itemBuilder: (context, index) {
          return ListTile(
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      style: BorderStyle.solid, color: Color(0xff0BCE83)),
                  borderRadius: BorderRadius.circular(12.0)),
              contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              leading: Text(uiIngredients[index].ingredient.toString()),
              trailing: IconButton(
                icon: Icon(Icons.close, size: 16, color: AppTheme.primaryColor),
                onPressed: () {
                  setState(() {
                    uiIngredients.removeWhere((element) =>
                        element.ingredient == uiIngredients[index].ingredient);
                  });
                },
              ));
        });
  }
}

class Ingredients {
  Ingredients({this.ingredient});
  String ingredient;
}

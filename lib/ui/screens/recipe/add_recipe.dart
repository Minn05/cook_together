import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:recipes/constants.dart';
import 'package:recipes/domain/blocs/blocs.dart';
import 'package:recipes/ui/helpers/helpers.dart';
import 'package:recipes/ui/themes/colors_theme.dart';
import 'package:recipes/ui/widgets/widgets.dart';

import '../../themes/title_appbar.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({Key? key}) : super(key: key);

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  late TextEditingController _descriptionController;
  late TextEditingController _titleController;
  late TextEditingController _categoryController;
  late TextEditingController _totalPeopleController;
  late TextEditingController _timeController;
  late TextEditingController _caloriesController;
  final _keyForm = GlobalKey<FormState>();
  final _formKeyI = GlobalKey<FormState>();
  final _formKeyS = GlobalKey<FormState>();
  late List<TextEditingController> _itemIngredients = [];
  late List<TextEditingController> _itemSteps = [];
  late List<AssetEntity> _mediaList = [];
  late File fileImage;

  @override
  void initState() {
    _assetImagesDevice();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _addFieldIngredients();
      _addFieldSteps();
    });
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _categoryController = TextEditingController();
    _totalPeopleController = TextEditingController();
    _timeController = TextEditingController();
    _caloriesController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _totalPeopleController.dispose();
    _timeController.dispose();
    _caloriesController.dispose();
    super.dispose();
  }

  _addFieldIngredients() {
    setState(() {
      _itemIngredients.add(TextEditingController());
    });
  }

  _addFieldSteps() {
    setState(() {
      _itemSteps.add(TextEditingController());
    });
  }

  _removeItemIngredients(i) {
    setState(() {
      _itemIngredients.removeAt(i);
    });
  }

  _removeItemFieldSteps(i) {
    setState(() {
      _itemSteps.removeAt(i);
    });
  }

  _assetImagesDevice() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);
      if (albums.isNotEmpty) {
        List<AssetEntity> photos =
            await albums[0].getAssetListPaged(page: 0, size: 50);
        setState(() => _mediaList = photos);
      }
    } else {
      PhotoManager.openSetting();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final userBloc = BlocProvider.of<UserBloc>(context).state;
    final recipeBloc = BlocProvider.of<RecipeBloc>(context);
    final size = MediaQuery.of(context).size;

    return BlocListener<RecipeBloc, RecipeState>(
      listener: (context, state) {
        if (state is LoadingRecipe) {
          modalLoading(context, 'Tạo bài...');
        } else if (state is FailureRecipe) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessRecipe) {
          Navigator.pop(context);
          modalSuccess(
            context,
            "Tạo công thức thành công! ",
            onPressed: () => Navigator.pushAndRemoveUntil(context,
                routeSlide(page: const BottomNavigation()), (_) => false),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TitleAppbar(
            title: "Thêm công thức mới",
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Form(
          key: _keyForm,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Container(
                    height: size.height * 0.4,
                    width: size.width,
                    decoration: BoxDecoration(color: Colors.grey.shade100),
                    child: BlocBuilder<RecipeBloc, RecipeState>(
                      buildWhen: (previous, current) => previous != current,
                      builder: (_, state) => (state.imageFileSelectedRecipe !=
                              null)
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.imageFileSelectedRecipe!.length,
                              itemBuilder: (_, i) => Stack(
                                children: [
                                  Container(
                                    height: size.height * 0.4,
                                    width: size.width,
                                    margin: const EdgeInsets.only(bottom: 10.0),
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(state
                                                .imageFileSelectedRecipe![i]))),
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: InkWell(
                                      onTap: () {
                                        recipeBloc.add(
                                            OnClearSelectedImageEventRecipe(i));
                                      },
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.black38,
                                        child: Icon(Icons.close_rounded,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : SizedBox(
                              height: 40,
                              width: size.width,
                              child: InkWell(
                                onTap: () async {
                                  AppPermission()
                                      .permissionAccessGalleryMultiplesImagesNewRecipe(
                                          await Permission.storage.request(),
                                          context);
                                },
                                child: Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 100,
                                  color: ColorsCustom.primary.withOpacity(0.2),
                                ),
                              )),
                    ),
                  ),
                ),
                //click lấy hình
                // SizedBox(
                //   height: 40,
                //   width: size.width,
                //   child: Row(
                //     children: [
                //       IconButton(
                //           splashRadius: 20,
                //           onPressed: () async {
                //             AppPermission()
                //                 .permissionAccessGalleryMultiplesImagesNewRecipe(
                //                     await Permission.storage.request(),
                //                     context);
                //           },
                //           icon: SvgPicture.asset('assets/svg/gallery.svg')),
                //       // IconButton(
                //       //     splashRadius: 20,
                //       //     onPressed: () async {
                //       //       AppPermission()
                //       //           .permissionAccessGalleryOrCameraForNewRecipe(
                //       //               await Permission.camera.request(),
                //       //               context,
                //       //               ImageSource.camera);
                //       //     },
                //       //     icon: SvgPicture.asset('assets/svg/camera.svg')),
                //     ],
                //   ),
                // ),

                //decription
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFieldCustom(
                    controller: _titleController,
                    hintText: 'Tên món ăn',
                  ),
                ),
                //decription
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFieldCustom(
                    controller: _descriptionController,
                    hintText: 'Mô tả về món ăn',
                  ),
                ),
                //decription
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFieldCustom(
                    controller: _categoryController,
                    hintText: 'Thể loại món ăn',
                  ),
                ), //decription
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFieldCustom(
                    controller: _totalPeopleController,
                    hintText: 'Khẩu phần ăn',
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFieldCustom(
                    controller: _timeController,
                    hintText: 'Thời gian nấu',
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFieldCustom(
                    controller: _caloriesController,
                    hintText: 'Số calo',
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Form(
                      key: _formKeyI,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: Text('Nguyên liệu',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -1.2,
                                    color: Colors.black54)),
                          ),
                          const Divider(thickness: 1),
                          const SizedBox(height: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < _itemIngredients.length; i++)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Center(
                                            child: Text(
                                          "${i + 1}.",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ))),
                                    Expanded(
                                      flex: 8,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: TextFormField(
                                          maxLines: null,
                                          controller: _itemIngredients[i],
                                          validator: (value) {
                                            if (value == "") {
                                              return "Please Enter Ingredient";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            hintText: ('Nguyên liệu'),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                color: ColorsCustom.primary
                                                    .withOpacity(0.3),
                                                width: 2,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                color: ColorsCustom.primary
                                                    .withOpacity(0.3),
                                                width: 2,
                                              ),
                                            ),
                                            hintStyle: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () {
                                          _removeItemIngredients(i);
                                        },
                                        child: const Icon(Icons.remove),
                                      ),
                                    )
                                  ],
                                ),
                            ],
                          ),
                          Center(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _addFieldIngredients();
                              },
                              icon: const Icon(
                                Icons.add,
                                color: kPrimaryLabelColor,
                              ),
                              label: Text('Thêm', style: kHeadlineLabelStyle),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.white,
                                ),
                                side: MaterialStateProperty.all(
                                  const BorderSide(
                                      color: ColorsCustom.primary, width: 2),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Form(
                      key: _formKeyS,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: Text('Bước làm',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -1.2,
                                    color: Colors.black54)),
                          ),
                          const Divider(thickness: 1),
                          const SizedBox(height: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < _itemSteps.length; i++)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Center(
                                            child: Text(
                                          "${i + 1}.",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ))),

                                    Expanded(
                                      flex: 8,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: TextFormField(
                                          controller: _itemSteps[i],
                                          validator: (value) {
                                            if (value == "") {
                                              return "Please Enter item Name";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            hintText: ('Bước làm'),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                color: ColorsCustom.primary
                                                    .withOpacity(0.3),
                                                width: 2,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                color: ColorsCustom.primary
                                                    .withOpacity(0.3),
                                                width: 2,
                                              ),
                                            ),
                                            hintStyle: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () {
                                          _removeItemFieldSteps(i);
                                        },
                                        child: const Icon(Icons.remove),
                                      ),
                                    )
                                    // Divider(
                                    //   height: 1,
                                    //   thickness: 1,
                                    // ),
                                  ],
                                ),
                            ],
                          ),
                          Center(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _addFieldSteps();
                              },
                              icon: const Icon(
                                Icons.add,
                                color: kPrimaryLabelColor,
                              ),
                              label: Text('Thêm', style: kHeadlineLabelStyle),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.white,
                                ),
                                side: MaterialStateProperty.all(
                                  const BorderSide(
                                      color: ColorsCustom.primary, width: 2),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _addRecipe(),
                  ],
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget _addRecipe() {
    final recipeBloc = BlocProvider.of<RecipeBloc>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: BlocBuilder<RecipeBloc, RecipeState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) => TextButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    backgroundColor: ColorsCustom.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0))),
                onPressed: () {
                  if (_keyForm.currentState!.validate()) {
                    // if(state.imageFileSelectedRecipe != null){
                    recipeBloc.add(
                      OnAddNewRecipeEvent(
                        _titleController.text.trim(),
                        _descriptionController.text.trim(),
                        _categoryController.text.trim(),
                        _totalPeopleController.text.trim(),
                        _timeController.text.trim().toString(),
                        _caloriesController.text.trim().toString(),
                        _itemIngredients,
                        _itemSteps,
                      ),
                    );
                    // } else {
                    //   modalWarning(context, 'Không có ảnh nào được chọn.!!!');
                    // }
                  }
                },
                child: const TextCustom(
                  text: 'Tạo công thức',
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: .7,
                )),
          ),
        )
      ],
    );
  }
}

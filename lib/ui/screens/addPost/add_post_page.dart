import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:recipes/domain/blocs/post/post_bloc.dart';
import 'package:recipes/domain/blocs/user/user_bloc.dart';
import 'package:recipes/ui/helpers/animation_route.dart';
import 'package:recipes/ui/helpers/error_message.dart';
import 'package:recipes/ui/helpers/modal_loading.dart';
import 'package:recipes/ui/helpers/modal_success.dart';
import 'package:recipes/ui/helpers/modal_warning.dart';
import 'package:recipes/ui/themes/colors_theme.dart';
import 'package:recipes/ui/widgets/widgets.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  late TextEditingController _descriptionController;
  late TextEditingController decriptionController;
  late TextEditingController titleController;
  late TextEditingController categoryController;
  late TextEditingController totalPeopleController;
  late TextEditingController timeController;
  late TextEditingController caloriesController;

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
    _descriptionController = TextEditingController();
    decriptionController = TextEditingController();
    titleController = TextEditingController();
    categoryController = TextEditingController();
    totalPeopleController = TextEditingController();
    timeController = TextEditingController();
    caloriesController = TextEditingController();
  }

  @override
  void dispose() {
    decriptionController.dispose();
    titleController.dispose();
    categoryController.dispose();
    totalPeopleController.dispose();
    timeController.dispose();
    caloriesController.dispose();
    _descriptionController.dispose();
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
    final userBloc = BlocProvider.of<UserBloc>(context).state;
    final postBloc = BlocProvider.of<PostBloc>(context);
    final size = MediaQuery.of(context).size;

    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state is LoadingPost) {
          modalLoading(context, 'Tạo bài...');
        } else if (state is FailurePost) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessPost) {
          Navigator.pop(context);
          modalSuccess(context, 'Tạo bài viết thành công.!!',
              onPressed: () => Navigator.pushAndRemoveUntil(context,
                  routeSlide(page: const BottomNavigation()), (_) => false));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Form(
          key: _keyForm,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _appBarPost(),
                //decription
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFieldCustom(
                    controller: titleController,
                    hintText: 'Tên món ăn',
                  ),
                ),
                //decription
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFieldCustom(
                    controller: decriptionController,
                    hintText: 'Mô tả về món ăn',
                  ),
                ),
                //decription
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFieldCustom(
                    controller: categoryController,
                    hintText: 'Thể loại món ăn',
                  ),
                ), //decription
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFieldCustom(
                    controller: totalPeopleController,
                    hintText: 'Khẩu phần ăn',
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFieldCustom(
                    controller: timeController,
                    hintText: 'Thời gian nấu',
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFieldCustom(
                    controller: caloriesController,
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
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Thêm',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorsCustom.primary),
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
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Thêm',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorsCustom.primary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget _appBarPost() {
    final postBloc = BlocProvider.of<PostBloc>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BlocBuilder<PostBloc, PostState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) => TextButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  backgroundColor: ColorsCustom.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0))),
              onPressed: () {
                if (_keyForm.currentState!.validate()) {
                  if (state.imageFileSelected != null) {
                    postBloc.add(
                        OnAddNewPostEvent(_descriptionController.text.trim()));
                  } else {
                    modalWarning(context, 'Không có ảnh nào được chọn.!!!');
                  }
                }
              },
              child: const TextCustom(
                text: 'Tạo công thức',
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: .7,
              )),
        )
      ],
    );
  }
}

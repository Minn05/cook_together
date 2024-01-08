// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:recipes/data/env/env.dart';
import 'package:recipes/data/storage/secure_storage.dart';
import 'package:recipes/domain/models/response/default_response.dart';
import 'package:recipes/domain/models/response/response_comments.dart';
import 'package:recipes/domain/models/response/response_recipe.dart';
import 'package:recipes/domain/models/response/response_recipe_by_user.dart';
import 'package:recipes/domain/models/response/response_recipe_saved.dart';

class Test {
  List<String> ingredients;
  List<String> steps;
  Test({
    required this.ingredients,
    required this.steps,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ingredients': ingredients,
      'steps': steps,
    };
  }

  String toJson() => json.encode(toMap());
}

class RecipeServices {
  Future<DefaultResponse> addNewRecipe(
      String recipeTitle,
      String recipeDescription,
      String recipeTotalPeople,
      String recipeTime,
      String recipeCategory,
      String recipeCalories,
      List<TextEditingController> recipeIngredients,
      List<TextEditingController> recipeSteps,
      List<File> images) async {
    final token = await secureStorage.readToken();

    var ingredients = recipeIngredients.map((e) => e.text.toString());
    var steps = recipeSteps.map((step) => step.text.toString());
    Test test = Test(ingredients: ingredients.toList(), steps: steps.toList());
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Environment.urlApi}/recipe/create-new-recipe'))
      ..headers['Accept'] = 'application/json'
      ..headers['xxx-token'] = token!
      ..fields['title'] = recipeTitle
      ..fields['description'] = recipeDescription
      ..fields['totalPeople'] = recipeTotalPeople
      ..fields['calories'] = recipeCalories
      ..fields['time'] = recipeTime
      ..fields['category'] = recipeCategory
      ..fields['ingreditents'] = jsonEncode(test);
    // ..fields['ingredients'] = recipeIngredient;

    for (var image in images) {
      request.files
          .add(await http.MultipartFile.fromPath('imageRecipes', image.path));
    }

    final response = await request.send();
    var data = await http.Response.fromStream(response);
    return DefaultResponse.fromJson(jsonDecode(data.body));
  }

  Future<List<Recipe>> getAllRecipeHome() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/recipe/get-all-recipes'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});

    return ResponseRecipe.fromJson(jsonDecode(resp.body)).recipes;
  }

  // Future<List<RecipeSchedule>> getAllRecipeSchedule() async {
  //   final token = await secureStorage.readToken();

  //   final resp = await http.get(
  //       Uri.parse('${Environment.urlApi}/recipe/get-recipes-schedule'),
  //       headers: {'Accept': 'application/json', 'xxx-token': token!});

  //   return ResponseRecipeSchedule.fromJson(jsonDecode(resp.body)).recipes;
  // }

  Future<ResponseRecipeDetail> getDetailRecipeById(String id) async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/recipe/get-recipe-by-id/' + id),
        headers: {'Accept': 'application/json', 'xxx-token': token!});

    return ResponseRecipeDetail.fromJson(jsonDecode(resp.body));
  }

  // Future<ResponseRecipeDetailMember> getMemberRecipeById(String id) async {
  //   final token = await secureStorage.readToken();

  //   final resp = await http.get(
  //       Uri.parse(
  //           '${Environment.urlApi}/recipe/get-members-recipe-by-id/' + id),
  //       headers: {'Accept': 'application/json', 'xxx-token': token!});

  //   return ResponseRecipeDetailMember.fromJson(jsonDecode(resp.body));
  // }

  Future<ResponseRecipeDetail> getDetailExtraRecipeById(String id) async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/recipe/get-recipe-by-id-extra/' + id),
        headers: {'Accept': 'application/json', 'xxx-token': token!});

    return ResponseRecipeDetail.fromJson(jsonDecode(resp.body));
  }

  // Future<List<RecipeProfile>> getRecipeProfiles() async {
  //   final token = await secureStorage.readToken();

  //   final resp = await http.get(
  //       Uri.parse('${Environment.urlApi}/recipe/get-recipe-by-idPerson'),
  //       headers: {'Accept': 'application/json', 'xxx-token': token!});

  //   return ResponseRecipeProfile.fromJson(jsonDecode(resp.body)).recipe;
  // }

  Future<DefaultResponse> saveRecipeByUser(
      String uidRecipe, String type) async {
    final token = await secureStorage.readToken();

    final resp = await http.post(
        Uri.parse('${Environment.urlApi}/recipe/save-recipe'),
        headers: {'Accept': 'application/json', 'xxx-token': token!},
        body: {'recipe_uid': uidRecipe, "type": type});

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  Future<DefaultResponse> joinRecipeByUser(
      String uidRecipe, String type) async {
    final token = await secureStorage.readToken();

    final resp = await http.post(
        Uri.parse('${Environment.urlApi}/recipe/join-recipe'),
        headers: {'Accept': 'application/json', 'xxx-token': token!},
        body: {'recipe_uid': uidRecipe, 'type': type});

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  Future<DefaultResponse> addRoleRecipeByUser(
      String uid, String recipeUid, String role) async {
    final token = await secureStorage.readToken();

    final resp = await http.post(
        Uri.parse('${Environment.urlApi}/recipe/add-role-user'),
        headers: {
          'Accept': 'application/json',
          'xxx-token': token!
        },
        body: {
          'recipe_member_uid': uid,
          'recipe_uid': recipeUid,
          'role': role
        });

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  Future<DefaultResponse> addCommentAndRateRecipeByUser(String uid,
      String recipeUid, String recipeComment, double recipeRate) async {
    final token = await secureStorage.readToken();
    final resp = await http
        .post(Uri.parse('${Environment.urlApi}/recipe/rate-recipe'), headers: {
      'Accept': 'application/json',
      'xxx-token': token!
    }, body: {
      'recipe_member_uid': uid,
      'recipe_uid': recipeUid,
      'recipe_rate': recipeRate,
      'recipe_comment': recipeComment
    });

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  Future<List<ListSavedRecipe>> getListRecipeSavedByUser() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/recipe/get-list-saved-recipes'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});

    return ResponseRecipeSaved.fromJson(jsonDecode(resp.body)).listSavedRecipe;
  }

  Future<List<Recipe>> getAllRecipesForSearch() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/recipe/get-all-recipes-for-search'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});

    return ResponseRecipe.fromJson(jsonDecode(resp.body)).recipes;
  }

  Future<DefaultResponse> likeOrUnlikeRecipe(
      String uidRecipe, String type) async {
    final token = await secureStorage.readToken();

    final resp = await http.post(
        Uri.parse('${Environment.urlApi}/recipe/like-or-unlike-recipe'),
        headers: {'Accept': 'application/json', 'xxx-token': token!},
        body: {'recipe_uid': uidRecipe, "type": type});

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  Future<List<Comment>> getCommentsByUidRecipe(String uidRecipe) async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
      Uri.parse(
          '${Environment.urlApi}/recipe/get-comments-by-idrecipe/' + uidRecipe),
      headers: {'Accept': 'application/json', 'xxx-token': token!},
    );

    return ResponseComments.fromJson(jsonDecode(resp.body)).comments;
  }

  Future<DefaultResponse> addNewComment(
      String uidRecipe, String comment) async {
    final token = await secureStorage.readToken();

    final resp = await http.post(
        Uri.parse('${Environment.urlApi}/recipe/add-new-comment'),
        headers: {'Accept': 'application/json', 'xxx-token': token!},
        body: {'uidRecipe': uidRecipe, 'comment': comment});

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  Future<DefaultResponse> likeOrUnlikeComment(String uidComment) async {
    final token = await secureStorage.readToken();

    final resp = await http.put(
        Uri.parse('${Environment.urlApi}/recipe/like-or-unlike-comment'),
        headers: {'Accept': 'application/json', 'xxx-token': token!},
        body: {'uidComment': uidComment});

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  Future<List<RecipeUser>> listRecipeByUser() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/recipe/get-all-recipe-by-user-id'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});

    return ResponseRecipeByUser.fromJson(jsonDecode(resp.body)).recipeUser;
  }
}

final recipeService = RecipeServices();

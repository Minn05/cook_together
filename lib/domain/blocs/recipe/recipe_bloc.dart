import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:recipes/domain/services/recipe_services.dart';
part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  List<File> listImages = [];

  RecipeBloc() : super(const RecipeState()) {
    // on<OnPrivacyRecipeEvent>(_onPrivacyRecipe);
    on<OnSelectedImageEventRecipe>(_onSelectedImage);
    on<OnClearSelectedImageEventRecipe>(_onClearSelectedImage);
    on<OnAddNewRecipeEvent>(_addNewRecipe);
    on<OnSaveRecipeByUser>(_saveRecipeByUser);
    on<OnJoinRecipe>(_joinRecipe);
    on<OnIsSearchRecipeEvent>(_isSearchRecipe);
    on<OnLikeOrUnLikeRecipe>(_likeOrUnlikeRecipe);
    on<OnAddNewCommentEvent>(_addNewComment);
    on<OnLikeOrUnlikeComment>(_likeOrUnlikeComment);
  }

  // Future<void> _onPrivacyRecipe( OnPrivacyRecipeEvent event, Emitter<RecipeState> emit ) async {
  //
  //   emit( state.copyWith( privacyRecipe: event.privacyRecipe ) );
  //
  // }

  Future<void> _onSelectedImage(
      OnSelectedImageEventRecipe event, Emitter<RecipeState> emit) async {
    listImages.add(event.imageSelected);

    emit(state.copyWith(imageFileSelectedRecipe: listImages));
  }

  Future<void> _onClearSelectedImage(
      OnClearSelectedImageEventRecipe event, Emitter<RecipeState> emit) async {
    listImages.removeAt(event.indexImage);

    emit(state.copyWith(imageFileSelectedRecipe: listImages));
  }

  Future<void> _addNewRecipe(
      OnAddNewRecipeEvent event, Emitter<RecipeState> emit) async {
    try {
      emit(LoadingRecipe());

      final data = await recipeService.addNewRecipe(
          event.recipeTitle,
          event.recipeDescription,
          event.recipeCategory,
          event.recipeTotalPeople,
          event.recipeTime,
          event.recipeCalories,
          event.recipeIngredients,
          event.recipeSteps,
          listImages);
      await Future.delayed(const Duration(milliseconds: 350));

      if (data.resp) {
        emit(SuccessRecipe());
        listImages.clear();
        emit(state.copyWith(imageFileSelectedRecipe: listImages));
      } else {
        emit(FailureRecipe(data.message));
      }
    } catch (e) {
      emit(FailureRecipe(e.toString()));
    }
  }

  Future<void> _saveRecipeByUser(
      OnSaveRecipeByUser event, Emitter<RecipeState> emit) async {
    try {
      emit(LoadingSaveRecipe());

      final data =
          await recipeService.saveRecipeByUser(event.idRecipe, event.type);

      if (data.resp) {
        emit(SuccessRecipe());
      } else {
        emit(FailureRecipe(data.message));
      }
    } catch (e) {
      emit(FailureRecipe(e.toString()));
    }
  }

  Future<void> _joinRecipe(
      OnJoinRecipe event, Emitter<RecipeState> emit) async {
    try {
      emit(LoadingSaveRecipe());

      final data =
          await recipeService.joinRecipeByUser(event.recipeId, event.type);

      if (data.resp) {
        emit(SuccessRecipe());
      } else {
        emit(FailureRecipe(data.message));
      }
    } catch (e) {
      emit(FailureRecipe(e.toString()));
    }
  }

  Future<void> _isSearchRecipe(
      OnIsSearchRecipeEvent event, Emitter<RecipeState> emit) async {
    emit(state.copyWith(isSearchFriend: event.isSearchFriend));
  }

  Future<void> _likeOrUnlikeRecipe(
      OnLikeOrUnLikeRecipe event, Emitter<RecipeState> emit) async {
    try {
      emit(LoadingRecipe());

      final data =
          await recipeService.likeOrUnlikeRecipe(event.uidRecipe, event.type);

      if (data.resp) {
        emit(SuccessRecipe());
      } else {
        emit(FailureRecipe(data.message));
      }
    } catch (e) {
      emit(FailureRecipe(e.toString()));
    }
  }

  Future<void> _addNewComment(
      OnAddNewCommentEvent event, Emitter<RecipeState> emit) async {
    try {
      emit(LoadingRecipe());

      final data =
          await recipeService.addNewComment(event.uidRecipe, event.comment);

      if (data.resp) {
        emit(SuccessRecipe());
      } else {
        emit(FailureRecipe(data.message));
      }
    } catch (e) {
      emit(FailureRecipe(e.toString()));
    }
  }

  Future<void> _likeOrUnlikeComment(
      OnLikeOrUnlikeComment event, Emitter<RecipeState> emit) async {
    try {
      emit(LoadingRecipe());

      final data = await recipeService.likeOrUnlikeComment(event.uidComment);

      if (data.resp) {
        emit(SuccessRecipe());
      } else {
        emit(FailureRecipe(data.message));
      }
    } catch (e) {
      emit(FailureRecipe(e.toString()));
    }
  }
}

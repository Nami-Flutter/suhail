abstract class CategoryStates {}

class CategoryInitState extends CategoryStates {}

class CategoryLoadingState extends CategoryStates {}

class CategoryErrorState extends CategoryStates {
  String? error;
  CategoryErrorState(this.error);
}
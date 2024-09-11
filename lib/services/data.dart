

import 'package:newsapp/models/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> category = [];
  CategoryModel categoryModel = CategoryModel();
  categoryModel.categoryName = "All";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Sports";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Politics";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Business";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Health";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Travel";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Science";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  return category;
}

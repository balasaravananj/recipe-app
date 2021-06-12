import 'package:flutter/material.dart';
import 'package:meals_app/meal_item.dart';

import './dummy_data.dart';
import 'models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {

  static const routeName ='/category-meals';
  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _categoryMealsScreenState createState() => _categoryMealsScreenState();
}

class _categoryMealsScreenState extends State<CategoryMealsScreen> {

  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadedInitData=false;

  @override
  void didChangeDependencies() {
    if(!_loadedInitData) {
      final routeArgs = ModalRoute
          .of(context)
          .settings
          .arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

 void _removeMeal(String mealId){
   setState(() {
     displayedMeals.removeWhere((meal) => meal.id==mealId);
   });
 }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle,
      style: Theme.of(context).textTheme.title,),),
      body:ListView.builder(
          itemBuilder: (context,index){
        return  MealItem(
            id: displayedMeals[index].id,
            complexity: displayedMeals[index].complexity,
            title: displayedMeals[index].title,
            duration: displayedMeals[index].duration,
            imageUrl: displayedMeals[index].imageUrl,
            affordability: displayedMeals[index].affordability,
        ) ;
      },
      itemCount: displayedMeals.length ,),
    );
  }
}

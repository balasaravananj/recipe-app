import 'package:flutter/material.dart';
import 'package:meals_app/category_meals_screen.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/filters_screen.dart';
import 'package:meals_app/meal_detail_screen.dart';
import 'package:meals_app/tabs_screen.dart';

import 'categories_screen.dart';
import 'models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String,bool> _filters ={
    'glutenFree':false,
    'lactoseFree':false,
    'vegan':false,
    'vegetarian':false,
  };

  void _setFilters(Map<String,bool> filterData){
    setState(() {
      _filters=filterData;
      _availableMeals=DUMMY_MEALS.where((meal){
        if(_filters['glutenFree'] && !meal.isGlutenFree){
          return false;
        }
        if(_filters['lactoseFree'] && !meal.isLactoseFree){
          return false;
        }
        if(_filters['vegan'] && !meal.isVegan){
          return false;
        }
        if(_filters['vegetarian'] && !meal.isVegetarian){
          return false;
        }
        return true;
      }).toList();
    });
  }

  List<Meal> _availableMeals = DUMMY_MEALS;

  List<Meal> _favouritesMeals = [];

  void _showFavourites(String mealId){

    final existingIndex=
    _favouritesMeals.indexWhere((meal) => mealId == meal.id);
    if(existingIndex==-1){
      setState(() {
        final meal =DUMMY_MEALS.firstWhere((meal) => meal.id==mealId);
        _favouritesMeals.add(meal);
      });
    }
    else{
      setState(() {
        _favouritesMeals.removeAt(existingIndex);
      });
    }
  }

  bool _isMealFavourite(String id){
    return _favouritesMeals.any((meal) => meal.id==id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229,1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1),),
            body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1),),
            title: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoCondensed')
          )
         ),
      initialRoute: '/',
      routes: {
        '/':(context)=> TabsScreen(_favouritesMeals),
       CategoryMealsScreen.routeName:(context)=> CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(_showFavourites,_isMealFavourite),
        FiltersScreen.routeName: (context) => FiltersScreen(_setFilters,_filters),
      },
      onUnknownRoute: (settings){
        return MaterialPageRoute(builder: (ctx)=> CategoriesScreen());
      },
    );
  }
}

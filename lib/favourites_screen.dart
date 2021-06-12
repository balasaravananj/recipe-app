import 'package:flutter/material.dart';

import 'meal_item.dart';
import 'models/meal.dart';

class FavouritesScreen extends StatelessWidget {

  final List<Meal> favouriteMeals;
  FavouritesScreen(this.favouriteMeals);

  @override
  Widget build(BuildContext context) {

    if(favouriteMeals.isEmpty){
      return Center(
        child: Text('Nothing to show here!'),
      );
    }
    else{
     return ListView.builder(
        itemBuilder: (context,index){
          return  MealItem(
            id: favouriteMeals[index].id,
            complexity: favouriteMeals[index].complexity,
            title: favouriteMeals[index].title,
            duration: favouriteMeals[index].duration,
            imageUrl: favouriteMeals[index].imageUrl,
            affordability: favouriteMeals[index].affordability,
          ) ;
        },
        itemCount: favouriteMeals.length ,);
    }

  }
}

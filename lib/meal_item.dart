import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/meal_detail_screen.dart';
import 'package:meals_app/models/meal.dart';

class MealItem extends StatelessWidget {

  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  // final List<String> ingredients;
  // final List<String> steps;
  // final bool isGlutenFree;
  // final bool isLactoseFree;
  // final bool isVegan;
  // final bool isVegetarian;

  MealItem({
    @required this.id,
    @required this.complexity,
    @required  this.title,
    @required  this.duration,
    @required this.imageUrl,
    @required  this.affordability,
    // @required this.ingredients,
    // @required this.steps,
    // @required this.isVegetarian,
    // @required this.isVegan,
    // @required this.isLactoseFree,
    // @required this.isGlutenFree
});

  void selectMeal(BuildContext context){
    Navigator.of(context).pushNamed(
      MealDetailScreen.routeName,
      arguments:id,)
        .then((result) => {
          if(result!=null){
            //removeItem(result)
          }
    });
  }

  String get complexityText{
    switch(complexity){
      case Complexity.Simple:
        return 'Simple';
        break;
      case Complexity.Challenging:
        return 'Challenging';
        break;
      case Complexity.Hard:
        return 'Hard';
        break;
    }
  }
  String get affordabilityText{
    switch(affordability){
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Pricey:
        return 'Pricey';
        break;
      case Affordability.Luxurious:
        return 'Luxurious';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column( 
          children: [
             Stack(
               children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(
                      imageUrl,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover),
                  ),
                 Positioned(
                   bottom: 20,
                   right: 0,
                   child: Container(
                     width: 300,
                     color: Colors.black54,
                     padding: EdgeInsets.symmetric(
                       horizontal: 20,
                       vertical: 5,
                     ),
                     child: Text(title,style: TextStyle(
                       fontSize: 26,
                       color: Colors.white,),
                     softWrap: true,
                     overflow: TextOverflow.fade,),
                   ),
                 )
               ],
             ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule),
                      SizedBox(height: 10,),
                      Text('${duration} min'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.work),
                      SizedBox(height: 10,),
                      Text(complexityText),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.account_balance_wallet_rounded),
                      SizedBox(height: 10,),
                      Text(affordabilityText),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),

    );
  }
}

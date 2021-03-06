import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/meal.dart';

class MealDetailScreen extends StatelessWidget {

  final Function toggleFavourites;
  final Function isFavourite;

  MealDetailScreen(this.toggleFavourites,this.isFavourite);
  static const routeName ='/meal-detail';

  Widget buildContainer(Widget child){
    return  Container(
        decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius .circular(10),
    ),
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(10),
    height: 200,
    width: 300,
    child:child);
  }

  @override
  Widget build(BuildContext context) {

    final mealId=ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => mealId==meal.id);
    return Scaffold(
      appBar: AppBar(title: Text('${selectedMeal.title}',
      style: Theme.of(context).textTheme.title,),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(selectedMeal.imageUrl,
              fit: BoxFit.cover,),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text('Ingredients',style: Theme.of(context).textTheme.title,),
            ),
            buildContainer(ListView.builder(itemBuilder: (context,index){
              return Card(
                color: Theme.of(context).accentColor,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10,
                        vertical: 5),
                    child: Text(selectedMeal.ingredients[index])),
              );
            },
              itemCount: selectedMeal.ingredients.length,)
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text('Steps',style: Theme.of(context).textTheme.title,),
            ),
            SizedBox(
              height: 10,
            ),
            buildContainer(ListView.builder(itemBuilder: (context,index)=>
            Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    child: Text('${index+1}'),
                  ),
                  title: Text(selectedMeal.steps[index],),
                ),
                Divider(),
              ],
            ),
            itemCount: selectedMeal.steps.length,))
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.delete),
      //   onPressed: (){
      //     Navigator.of(context).pop(mealId);
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        child: isFavourite(mealId)?Icon(Icons.star):Icon(Icons.star_border),
        onPressed: ()=>toggleFavourites(mealId),
      ),
    );
  }
}

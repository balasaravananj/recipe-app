import 'package:flutter/material.dart';
import 'package:meals_app/categories_screen.dart';
import 'package:meals_app/favourites_screen.dart';
import 'package:meals_app/main_drawer.dart';

import 'models/meal.dart';

class TabsScreen extends StatefulWidget {

  final List<Meal> favouriteMeals;
  TabsScreen(this.favouriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String,Object>> _pages;
  int _selectedPageIndex=0;

   void _selectPage(int index){
    setState(() {
      _selectedPageIndex=index;
    });

  }
  void initState(){
    _pages =[
      {'pages':CategoriesScreen(),'title':'Categories'},
      {'pages':FavouritesScreen(widget.favouriteMeals),'title':'Your Favouries'}
    ];

  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
    // DefaultTabController(
    //   length: 2,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: Text('Meals'),
    //       bottom: TabBar(tabs: [
    //         Tab(icon: Icon(Icons.category),text: 'Categories',),
    //         Tab(icon: Icon(Icons.star),text: 'Favourites',)
    //       ],),
    //     ),
    //     body: TabBarView(children: [
    //       CategoriesScreen(),
    //      FavouritesScreen(),
    //     ],),
    //   ),
    // );
      Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedPageIndex]['title']),
        ),
        drawer: MainDrawer(),
        body: _pages[_selectedPageIndex]['pages'],
        bottomNavigationBar: BottomNavigationBar(
          onTap:_selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
               backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.category),
                title: Text('Categories')),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.star),
                title: Text('Favourites')),

          ],
        ),
      );
  }
}


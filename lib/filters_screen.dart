import 'package:flutter/material.dart';
import 'package:meals_app/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName= '/filters-screen';

  final Function setFilters;
  final Map<String,bool> filters;

  FiltersScreen(this.setFilters,this.filters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {

  bool _glutenFree=false;
  bool _lactoseFree=false;
  bool _vegan=false;
  bool _vegetarian =false;

  @override
  void initState(){
     _glutenFree=widget.filters['glutenFree'];
     _vegetarian=widget.filters['vegetarian'];
     _vegan=widget.filters['vegan'];
     _lactoseFree=widget.filters['lactoseFree'];
    super.initState();
  }




  Widget _buildSwitchTiles(String title,String description,bool value,Function updateVal){
    return  SwitchListTile(
        title: Text(title),
        value: value,
        subtitle: Text(description),
        onChanged:updateVal
         );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(title: Text('Your Filters'),
        actions: [
          IconButton(onPressed:(){
            final setFiltersData={
              'glutenFree':_glutenFree,
              'lactoseFree':_lactoseFree,
              'vegan':_vegan,
              'vegetarian':_vegetarian,
            };
            widget.setFilters(setFiltersData);} , icon: Icon(Icons.save))
        ],
      ),
      body:Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text('Adjust Your Meal Selection.',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
              child: ListView(
                children: [
                  _buildSwitchTiles('Gluten-Free!',
                      'Only include gluten-free meals',
                      _glutenFree,
                       (val) {
                        setState(() {
                          _glutenFree = val;
                        });
                      },),
                  _buildSwitchTiles('Vegetarian!',
                    'Only include vegetarian meals',
                    _vegetarian,
                        (val) {
                      setState(() {
                        _vegetarian = val;
                      });
                    },),
                  _buildSwitchTiles('Vegan!',
                    'Only include vegan meals',
                    _vegan,
                        (val) {
                      setState(() {
                        _vegan = val;
                      });
                    },),
                  _buildSwitchTiles('Lactose-Free!',
                    'Only include lactose-free meals',
                    _lactoseFree,
                        (val) {
                      setState(() {
                        _lactoseFree = val;
                      });
                    },),

                ],
              ))

        ],
      )
    );
  }
}

import 'package:canonflow/screen/item-basket.dart';
import 'package:canonflow/screen/student/addrecipe.dart';
import 'package:flutter/material.dart';

import "package:canonflow/class/recipe.dart" as recipe;


class Basket extends StatelessWidget {

  const Basket({ super.key });

  List<Widget> widRecipes() {
    List<Widget> temp = [];
    int i = 0;
    while (i < recipe.recipes.length) {
      Widget w = Container(
        // child: Text(recipe.recipes[i].name)
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          boxShadow: [
              BoxShadow(
              color: Color.fromRGBO(128, 128, 128, 0.5),
              spreadRadius: -6,
              blurRadius: 8,
              offset: const Offset(8, 7)
            )
          ]
        ),
        child: Card(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Column(
              children: [
                Text(
                  "${recipe.recipes[i].name} ${recipe.recipes[i].isSpicy ? "🔥" : "🧊"}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  width: 300,
                  height: 200,
                  alignment: Alignment(0, 0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(recipe.recipes[i].photo),
                      fit: BoxFit.cover
                    ),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                ),
                // Image.network(recipe.recipes[i].photo),
                const SizedBox(height: 12),
                Text(
                  recipe.recipes[i].category,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: const Color.fromARGB(255, 53, 72, 82)
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  recipe.recipes[i].desc,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          )
        )
      );
      temp.add(w);
      i++;
    }
    return temp;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: const Text("Basket"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Your Basket: "),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: widRecipes(),
            ),
            Divider(height: 10, color: Colors.transparent)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            "add.recipe"
          );

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const AddRecipe())
          // );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    ); 
  }

  Center oldBody(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("This is Basket"),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ItemBasket(1, 10))
              );
            },
            child: const Text("Item 1")
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ItemBasket(2, 14))
              );
            },
            child: const Text("Item 2")
          ),
        ],
      )
    );
  }

  // List<Widget> wi
}


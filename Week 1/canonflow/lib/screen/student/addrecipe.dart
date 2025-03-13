import 'package:flutter/material.dart';
import "package:canonflow/class/recipe.dart" as recipe;

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

    @override
    State<StatefulWidget> createState() {
      return _AddRecipeState();
    }
}

class _AddRecipeState extends State<AddRecipe> {

  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _recipeDescController = TextEditingController();
  final TextEditingController _recipePhotoController = TextEditingController();

  int _charLeft = 0;
  String _recipeCategory = "Indonesia";
  String _isSpicy = "Spicy";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _recipeNameController.text = "Your food name";
    // _recipeDescController.text = "Food Description";
    // _recipePhotoController.text = "Food Photo URL";

    _charLeft = 200 - _recipeDescController.text.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Add Recipe'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(12),
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Column(
            children: [
              Text(
                "Form add recipe",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 80),
              TextField(
                controller: _recipeNameController,
                decoration: InputDecoration(
                  hintText: "Food ...",
                  labelText: "Food name",
                  hintTextDirection: TextDirection.ltr,
                ),
                onChanged: (v) {},
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _recipePhotoController,
                decoration: InputDecoration(
                  hintText: "URL ...",
                  labelText: "Food Photo",
                  hintTextDirection: TextDirection.ltr,
                ),
                onChanged: (v) {},
                onSubmitted: (v) {
                  setState(() {
                    
                  });
                },
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _recipeDescController,
                decoration: InputDecoration(
                  hintText: "Recipe .....",
                  labelText: "Food Description",
                  hintTextDirection: TextDirection.ltr,
                ),
                onChanged: (v) {
                  setState(() {
                    _charLeft = 200 - v.length;
                  });
                },
                keyboardType: TextInputType.multiline,
                minLines: 4,
                maxLines: null,
                maxLength: 200,
              ),
              Text("Char left: $_charLeft"),
              const SizedBox(height: 20),
              // Image.network(_recipePhotoController.text),
              Container(
                width: 600,
                height: 400,
                alignment: Alignment(0, 0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(_recipePhotoController.text),
                    fit: BoxFit.cover
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),
              const SizedBox(height: 22),
              DropdownButton(
                items: const [
                  DropdownMenuItem(
                    value: "Indonesia",
                    child: Text("Indonesia")
                  ),
                  DropdownMenuItem(
                    value: "Japanese",
                    child: Text("Japanese")
                  ),
                  DropdownMenuItem(
                    value: "Korean",
                    child: Text("Korean")
                  ),
                ],
                value: _recipeCategory,
                onChanged: (v) {
                  setState(() {
                    _recipeCategory = v!;
                  });
                }
              ),
              const SizedBox(height: 16),
              DropdownButton(
                items: const [
                  DropdownMenuItem(
                    value: "Spicy",
                    child: Text("Spicy")
                  ),
                  DropdownMenuItem(
                    value: "Not Spicy",
                    child: Text("Not Spicy")
                  ),
                ],
                value: _isSpicy,
                onChanged: (v) {
                  setState(() {
                    _isSpicy = v!;
                  });
                }
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  recipe.recipes.add(
                    recipe.Recipe(
                      id: recipe.recipes[recipe.recipes.length - 1].id + 1, 
                      name: _recipeNameController.text, 
                      photo: _recipePhotoController.text, 
                      desc: _recipeDescController.text,
                      category: _recipeCategory,
                      isSpicy: (_isSpicy == "Spicy") ? true : false
                    )
                  );

                  // Dialog
                  showDialog<String>(
                    context: context, 
                    builder: (BuildContext context) => AlertDialog(
                      title: Text("Add new recipe"),
                      content: Text("Recipe successfully added"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pushNamed(context, "basket"), 
                          child: const Text("OK")
                        )
                      ],
                    )
                  );
                }, 
                child: const Text("Create")
              )
            ],
          ),
        )
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/category.dart';
import 'package:shopping_list_app/models/category_items.dart';
import 'package:shopping_list_app/models/grocery_items.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var _enteredName = '';
    var _enteredQuantity = 1;
    var _selectedCategory = categories[Categories.vegetables]!;

    void _saveItem(){
      if(_formKey.currentState!.validate()){
        _formKey.currentState!.save();
      Navigator.of(context).pop(
        GroceryItem(
          id: DateTime.now().toString(), 
          name: _enteredName, 
          quantity: _enteredQuantity, 
          category: _selectedCategory,
        ),
      );
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
              decoration: const InputDecoration(
                label: Text('Name'),
              ),
              validator: (value) {
                        if(
                          value == null || 
                          value.isEmpty || 
                          value.trim().length <= 1 || 
                          value.trim().length > 50
                        ){
                          return 'Must be 1 and 50 characters.';
                        }
                        return null;
                      },
                      onSaved: (value){
                        _enteredName = value!;
                      },
              ),
              
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: _enteredQuantity.toString(),
                      validator: (value) {
                        if(
                          value == null || 
                          value.isEmpty || 
                          int.tryParse(value) ==null 
                          || int.tryParse(value)! <=0
                        ){
                          return 'Must be a valid positive number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredQuantity = int.parse(value!);
                      } ,
                    ),
                  ),
                  const SizedBox(width: 8,),
                  
                  Expanded(
                    child:DropdownButtonFormField(
                      value: _selectedCategory,
                      items: [
                        for(final category in categories.entries)
                        DropdownMenuItem(
                          value: category.value,
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                color: category.value.color,
                              ),
                              const SizedBox(width: 16,),
                              Text(category.value.title),
                            ],
                          ),
                        ),
                      ], 
                      onChanged: (value){
                        setState(() {
                          _selectedCategory = value!;  
                        });
                      }
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12,),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: (){
                      _formKey.currentState!.reset();
                    }, 
                    child: const Text('Reset'),
                  ),

                  ElevatedButton(
                    onPressed: _saveItem, 
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';


class CategoryCard extends StatelessWidget {
  final Icon icon;
  final String name;

  CategoryCard(this.icon, this.name);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.lime,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5)]),
          width: 150,
          child: Column(
            children:<Widget> [
              icon,
              SizedBox(
                height: 10,
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

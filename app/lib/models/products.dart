import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String category;
  final String name;
  final String description;
  final String imgUrl;
  final double price;

  Product(
      {@required this.id,
      @required this.category,
      @required this.name,
      @required this.description,
      @required this.imgUrl,
      @required this.price});
}

class Products with ChangeNotifier {
  // ignore: unused_field
  List<Product> _items = [
     Product(
    id: '1',
    category: 'Diary products',
    name:'Lakspray Full Cream Milk Powder -1 KG',
    description: 'DOES THIS PRODUCT CONTAIN ANY PRESERVATIVES ?
    Lakspray Full Cream Milk Powder is made from 100% pure cow?',

    imgUrl:'https://www.kapruka.com/static/js/blank.png',
    price: 940,
    ),

    Product(
    id: '2',
    category: 'Grocery',
    name: 'Nelfarms Pack Of 10 Farm Fresh Eggs',
    description: 'ARE THESE FRESH EGGS?
    Yes, these are Farm Fresh eggs.
    HOW ARE NELFARMS FRESH EGGS MANUFACTURED?
    All our commercial farms only use chicks from our own breeder farm. With our fully integrated system from breeder flock to the packed eggs, there is complete traceability and accountability in terms of quality control. We use battery cage systems to house the birds. This technology ensures clean, safe and healthy eggs.',
    imgUrl:'https://www.kapruka.com/static/js/blank.png',
    price: 280,
    ),

    Product(
    id: '3',
    category: 'Grocery',
    name: 'Elephant House Chicken Meat Balls - 400g',
    description: 'HOW CAN THIS BE CONSUMED?
    It could be prepared as a curry, devilled or grilled and served with 
    many accompaniments such as Rice, Noodles, and String Hoppers etc.
    WHAT IS ELEPHANT HOUSE CHICKEN MEAT BALLS?
    Meat Balls are a hot favorite at meal time. Made with delicious chicken
    h herbs and spices, carefully packed to bring the best taste.',
    imgUrl: 'https://www.kapruka.com/static/js/blank.png',
    price:280,
    ),
    Product(
    id: '4',
    category: 'Vegetables and Fruits ',
    name: 'Bell Pepper Green - 500.00 g',
    description:'Bell peppers are rich in many vitamins and antioxidants, 
    especially vitamin C and various carotenoids. 
    For this reason, they may have several health benefits,
     such as improved eye health and reduced risk of several chronic diseases.',
    imgUrl: 'https://cargillsonline.com/VendorItems/MenuItems/VGE0223_1.png',
    price: 232.50,
    ),
    Product(
    id: '5',
    category:'Beverages',
    name:'Coca Cola - 1.50 l',
    description:'Coca Cola is the most popular and biggest 
    selling soft drink in history, as well as the best known brand in the world',
    imgUrl:'https://cargillsonline.com/VendorItems/MenuItems/BVE0011_1.png',
    price: 220.00,
    ),
    Product(
    id: '6',
    category:'Baby Products',
    name: 'Baby Cheramy Floral Baby Cream - 100.00 ml',
    description:'Baby Cheramy Cream is enriched with floral extracts,
      milk, and vitamin E to nourish and protect your baby’s delicate 
      skin with its rich moisturizing goodness.',
    imgUrl:'https://cargillsonline.com/VendorItems/MenuItems/BP50730_1.png',
    price: 148.00,
    ),
    Product(
    id: '7',
    category: 'Household',
    name: 'Vim Anti Smell Liquid Dishwash - 500.00 ml',
    description: 'The anti-smell product removes 5 tough Smells such as fish, 
    eggs, chicken, onions and Garlic from melamine, glass, plastic, stainless
      steel substrates. The power of ingredients such as Lemon and Mint eradicates
      tough smells and provides a refreshing wash experience. This formula does 
      not scratch kitchenware and provides great value for money',
    imgUrl: 'https://cargillsonline.com/VendorItems/MenuItems/HHE0188_1.png',
    price: 230.00,
    ),
  ];
  List<Product> get items{
    return [..._items];
  }
}

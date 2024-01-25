import 'package:flutter/material.dart';

import 'package:kivi_app/models/category.dart';
import 'package:kivi_app/models/lesson.dart';

// Constants in Dart should be written in lowerCamelcase.
const availableCategories = [
  Category(
    id: 'c1',
    title: 'Matematik',
    color: Colors.blue,
  ),
  Category(
    id: 'c2',
    title: 'Türk Dili ve Edebiyatı',
    color: Colors.red,
  ),
  Category(
    id: 'c3',
    title: 'Fizik',
    color: Colors.purple,
  ),
  Category(
    id: 'c4',
    title: 'Kimya',
    color: Colors.amber,
  ),
  Category(
    id: 'c5',
    title: 'Biyoloji',
    color: Colors.orange,
  ),
  Category(
    id: 'c6',
    title: 'Tarih',
    color: Colors.green,
  ),
];

const dummyMeals = [
  Ders(
    id: 'm1',
    categories: [
      'c1',
    ],
    title: 'Türev Çözümlü Sorular',
    complexity: Complexity.hard,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/Math-icon-rounded.svg/640px-Math-icon-rounded.svg.png',
    duration: 20,
    sorular: [
      '1. Soru : f(x) = 6x² + x - 1 eğrisine x = 3 apsisli noktada teğet olan doğrunun eğimi kaçtır ?',
      '2. Soru : f(x) = x³ + 4x² - 1 eğrisine üzerindeki  x = -2 apsisli noktasından çizilen teğetin eğimi kaçtır ?',
      '3. Soru : f(x) = x² fonksiyonuna x = 2 apsisli noktada teğet olan doğrunun eğimi kaçtır ?',
      '4. Soru : f(2x - 1) = 3x² - 2x + 1 olduğuna göre, f(-7) kaçtır?',
      '5. Soru : f(x) = x⁴ + 3x²g(x) = x + 2 olduğuna göre, (fog)(-3) kaçtır ?',
      '6. Soru : f(x) = 3x - 1 ve g(x) = x² + 1 olduğuna göre, (fog)(x) nedir ?',
      '7. Soru : f(x) = (x + a)⁴ f(x) = 32 olduğuna göre, a kaçtır ?',
      '8. Soru : f(x) = (x³ + x + 1)³ olduğuna göre, f(-1) kaçtır ?',
      '9. Soru : f(x) = (x + 1)⁴ olduğuna göre, f(x) nedir ?',
      '10. Soru : f(x) = (x³ - 3) * (x² + x + 1) olduğuna göre, f(1) kaçtır ?'
    ],
    cevaplar: [
      '1. Soru : 6*2x + 1 (Burada x gördüğümüz yere 3 yazacağız) 6 * 2 * 3 + 1 =36 + 1 =37 olacaktır cevap.',
      '2. Soru : 3x² + 8x (Burada x gördüğümüz yere -2 yazacağız.) 3 * (-2)² + 8 * (-2) =3 * 4 -16 =12 - 16 =-4 olacaktır cevap.',
      '3. Soru : 2*x  (x gördüğümüz yere 2 yazacağız.) 2*2 =4 olacaktır cevap.',
      '4. Soru : f(2x - 1)  * 2 = 6x - 2f(-7) * 2 = -20f(-7) = -10 olacaktır cevap.',
      '5. Soru : (x + 2)⁴ + 3 * (x + 2)²4.(x + 2)³ + 6 * (x + 2)-4 + ( -6 ) =-10 olacaktır cevap.',
      '6. Soru : 3 * (2x) = 6x olacaktır cevap.',
      '7. Soru : 4 * (x + a)³ 4 * (-1 + a)³ = 32(a - 1)³ = 8(a - 1)³ = 2³a - 1 = 2a = 3 olacaktır cevap.',
      '8. Soru : f(x) = 3 * (x³ + x + 1)² * (3x² + 1) 3 * (-1 -1 + 1)² * (3 + 1)3 * 4 =12 olacaktır cevap.',
      '9. Soru : 4 * (x + 1)³ olacaktır cevap.',
      '10. Soru : x⁵ + x⁴ + x³ -3x² - 3x - 3 5x⁴ + 4x³ + 3x² - 6x - 35 + 4 + 3 - 6 - 3 =3 olacaktır cevap.'
    ],
    isGlutenFree: false,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
  ),
  Ders(
    id: 'm2',
    categories: [
      'c1',
    ],
    title: 'İntegral Çözümlü Sorular',
    complexity: Complexity.simple,
    imageUrl:
        'https://www.matematiktutkusu.com/forum/ekstra/matimage/integraldegisken11.png',
    duration: 10,
    sorular: [
      '1. Soru : ∫(2x+1)7dx ifadesinin eşiti nedir?',
      '2. Soru : ∫(2x-3)/√x²-3x+1 dx ifadesinin eşiti nedir?',
      '3. Soru :  ∫√x7+x4 dx ifadesinin eşiti nedir?',
      '4. Soru :  ∫sin(lnx)/2x dx ifadesini eşiti nedir?',
      '5. Soru :  ∫sin²xd(cotx) integralinin eşiti nedir?',
      '6. Soru :  ∫sin2x/(3+cos²x)dx integralinin eşiti nedir?',
    ],
    cevaplar: [
      '1. Soru : 2x+1=u diyelim bu ifadenin türevi 2 dir o zaman ifadeyi 2.dx=du dersek dx=du/2 oluro zaman yeni ifadem ∫u7du/2 olur buda 1/2(u8/8)du+C burada da u yerine (2x+1) yazarsak sonucu buluruz',
      '2. Soru : x²-3x+1=u diyelim ifadenin türevi (2x-3) olur (2x-3)dx=du yeni ifademiz ∫du/√u=∫u-1/2 du=u1/2/1/2+c dir',
      '3. Soru : ifadeyi x⁴ parantezine alırsak ∫x²√x³+1 olur x³+1=u diyelim ifadenin türevi 3x²dx=du olur x²dx=du/3 yazarsak ifademiz ∫du/3.√u olur buradan 1/3.u-3/3+C gelir u yerine x³+1',
      '4. Soru : lnxdx=u diyelim ifadenin türevini alırsak 1/xdx=du olur o zaman ifadem 1/2∫sinudu şekline döner bu ifade de -1/2.cos(lnx)dx olur',
      '5. Soru : cotx=u diyelim dik üçgen çizersek sinx in de 1/√1+u² ifadesine eşit olduğunu görürüz. o zaman integralimiz.∫1/(u²+1)du olur o zaman işlemimiz arctanu+c olur u yerine cotx yazın',
      '6. Soru : 3+cos²x=u olsun du=-2cosxsinx=-sinx o zaman sonucum -ln|3+cos²x|+c'
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
  ),
  Ders(
    id: 'm3',
    categories: [
      'c2',
      'c3',
    ],
    title: 'Classic Hamburger',
    complexity: Complexity.simple,
    imageUrl:
        'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg',
    duration: 45,
    sorular: [
      '300g Cattle Hack',
      '1 Tomato',
      '1 Cucumber',
      '1 Onion',
      'Ketchup',
      '2 Burger Buns'
    ],
    cevaplar: [
      'Form 2 patties',
      'Fry the patties for c. 4 minutes on each side',
      'Quickly fry the buns for c. 1 minute on each side',
      'Bruch buns with ketchup',
      'Serve burger with tomato, cucumber and onion'
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
  ),
  Ders(
    id: 'm4',
    categories: [
      'c4',
    ],
    title: 'Wiener Schnitzel',
    complexity: Complexity.challenging,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/03/31/19/29/schnitzel-3279045_1280.jpg',
    duration: 60,
    sorular: [
      '8 Veal Cutlets',
      '4 Eggs',
      '200g Bread Crumbs',
      '100g Flour',
      '300ml Butter',
      '100g Vegetable Oil',
      'Salt',
      'Lemon Slices'
    ],
    cevaplar: [
      'Tenderize the veal to about 2–4mm, and salt on both sides.',
      'On a flat plate, stir the eggs briefly with a fork.',
      'Lightly coat the cutlets in flour then dip into the egg, and finally, coat in breadcrumbs.',
      'Heat the butter and oil in a large pan (allow the fat to get very hot) and fry the schnitzels until golden brown on both sides.',
      'Make sure to toss the pan regularly so that the schnitzels are surrounded by oil and the crumbing becomes ‘fluffy’.',
      'Remove, and drain on kitchen paper. Fry the parsley in the remaining oil and drain.',
      'Place the schnitzels on awarmed plate and serve garnishedwith parsley and slices of lemon.'
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
  ),
  Ders(
    id: 'm5',
    categories: [
      'c2'
          'c5',
      'c10',
    ],
    title: 'Salad with Smoked Salmon',
    complexity: Complexity.simple,
    imageUrl:
        'https://cdn.pixabay.com/photo/2016/10/25/13/29/smoked-salmon-salad-1768890_1280.jpg',
    duration: 15,
    sorular: [
      'Arugula',
      'Lamb\'s Lettuce',
      'Parsley',
      'Fennel',
      '200g Smoked Salmon',
      'Mustard',
      'Balsamic Vinegar',
      'Olive Oil',
      'Salt and Pepper'
    ],
    cevaplar: [
      'Wash and cut salad and herbs',
      'Dice the salmon',
      'Process mustard, vinegar and olive oil into a dessing',
      'Prepare the salad',
      'Add salmon cubes and dressing'
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: true,
  ),
  Ders(
    id: 'm6',
    categories: [
      'c6',
      'c10',
    ],
    title: 'Delicious Orange Mousse',
    complexity: Complexity.hard,
    imageUrl:
        'https://cdn.pixabay.com/photo/2017/05/01/05/18/pastry-2274750_1280.jpg',
    duration: 240,
    sorular: [
      '4 Sheets of Gelatine',
      '150ml Orange Juice',
      '80g Sugar',
      '300g Yoghurt',
      '200g Cream',
      'Orange Peel',
    ],
    cevaplar: [
      'Dissolve gelatine in pot',
      'Add orange juice and sugar',
      'Take pot off the stove',
      'Add 2 tablespoons of yoghurt',
      'Stir gelatin under remaining yoghurt',
      'Cool everything down in the refrigerator',
      'Whip the cream and lift it under die orange mass',
      'Cool down again for at least 4 hours',
      'Serve with orange peel',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
  ),
  Ders(
    id: 'm7',
    categories: [
      'c7',
    ],
    title: 'Pancakes',
    complexity: Complexity.simple,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/07/10/21/23/pancake-3529653_1280.jpg',
    duration: 20,
    sorular: [
      '1 1/2 Cups all-purpose Flour',
      '3 1/2 Teaspoons Baking Powder',
      '1 Teaspoon Salt',
      '1 Tablespoon White Sugar',
      '1 1/4 cups Milk',
      '1 Egg',
      '3 Tablespoons Butter, melted',
    ],
    cevaplar: [
      'In a large bowl, sift together the flour, baking powder, salt and sugar.',
      'Make a well in the center and pour in the milk, egg and melted butter; mix until smooth.',
      'Heat a lightly oiled griddle or frying pan over medium high heat.',
      'Pour or scoop the batter onto the griddle, using approximately 1/4 cup for each pancake. Brown on both sides and serve hot.'
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
  ),
  Ders(
    id: 'm8',
    categories: [
      'c8',
    ],
    title: 'Creamy Indian Chicken Curry',
    complexity: Complexity.challenging,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/06/18/16/05/indian-food-3482749_1280.jpg',
    duration: 35,
    sorular: [
      '4 Chicken Breasts',
      '1 Onion',
      '2 Cloves of Garlic',
      '1 Piece of Ginger',
      '4 Tablespoons Almonds',
      '1 Teaspoon Cayenne Pepper',
      '500ml Coconut Milk',
    ],
    cevaplar: [
      'Slice and fry the chicken breast',
      'Process onion, garlic and ginger into paste and sauté everything',
      'Add spices and stir fry',
      'Add chicken breast + 250ml of water and cook everything for 10 minutes',
      'Add coconut milk',
      'Serve with rice'
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
  ),
  Ders(
    id: 'm9',
    categories: [
      'c9',
    ],
    title: 'Chocolate Souffle',
    complexity: Complexity.hard,
    imageUrl:
        'https://cdn.pixabay.com/photo/2014/08/07/21/07/souffle-412785_1280.jpg',
    duration: 45,
    sorular: [
      '1 Teaspoon melted Butter',
      '2 Tablespoons white Sugar',
      '2 Ounces 70% dark Chocolate, broken into pieces',
      '1 Tablespoon Butter',
      '1 Tablespoon all-purpose Flour',
      '4 1/3 tablespoons cold Milk',
      '1 Pinch Salt',
      '1 Pinch Cayenne Pepper',
      '1 Large Egg Yolk',
      '2 Large Egg Whites',
      '1 Pinch Cream of Tartar',
      '1 Tablespoon white Sugar',
    ],
    cevaplar: [
      'Preheat oven to 190°C. Line a rimmed baking sheet with parchment paper.',
      'Brush bottom and sides of 2 ramekins lightly with 1 teaspoon melted butter; cover bottom and sides right up to the rim.',
      'Add 1 tablespoon white sugar to ramekins. Rotate ramekins until sugar coats all surfaces.',
      'Place chocolate pieces in a metal mixing bowl.',
      'Place bowl over a pan of about 3 cups hot water over low heat.',
      'Melt 1 tablespoon butter in a skillet over medium heat. Sprinkle in flour. Whisk until flour is incorporated into butter and mixture thickens.',
      'Whisk in cold milk until mixture becomes smooth and thickens. Transfer mixture to bowl with melted chocolate.',
      'Add salt and cayenne pepper. Mix together thoroughly. Add egg yolk and mix to combine.',
      'Leave bowl above the hot (not simmering) water to keep chocolate warm while you whip the egg whites.',
      'Place 2 egg whites in a mixing bowl; add cream of tartar. Whisk until mixture begins to thicken and a drizzle from the whisk stays on the surface about 1 second before disappearing into the mix.',
      'Add 1/3 of sugar and whisk in. Whisk in a bit more sugar about 15 seconds.',
      'whisk in the rest of the sugar. Continue whisking until mixture is about as thick as shaving cream and holds soft peaks, 3 to 5 minutes.',
      'Transfer a little less than half of egg whites to chocolate.',
      'Mix until egg whites are thoroughly incorporated into the chocolate.',
      'Add the rest of the egg whites; gently fold into the chocolate with a spatula, lifting from the bottom and folding over.',
      'Stop mixing after the egg white disappears. Divide mixture between 2 prepared ramekins. Place ramekins on prepared baking sheet.',
      'Bake in preheated oven until scuffles are puffed and have risen above the top of the rims, 12 to 15 minutes.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
  ),
  Ders(
    id: 'm10',
    categories: [
      'c2',
      'c5',
      'c10',
    ],
    title: 'Asparagus Salad with Cherry Tomatoes',
    complexity: Complexity.simple,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/04/09/18/26/asparagus-3304997_1280.jpg',
    duration: 30,
    sorular: [
      'White and Green Asparagus',
      '30g Pine Nuts',
      '300g Cherry Tomatoes',
      'Salad',
      'Salt, Pepper and Olive Oil'
    ],
    cevaplar: [
      'Wash, peel and cut the asparagus',
      'Cook in salted water',
      'Salt and pepper the asparagus',
      'Roast the pine nuts',
      'Halve the tomatoes',
      'Mix with asparagus, salad and dressing',
      'Serve with Baguette'
    ],
    isGlutenFree: true,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
  ),
];

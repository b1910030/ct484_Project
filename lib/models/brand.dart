class Category {
  final int id;
  final String name;
  final String imagePath;

  Category(this.id, this.name, this.imagePath);
}

List<Category> categories = [
  Category(0, 'All',"https://upload.wikimedia.org/wikipedia/commons/thumb/a/a6/Carolina_Herrera_AW14_12.jpg/330px-Carolina_Herrera_AW14_12.jpg"),
  Category(1, 'T-shirt','https://assets.adidas.com/images/w_383,h_383,f_auto,q_auto,fl_lossy,c_fill,g_auto/b07b9199372d46098266af9e0135aed6_9366/%C3%A1o-thun-adidas-adventure-nature-awakening.jpg'),
  Category(2, 'Pant','https://static.nike.com/a/images/f_auto/dpr_1.3,cs_srgb/h_540,c_limit/d94bfa7e-9357-406a-a124-1940712dfa0b/nike-just-do-it.png'),
  Category(3, 'Shoes','https://static.nike.com/a/images/f_auto/dpr_1.3,cs_srgb/h_540,c_limit/dc62b322-5c3f-4508-b21c-950683ed460f/nike-just-do-it.png'),
];
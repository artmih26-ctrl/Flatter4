import 'package:flutter/material.dart';

enum Category {
  laptops('Ноутбуки', Icons.laptop_mac, Color(0xff286650)),
  phones('Смартфоны', Icons.smartphone, Color(0xff315dab)),
  accessories('Аксессуары', Icons.headphones, Color(0xff81529d)),
  monitors('Мониторы', Icons.desktop_windows_outlined, Color(0xff19747d)),
  printers('Принтеры', Icons.print_outlined, Color(0xff985323)),
  gaming(
    'Игровые устройства',
    Icons.sports_esports_outlined,
    Color(0xff9c4262),
  );

  const Category(this.label, this.icon, this.color);
  final String label;
  final IconData icon;
  final Color color;
}

class Product {
  const Product(this.name, this.category, this.price, this.imageAsset);

  final String name;
  final Category category;
  final int price;
  final String imageAsset;

  String get priceLabel {
    final grouped = price.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (_) => '\u00a0',
    );
    return '$grouped ₽';
  }
}

const products = [
  Product('Lenovo IdeaPad 3', Category.laptops, 52990, 'images/ideapad.jpg'),
  Product('ASUS VivoBook 15', Category.laptops, 58990, 'images/vivobook.jpg'),
  Product('HP Pavilion 14', Category.laptops, 64990, 'images/pavilion.jpg'),
  Product('iPhone 16', Category.phones, 79990, 'images/iphone.jpg'),
  Product('Samsung Galaxy A55', Category.phones, 37990, 'images/galaxy.jpg'),
  Product('Xiaomi Redmi Note 13', Category.phones, 21990, 'images/redmi.jpg'),
  Product('Наушники JBL Tune', Category.accessories, 4990, 'images/jbl.jpg'),
  Product(
    'Клавиатура Logitech K380',
    Category.accessories,
    3990,
    'images/k380.jpg',
  ),
  Product('Мышь Logitech M185', Category.accessories, 1290, 'images/m185.jpg'),
  Product(
    'Dell UltraSharp U2723QE',
    Category.monitors,
    72990,
    'images/dell.jpg',
  ),
  Product(
    'LG UltraGear 27GN800',
    Category.monitors,
    29990,
    'images/ultragear.jpg',
  ),
  Product('BenQ GW2480', Category.monitors, 14990, 'images/benq.jpg'),
  Product('HP LaserJet M110w', Category.printers, 16990, 'images/laserjet.jpg'),
  Product('Canon PIXMA G3410', Category.printers, 19990, 'images/pixma.jpg'),
  Product('Epson EcoTank L3250', Category.printers, 22990, 'images/ecotank.jpg'),
  Product('Геймпад Xbox', Category.gaming, 6490, 'images/xbox.jpg'),
  Product('Руль Logitech G29', Category.gaming, 32990, 'images/g29.jpg'),
  Product(
    'Консоль Nintendo Switch',
    Category.gaming,
    28990,
    'images/switch.jpg',
  ),
];

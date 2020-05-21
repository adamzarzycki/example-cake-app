CREATE DATABASE IF NOT EXISTS products;

USE products;

CREATE TABLE IF NOT EXISTS `products` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci,
  `price` decimal(10,2) DEFAULT NULL,
  `currency` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `products` (`title`, `price`, `currency`) VALUES
('Fallout', '1.99', 'USD'),
('Don’t Starve', '2.99', 'USD'),
('Baldur’s Gate', '3.99', 'USD'),
('Icewind Dale', '4.99', 'USD'),
('Bloodborne', '5.99', 'USD');

CREATE TABLE IF NOT EXISTS `carts` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `cart_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

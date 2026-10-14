package com.shopsphere.model;
import java.io.Serializable; import java.math.BigDecimal;
public class Product implements Serializable {
 private static final long serialVersionUID=1L; private long productId; private String name,brand,description,imageUrl; private BigDecimal price,discount; private int stock;
 public Product(long id,String name,String brand,String description,BigDecimal price,BigDecimal discount,int stock,String imageUrl){this.productId=id;this.name=name;this.brand=brand;this.description=description;this.price=price;this.discount=discount;this.stock=stock;this.imageUrl=imageUrl;}
 public long getProductId(){return productId;} public String getName(){return name;} public String getBrand(){return brand;} public String getDescription(){return description;} public BigDecimal getPrice(){return price;} public BigDecimal getDiscount(){return discount;} public int getStock(){return stock;} public String getImageUrl(){return imageUrl;}
 public BigDecimal getSalePrice(){return price.multiply(BigDecimal.ONE.subtract(discount.divide(new BigDecimal("100")))).setScale(2,java.math.RoundingMode.HALF_UP);}
}

<?php 
   include_once "config.php";
   include_once "functions.php";

function get_temp_products(){
    return db_query("SELECT * FROM `temp_products`;")->fetchAll(); 
}

$number = $_GET['number'];

$temp_products = get_temp_products();
$temp_products = array_reverse($temp_products);


for ($i=0; $i < $number; $i++) { 
   $type = $temp_products[$i]['query'];
   $temp_id = $temp_products[$i]['id'];
   $idproducts = $temp_products[$i]['idproducts'];


   $product_name =  $temp_products[$i]['product_name'];
   $quantity =  $temp_products[$i]['quantity'];
   $purchase_price =   $temp_products[$i]['purchase_price'];
   $selling_price =   $temp_products[$i]['selling_price'];  
   $used =  $temp_products[$i]['used'];

      switch ($type) {
            case "insert":
               db()->query("DELETE FROM `products` WHERE idproducts = $idproducts");
               break;
            case "update":
               db()->query("UPDATE `products` SET 
                  product_name = '$product_name', 
                  quantity = '$quantity',
                  purchase_price =  '$purchase_price',
                  selling_price =  '$selling_price',
                  used = '$used'
               WHERE idproducts = $idproducts");
               break;
            case "delete":
               db()->query("INSERT INTO `products` SET 
                  product_name = '$product_name', 
                  quantity = '$quantity',
                  purchase_price =  '$purchase_price',
                  selling_price =  '$selling_price',
                  used = '$used'
               ");
               // $mysql->query("DELETE FROM temp_deletes where id = $temp_id");
      }

}

header('Location: /profile_ce.php');
die; 

// (temp_restore_employees($_GET['id']));




   


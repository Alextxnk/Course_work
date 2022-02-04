<?php
include_once "config.php";

function get_url($page = ''){
   return HOST . "/$page";
}

function db(){
   try {
      return new PDO("mysql:host=" . DB_HOST . "; dbname=" . DB_NAME . "; charset=utf8", DB_USER, DB_PASS, [
		PDO::ATTR_EMULATE_PREPARES => false,
		PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
		PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
	]);
   } catch(PDOException $e){
      die($e->getMessage());
   } 
}

function db_query($sql = '', $exec = false){
   if (empty($sql)) return false;

   if($exec){
      return db()->exec($sql);
   }

	return db()->query($sql);
}


function get_user_info($login) {
   if (empty($login)) return [];

   return db_query("SELECT * FROM users WHERE login = '$login';")->fetch();
}

function login($auth_data) {
   if (empty($auth_data) || !isset($auth_data['login']) || empty($auth_data['login']) || !isset($auth_data['password']) || empty($auth_data['password'])) {
      $_SESSION['error'] = "Логин или пароль не может быть пустым";
      header('Location: index.php');
		die;
   }

   $user = get_user_info($auth_data['login']);
   if(empty($user)) {
      $_SESSION['error'] = "Логин или пароль не верен";
      header('Location: index.php');
		die;
   }

   if(password_verify($auth_data['password'], $user['password'])) {
      
      $_SESSION['user'] = $user;
      if($_SESSION['user']['login'] == 'Alex'){
         header('Location: /profile_hr.php');
         die;
      }
      else if($_SESSION['user']['login'] == 'Max'){
         header('Location: /profile_ce.php');
         die;
      }
      else if($_SESSION['user']['login'] == 'Artem'){
         header('Location: /profile_seller.php');
         die;
      }
      else{
         echo "Не судьба!";
      }
   }
      else {
         $_SESSION['error'] = "Пароль не верен";
         header('Location: /index.php');
         die;
      }
}


function add_product($product_name, $quantity, $purchase_price, $selling_price) {
   return db_query("INSERT INTO `products` (`product_name`, `quantity`, `purchase_price`, `selling_price`) VALUES ('$product_name', '$quantity', '$purchase_price', '$selling_price');", true);

}

function delete_product($id) {
   if (empty($id)) return false;
   return db_query("DELETE FROM `products` WHERE `products`.`idproducts` = $id;", true);
}



function temp_restore_products($id) {
   db_query("CALL restore_products(".$temp_product['id'].");")->fetchAll();
   echo $result[0];
};


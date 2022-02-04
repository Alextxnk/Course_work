<?php 
   include_once "config.php";
   include_once "functions.php";
   if (!isset($_GET['idproducts']) || empty($_GET['idproducts'])) {
      header('Location: /profile_ce.php');
      die;
   }

delete_product($_GET['idproducts']);
$_SESSION['success'] = "Пользователь удален";
      header('Location: /profile_ce.php');
		die;

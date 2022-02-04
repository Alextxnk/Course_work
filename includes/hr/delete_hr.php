<?php 
   include_once "config.php";
   include_once "functions.php";
   if (!isset($_GET['idemployees']) || empty($_GET['idemployees'])) {
      header('Location: /profile_hr.php');
      die;
   }

delete_employee($_GET['idemployees']);
$_SESSION['success'] = "Пользователь удален";
      header('Location: /profile_hr.php');
		die;

<?php 
   include_once "config.php";
   include_once "functions.php";
   if (!isset($_GET['idposts']) || empty($_GET['idposts'])) {
      header('Location: /posts.php');
      die;
   }

delete_post($_GET['idposts']);
$_SESSION['success'] = "Должностсть удалена";
      header('Location: /posts.php');
		die;

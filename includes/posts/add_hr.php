<?php 
   include_once "config.php";
   include_once "functions.php";
 
(add_post($_POST['post_name'], $_POST['salary']));
header('Location: /posts.php');
die;

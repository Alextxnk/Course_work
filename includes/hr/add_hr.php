<?php 
   include_once "config.php";
   include_once "functions.php";
   // if (isset($_POST['name']) && !empty($_POST['name'])) {
   //    error_log(json_encode( $_POST ), 0);
      // if (add_employee($_POST['name'], $_POST['email'],  $_POST['phone'], $_POST['date'], $_POST['address'], $_POST['pasport'], $_POST['inn'])) {
      //    $_SESSION['success'] = 'Сотрудник успешно добавлен';
      // } else {
      //    $_SESSION['error'] = 'Во время добавления сотрудника что-то пошло не так';
      // }
   //}
(add_employee($_POST['name'], $_POST['pasport'],  $_POST['inn'],  $_POST['address'], $_POST['phone'], $_POST['email'], $_POST['posts_idposts'] ));
header('Location: /profile_hr.php');
die;

//  && isset($_POST['user_id']) && !empty($_POST['user_id'])

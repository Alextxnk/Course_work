<?php
$link = mysqli_connect(
'localhost',  /* Хост, к которому мы подключаемся */
'root',       /* Имя пользователя */
'',   /* Используемый пароль */
'furniture');     /* База данных для запросов по умолчанию */

if (!$link) {
   printf("Невозможно подключиться к базе данных. Код ошибки: %s\n", mysqli_connect_error());
   exit;
}

if (isset($_POST['name'])) {
   $column = $_POST['name'];
   
   if ($_POST['name'] == 'date') {
      $newValue = strtotime($_POST['value']);
        //echo $newValue;
   } else if ($_POST['name'] == 'address') {
        //var_dump($_POST); die;
      $newValue = $_POST['value']['city'] . ', ул. ' . $_POST['value']['street'] . ', дом. ' . $_POST['value']['building'];
   } else {
      $newValue = $_POST['value'];
   }
   $id = $_POST['pk'];
   $sql = "UPDATE `products` SET $column = '$newValue' where idproducts = $id";
   mysqli_query($link, $sql);
}

// if (isset($_POST['name'])) {
//     $column = $_POST['name'];

//     if ($_POST['name'] == 'date') {
//         $newValue = strtotime($_POST['value']);
//         //echo $newValue;
//     } else if ($_POST['name'] == 'address') {
//         //var_dump($_POST); die;
//         $newValue = $_POST['value']['city'] . ', ул. ' . $_POST['value']['street'] . ', дом. ' . $_POST['value']['building'];
//     } else {
//         $newValue = $_POST['value'];
//     }
//     $id = $_POST['pk'];
//     $sql = "UPDATE `employees` SET $column = '$newValue' where id = $id";
//     mysqli_query($link, $sql);
// }

// if (isset($_POST['post_name'])) {
//     $column = $_POST['post_name'];

//     if ($_POST['post_name'] == 'salary') {
//         $newValue = $_POST['value']['salary'];
//     } 
//     else {
//         $newValue = $_POST['value'];
//     }
//     $idposts = $_POST['pk'];
//     $sql = "UPDATE `posts` SET $column = '$newValue' where `posts`.`idposts` = $id";
//     mysqli_query($link, $sql);
// }
//UPDATE `posts` SET `post_name` = 'dxngdxg' WHERE `posts`.`idposts` = $id;

// function upd_post($post_name, $salary) {
//     $id = $_POST['pk'];
//     return db_query("UPDATE `posts` SET `post_name` = `$post_name`, `salary` = `$salary` WHERE idposts = $id;");
// }

// upd_post($_POST['post_name'], $_POST['salary']);
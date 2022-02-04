<?php 
   include_once "config.php";
   include_once "functions.php";

function get_temp_employees(){
    return db_query("SELECT * FROM `temp_employees`;")->fetchAll(); 
}

$number = $_GET['number'];

$temp_employees = get_temp_employees();
$temp_employees = array_reverse($temp_employees);


for ($i=0; $i < $number; $i++) { 
   $type = $temp_employees[$i]['query'];
   $temp_id = $temp_employees[$i]['id'];
   $idemployees = $temp_employees[$i]['idemployees'];


   $name =  $temp_employees[$i]['name'];
   $pasport =  $temp_employees[$i]['pasport'];
   $inn =   $temp_employees[$i]['inn'];
   $address =   $temp_employees[$i]['address'];  
   $phone =   $temp_employees[$i]['phone'];
   $email =  $temp_employees[$i]['email'];
   $posts_idposts =  $temp_employees[$i]['posts_idposts'];
   $used =  $temp_employees[$i]['used'];

      switch ($type) {
            case "insert":
               db()->query("DELETE FROM `employees` WHERE idemployees = $idemployees");
               break;
            case "update":
               db()->query("UPDATE `employees` SET 
                  name = '$name', 
                  pasport = '$pasport',
                  inn =  '$inn',
                  address =  '$address',
                  phone =  '$phone',
                  email = '$email',
                  posts_idposts = '$posts_idposts',
                  used = '$used'
               WHERE idemployees = $idemployees");
               break;
            case "delete":
               db()->query("INSERT INTO `employees` SET 
                  name = '$name', 
                  pasport = '$pasport',
                  inn =  '$inn',
                  address =  '$address',
                  phone =  '$phone',
                  email = '$email',
                  posts_idposts = '$posts_idposts',
                  used = '$used'
               ");
               // $mysql->query("DELETE FROM temp_deletes where id = $temp_id");
      }

}

header('Location: /profile_hr.php');
die; 

// (temp_restore_employees($_GET['id']));




   


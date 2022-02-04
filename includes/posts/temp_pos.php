<?php 
   include_once "config.php";
   include_once "functions.php";

function get_temp_posts(){
    return db_query("SELECT * FROM `temp_posts`;")->fetchAll(); 
}

$number = $_GET['number'];

$temp_posts = get_temp_posts();
$temp_posts = array_reverse($temp_posts);


for ($i=0; $i < $number; $i++) { 
   $type = $temp_posts[$i]['query'];
   $temp_id = $temp_posts[$i]['id'];
   $idposts = $temp_posts[$i]['idposts'];


   $post_name =  $temp_posts[$i]['post_name'];
   $salary =  $temp_posts[$i]['salary'];
   $used =  $temp_posts[$i]['used'];

      switch ($type) {
            case "insert":
               db()->query("DELETE FROM `posts` WHERE idposts = $idposts");
               break;
            case "update":
               db()->query("UPDATE `posts` SET 
                  post_name = '$post_name', 
                  salary = '$salary',
                  used = '$used'
               WHERE idposts = $idposts");
               break;
            case "delete":
               db()->query("INSERT INTO `posts` SET 
                  post_name = '$post_name', 
                  salary = '$salary',
                  used = '$used'
               ");
               // $mysql->query("DELETE FROM temp_deletes where id = $temp_id");
      }

}

header('Location: /posts.php');
die; 


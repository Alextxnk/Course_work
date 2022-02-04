<?php 
   include_once "includes/posts/header_pos.php"; 
   function get_temp_posts(){
    return db_query("SELECT * FROM `temp_posts`;")->fetchAll(); 
}
?>

<body>

<!-- 1020 1028 1140 -->


<div class="container" style="width: 720px;">
   <h3>Добавление новой должности</h3>
<form class="d-flex" action = "includes/posts/add_hr.php" method = "post">
   <table class="table">
      <thead>
            <tr>
               <th>Название должности</th>
               <th>Зарплата</th>
               <th>Добавление</th>
            </tr>
      </thead>
            <tr>
               <td><input class="form-control me-2" type ="text" placeholder = "Название должности" aria-label = "Название должности" name = "post_name"></td>
               <td><input class="form-control me-2" type ="text" placeholder = "ххххх.хх" aria-label = "Зарплата" name = "salary"></td>
               <td><input class="btn btn-outline-primary" type="submit"></input></td>
            </tr>
   </table>
</form>
</div>

<div class="container" style="width: 720px;"> 


<script>
   $.fn.editable.defaults.mode = 'popup';
   $(document).ready(function() {
      $('.people-editable').editable();
      $('.people-phone-editable').editable({
            type: 'text',
            tpl:'   <input type="text" class="form-control people-phone">'

      }).on('shown',function(){
            $("input.people-phone-editable").mask("(999) 999-9999");
      });
      $('.people-status-editable').editable({
            value: 'Активный',
            source: [
               {value: 'Активный', text: 'Активный'},
               {value: 'Заблокирован', text: 'Заблокирован'},
               {value: 'Устарел', text: 'Устарел'}
            ]
      });
      $('.people-date-editable').editable({
            format: 'dd.mm.yyyy',
            viewformat: 'dd.mm.yyyy',
            datepicker: {
               weekStart: 1
            }
      });

      $('.people-email-editable').editable({
            validate: function(value) {
               if(isEmail(value)) {

               } else {
                  return 'Введите настоящий e-mail';
               }
            }
            });

      $('.people-address-editable').editable({
            value: {
            }
      });
   });

   function isEmail(email) {
      var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
      return regex.test(email);
   }
</script>

<?php
$link = mysqli_connect(
   'localhost',
   'root',
   '',
   'furniture');

if (!$link) {
   printf("Невозможно подключиться к базе данных. Код ошибки: %s\n", mysqli_connect_error());
   exit;
}

echo '<h3 ">Таблица с должностями</h3>';

if ($result = mysqli_query($link, 'SELECT * FROM posts ORDER BY idposts')) {

   echo '<table class="table">
      <thead>
            <tr>
               <th>Название должности</th>
               <th>Зарплата</th>
               <th>Удаление</th>
            </tr>
      </thead>';

   while( $row = mysqli_fetch_assoc($result) ){
      echo '<tr>' .
            // '<td><a href="#" class="people-editable" data-name="idposts" data-type="text" data-title="id" data-pk="' . $row['idposts'] . '" data-url="ajax_posts.php" >' . $row['idposts'] . '</a></td>' .
            '<td><a href="#" class="people-editable" data-name="post_name" data-type="text" data-title="Название должности" data-pk="' . $row['idposts'] . '" data-url="ajax_posts.php" >' . $row['post_name'] . '</a></td>' .
            '<td><a href="#" class="people-editable" data-name="salary" data-type="text" data-title="Зарплата" data-pk="' . $row['idposts'] . '" data-url="ajax_posts.php" >' . $row['salary'] . '</a></td>' .
            
            '<td><a href="http://localhost1/includes/posts/delete_hr.php?idposts=' .$row['idposts']. '" class="btn btn-outline-danger btn-sm editable-delete"><i class="glyphicon glyphicon-trash"></i></a></td>'.
            '</tr>';
   }
   echo '</table>';
   mysqli_free_result($result);
}
mysqli_close($link);
?>

<h3>Темпаральная таблица</h3>

<table class="table">
   <thead>
      <tr>
      <th>id</th>
      <th>date</th>
      <th>query</th>
      <th>idposts</th>
      <th>Название должности</th>
      <th>Зарплата</th>
      <th>used</th>
      <th>Откат</th>
      </tr>
   </thead>
<?php 
   $temp_posts = get_temp_posts();
   $temp_posts = array_reverse($temp_posts);
   $PubIdx = 0;
   foreach($temp_posts as $key=> $temp_post) { 
      ++$PubIdx;
      ?>
		<tr>
				<td><?php echo $temp_post['id'] ?></td>
				<td><?php echo $temp_post['date'] ?></td>
            <td><?php echo $temp_post['query'] ?></td>
            <td><?php echo $temp_post['idposts'] ?></td>
            <td><?php echo $temp_post['post_name'] ?></td>
            <td><?php echo $temp_post['salary'] ?></td>
				<td><?php echo $temp_post['used'] ?></td>
            <td><a href=<?php echo "http://localhost1/includes/posts/temp_pos.php?number=".$PubIdx ?> class="btn btn-outline-primary btn-sm editable-submit"><i class="glyphicon glyphicon-ok"></i></a></td>
			</tr>
         
<?php } ?>

</table>

</div>
</body>
</html>
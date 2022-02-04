<?php 
   include_once "includes/hr/header_hr.php"; 

function get_temp_employees(){
    return db_query("SELECT * FROM `temp_employees`;")->fetchAll(); 
}
?>

<body>

<div class="container" style="width: 1320px;"> 

<h3>Экспорт/Импорт БД</h3>
<a href=<?php echo "http://localhost1/includes/hr/dumb.php"?> class="btn btn-outline-primary">Экспорт</a>
<a href=<?php echo "http://localhost1/includes/hr/loading.php"?> class="btn btn-outline-primary">Импорт</a>

<h3>Добавление нового сотрудника</h3>

<form class="d-flex" action = "includes/hr/add_hr.php" method = "post">
   <table class="table">
      <thead>
            <tr>
               <th>ФИО</th>
               <th>Паспорт</th>
               <th>ИНН</th>
               <th>Адрес</th>
               <th>Телефон</th>
               <th>E-mail</th>
               <th>Добавление</th>
            </tr>
      </thead>
            <tr>
               <td><input class="form-control me-2" type ="text" placeholder = "ФИО" aria-label = "ФИО" name = "name"></td>
               <td><input class="form-control me-2" type ="text" placeholder = "хххх хххххх" aria-label = "Паспорт" name = "pasport"></td>
               <td><input class="form-control me-2" type ="text" placeholder = "хххххххххххх" aria-label = "ИНН" name = "inn"></td>
               <td><input class="form-control me-2" type ="text" placeholder = "город, улица, дом" aria-label = "Адрес" name = "address"></td>
               <td><input class="form-control me-2" type ="text" placeholder = "8 (ххх) ххх-хххх" aria-label = "Телефон" name = "phone"></td>
               <td><input class="form-control me-2" type ="text" placeholder = "E-mail" aria-label = "E-mail" name = "email"></td>
               <td><input class="btn btn-outline-primary" type="submit"></input></td>
            </tr>
   </table>
</form>

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

echo '<h3 ">Таблица с сотрудниками</h3>';

if ($result = mysqli_query($link, 'SELECT * FROM employees ORDER BY idemployees')) {

   echo '<table class="table">
      <thead>
            <tr>
               <th>ФИО</th>
               <th>Паспорт</th>
               <th>ИНН</th>
               <th>Адрес</th>
               <th>Телефон</th>
               <th>E-mail</th>
               <th>Удаление</th>
            </tr>
      </thead>';

   while( $row = mysqli_fetch_assoc($result) ){
      echo '<tr>' .
            '<td><a href="#" class="people-editable" data-name="name" data-type="text" data-title="Фамилия Имя Отчество" data-pk="' . $row['idemployees'] . '" data-url="ajax.php" >' . $row['name'] . '</a></td>' .
            '<td><a href="#" class="people-editable" data-name="pasport " data-type="text" data-title="Паспорт" data-pk="' . $row['idemployees'] . '" data-url="ajax.php" >' . $row['pasport'] . '</a></td>' .
            '<td><a href="#" class="people-editable" data-name="inn" data-type="text" data-title="ИНН" data-pk="' . $row['idemployees'] . '" data-url="ajax.php" >' . $row['inn'] . '</a></td>' .
            '<td><a href="#" class="people-address-editable" data-name="address" data-type="address" data-title="Адрес" data-pk="' . $row['idemployees'] . '" data-url="ajax.php" >' . $row['address'] . '</a></td>' .
            '<td><a href="#" class="people-phone-editable" data-inputclass="phone-mask" data-name="phone" data-type="text" data-title="Номер телефона" data-pk="' . $row['idemployees'] . '" data-url="ajax.php" >' . $row['phone'] . '</a></td>' .
            '<td><a href="#" class="people-email-editable" data-name="email" data-type="text" data-title="E-mail" data-pk="' . $row['idemployees'] . '" data-url="ajax.php" >' . $row['email'] . '</a></td>' .
            //'<td><a href="#" class="people-editable" data-name="company" data-type="text" data-pk="' . $row['id'] . '" data-url="ajax.php" >' . $row['company'] . '</a></td>' .
            //'<td><a href="#" class="people-editable" data-name="note" data-type="textarea" data-pk="' . $row['id'] . '" data-url="ajax.php" >' . $row['note'] . '</a></td>' .
            // '<td><a href="#" class="people-date-editable" data-name="date" data-type="date" data-title="Дата рождения" data-pk="' . $row['idemployees'] . '" data-url="ajax.php" >' . date('d.m.Y', $row['date']) . '</a></td>' .
            //'<td><a href="#" class="people-status-editable" data-name="status" data-type="select" data-pk="' . $row['id'] . '" data-url="ajax.php" >' . $row['status'] . '</a></td>' .
            // '<td><a href="" class="btn btn-primary btn-sm editable-submit"><i class="glyphicon glyphicon-ok"></i></a></td>'.
            '<td><a href="http://localhost1/includes/hr/delete_hr.php?idemployees=' .$row['idemployees']. '" class="btn btn-outline-danger btn-sm editable-delete"><i class="glyphicon glyphicon-trash"></i></a></td>'.
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
      <th>idemployees</th>
      <th>ФИО</th>
      <th>Паспорт</th>
      <th>ИНН</th>
      <th>Адрес</th>
      <th>Телефон</th>
      <th>E-mail</th>
      <th>used</th>
      <th>Откат</th>
      </tr>
   </thead>
<?php 
   $temp_employees = get_temp_employees();
   $temp_employees = array_reverse($temp_employees);
   $PubIdx = 0;
   foreach($temp_employees as $key=> $temp_employee) { 
      ++$PubIdx;
      ?>
		<tr>
				<td><?php echo $temp_employee['id'] ?></td>
				<td><?php echo $temp_employee['date'] ?></td>
            <td><?php echo $temp_employee['query'] ?></td>
            <td><?php echo $temp_employee['idemployees'] ?></td>
            <td><?php echo $temp_employee['name'] ?></td>
            <td><?php echo $temp_employee['pasport'] ?></td>
            <td><?php echo $temp_employee['inn'] ?></td>
            <td><?php echo $temp_employee['address'] ?></td>
            <td><?php echo $temp_employee['phone'] ?></td>
            <td><?php echo $temp_employee['email'] ?></td>
				<td><?php echo $temp_employee['used'] ?></td>
            <td><a href=<?php echo "http://localhost1/includes/hr/temp_hr.php?number=".$PubIdx ?> class="btn btn-outline-primary btn-sm editable-submit"><i class="glyphicon glyphicon-ok"></i></a></td>
			</tr>
         
<?php } ?>

</table>

</div>
</body>
</html>
<?php 
   include_once "includes/seller/header_ce.php"; 

function get_temp_products(){
    return db_query("SELECT * FROM `temp_products`;")->fetchAll(); 
}
?>

<body>

<div class="container" style="width: 1220px;"> 

<!-- <h3>Экспорт/Импорт БД</h3>
<a href=<?php echo "http://localhost1/includes/hr/dumb.php"?> class="btn btn-outline-primary">Экспорт</a>
<a href=<?php echo "http://localhost1/includes/hr/loading.php"?> class="btn btn-outline-primary">Импорт</a> -->

<h3>Добавление нового товара</h3>

<form class="d-flex" action = "includes/ce/add_ce.php" method = "post">
   <table class="table">
      <thead>
            <tr>
               <th>Название товара</th>
               <th>Количество</th>
               <th>Цена закупки</th>
               <th>Цена продажи</th>
               <th>Добавление</th>
            </tr>
      </thead>
            <tr>
               <td><input class="form-control me-2" type ="text" placeholder = "Название товара" aria-label = "Название товара" name = "product_name"></td>
               <td><input class="form-control me-2" type ="text" placeholder = "Количество" aria-label = "Количество" name = "quantity"></td>
               <td><input class="form-control me-2" type ="text" placeholder = "Цена закупки" aria-label = "Цена закупки" name = "purchase_price"></td>
               <td><input class="form-control me-2" type ="text" placeholder = "Цена продажи" aria-label = "Цена продажи" name = "selling_price"></td>
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

echo '<h3 ">Таблица с товаром</h3>';

if ($result = mysqli_query($link, 'SELECT * FROM products ORDER BY idproducts')) {

   echo '<table class="table">
      <thead>
            <tr>
               <th>Название товара</th>
               <th>Количество</th>
               <th>Цена закупки</th>
               <th>Цена продажи</th>
               <th>Удаление</th>
            </tr>
      </thead>';

   while( $row = mysqli_fetch_assoc($result) ){
      echo '<tr>' .
            '<td><a href="#" class="people-editable" data-name="product_name" data-type="text" data-title="Название товара" data-pk="' . $row['idproducts'] . '" data-url="ajax_ce.php" >' . $row['product_name'] . '</a></td>' .
            '<td><a href="#" class="people-editable" data-name="quantity " data-type="text" data-title="Количество" data-pk="' . $row['idproducts'] . '" data-url="ajax_ce.php" >' . $row['quantity'] . '</a></td>' .
            '<td><a href="#" class="people-editable" data-name="purchase_price" data-type="text" data-title="Цена закупки" data-pk="' . $row['idproducts'] . '" data-url="ajax_ce.php" >' . $row['purchase_price'] . '</a></td>' .
            '<td><a href="#" class="people-editable" data-name="selling_price" data-type="text" data-title="Цена продажи" data-pk="' . $row['idproducts'] . '" data-url="ajax_ce.php" >' . $row['selling_price'] . '</a></td>' .
            '<td><a href="http://localhost1/includes/ce/delete_ce.php?idproducts=' .$row['idproducts']. '" class="btn btn-outline-danger btn-sm editable-delete"><i class="glyphicon glyphicon-trash"></i></a></td>'.
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
      <th>idproducts</th>
      <th>Название товара</th>
      <th>Количество</th>
      <th>Цена закупки</th>
      <th>Цена продажи</th>
      <th>used</th>
      <th>Откат</th>
      </tr>
   </thead>
<?php 
   $temp_products = get_temp_products();
   $temp_products = array_reverse($temp_products);
   $PubIdx = 0;
   foreach($temp_products as $key=> $temp_product) { 
      ++$PubIdx;
      ?>
		<tr>
				<td><?php echo $temp_product['id'] ?></td>
				<td><?php echo $temp_product['date'] ?></td>
            <td><?php echo $temp_product['query'] ?></td>
            <td><?php echo $temp_product['idproducts'] ?></td>
            <td><?php echo $temp_product['product_name'] ?></td>
            <td><?php echo $temp_product['quantity'] ?></td>
            <td><?php echo $temp_product['purchase_price'] ?></td>
            <td><?php echo $temp_product['selling_price'] ?></td>
				<td><?php echo $temp_product['used'] ?></td>
            <td><a href=<?php echo "http://localhost1/includes/ce/temp_ce.php?number=".$PubIdx ?> class="btn btn-outline-primary btn-sm editable-submit"><i class="glyphicon glyphicon-ok"></i></a></td>
			</tr>
         
<?php } ?>

</table>

</div>
</body>
</html>
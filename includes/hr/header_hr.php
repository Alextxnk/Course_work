<?php 
	include_once "functions.php";
?>
<!doctype html>
<html lang="ru">
<head>
	<meta charset="UTF-8">
	<meta name="viewport"
				content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-uWxY/CJNBR+1zjPWmfnSnVxwRheevXITnMqoEIeG1LJrdI0GlVs/9cVSyPYXdcSF" crossorigin="anonymous">
	<link rel="stylesheet" href="css/header.css" />

	<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/address.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script src="js/bootstrap.js" type="text/javascript"></script>

<link href="css/bootstrap-editable.css" rel="stylesheet"/>
<script src="js/bootstrap-editable.min.js"></script>
<script src="js/address.js" type="text/javascript"></script>
<script src="js/jquery.maskedinput.min.js" type="text/javascript"></script>

	<title><?php echo SITE_NAME; ?></title>

</head>
<body>
	<header>
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark" style="border-radius: 0px;">

			<div class="container">
				<a class = "navbar-brand active" href="http://localhost1/profile_hr.php"><?php echo SITE_NAME; ?></a>
				<a class = "navbar-brand active" href = "http://localhost1/profile_hr.php">Сотрудники</a>
				<a class = "navbar-brand active" href = "http://localhost1/posts.php">Должности</a>
				<div class="navbar-collapse" id="navbarSupportedContent" style="text-align: right; align-items: center;">
					<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
						<a class = "navbar-brand" style="color: white; position: relative; cursor: pointer; text-decoration: none;">Alex HR</a>
						<li class="nav-item">
								<a href="http://localhost1/includes/hr/logout.php" class="btn btn-outline-primary" style="display: block; color: white; border-radius: 5px; font-weight: bold; font-size: 16px; padding: 13px 20px; text-decoration: none; ">Выйти</a>
						</li>
					</ul>
				</div>
			</div>
		</nav>
	</header>
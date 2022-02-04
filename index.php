<?php 
	include_once "includes/hr/functions.php"; 

	$error = '';
	if (isset($_SESSION['error']) && !empty($_SESSION['error'])) {
		$error = $_SESSION['error'];
		$_SESSION['error'] = '';
	}

	$success = '';
	if (isset($_SESSION['success']) && !empty($_SESSION['success'])) {
		$success = $_SESSION['success'];
		$_SESSION['success'] = '';
	}

	if (isset($_POST['login']) && !empty($_POST['login']) && isset($_POST['password']) && !empty($_POST['password'])) {
		login($_POST);
	}
?>

<!doctype html>
<html lang="ru">
<head>
	<meta charset="UTF-8">
	<meta name="viewport"
				content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-uWxY/CJNBR+1zjPWmfnSnVxwRheevXITnMqoEIeG1LJrdI0GlVs/9cVSyPYXdcSF" crossorigin="anonymous">
   <link rel="stylesheet" href="css/styles.css" />
	<title><?php echo SITE_NAME; ?></title>
</head>
<body>
	<header class="header">
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark" style="border-radius: 0px;">
			<div class="container">
				<a class="navbar-brand" href="<?php echo get_url(); ?>"><?php echo SITE_NAME; ?></a>
				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						
						<?php if(isset($_SESSION['user']['id']) && !empty($_SESSION['user']['id'])) { ?>
							<li class="nav-item">
								<a class="nav-link " href="<?php echo get_url('profile.php'); ?>">Профиль</a>
							</li>
						<?php } ?>
					</ul>
				</div>
			</div>
		</nav>
	</header>
	<main class="container">
		<?php if (!empty($success)) {  ?>
		<div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
			<?php echo $success; ?>
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		</div>
		<?php } ?>

		<?php if (!empty($error)) { ?>
		<div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
			<?php echo $error; ?>
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		</div>
		<?php } ?>

		<div class="row mt-5">
			<div class="col">
				<h2 class="text-center">Вход в личный кабинет</h2>
			</div>
		</div>
		<div class="row mt-3">
			<div class="col-4 offset-4">
				<form action = "" method = "post">
					<div class="mb-3">
						<label for="login-input" class="form-label">Логин</label>
						<input type="text" class="form-control" id="login-input" required name = "login">
					</div>
					<div class="mb-3">
						<label for="password-input" class="form-label">Пароль</label>
						<input type="password" class="form-control" id="password-input" required name = "password">
					</div>
					<div class="btn" style="padding-top: 20px;">	
						<button style="display: flex; margin:0 auto; align-items:center;" type="submit" class="btn btn-primary">Войти</button>	
					</div>
				</form>
			</div>
		</div>
	</main>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-kQtW33rZJAHjgefvhyyzcGF3C5TFyBQBA13V1RKPf4uH+bwyzQxZ6CmMZHmNBEfJ" crossorigin="anonymous"></script>
</body>
</html>

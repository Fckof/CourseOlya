<?php
session_start();
require_once("php_connection/connect.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/main_style.css">
	<title>Списки студентов</title>
</head>
<body>
	<!---------------------------------------------------------------------------------------- header -->
<nav class="navbar navbar-expand-xxl navbar-dark bg-dark ">
  <div class="container-fluid">
    <a class="navbar-brand" href="index.php">QR</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse container-fluid" id="navbarSupportedContent">
      <form class="d-flex" action="php_req/search.php" method="GET">
        <input class="form-control mr-2" type="search" placeholder="Поиск по ФИО" aria-label="Search" name="search">
        <button class="btn btn-outline-success ml-2" type="submit">Искать</button>
      </form>
    </div>
	<?if(!isset($_SESSION['admin'])):?>
		<a role="button" class=" btn btn-warning btn-lg d-flex justify-content-center " tabindex="-1" data-bs-toggle="modal" data-bs-target="#exampleModal2">
					Admin
		</a>
	<?else:?>
		<a  class=" btn btn-danger btn-lg d-flex justify-content-center " href="php_req/exit.php">
				Выйти
		</a>
	<?endif;?>
  </div>
</nav>

	<div class="container container-lg container-fluid general_content ">
<!----------------------------------------------------------------------------------- modals -->
<div class="modal fade" id="exampleModal3" tabindex="-1" aria-labelledby="exampleModalLabel3" aria-hidden="true">
  		<div class="modal-dialog modal-dialog-centered">
			<form class="modal-content" action="php_req/change_qr_status.php" method="GET">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel3">Изменить статус QR</h5>
					<button type="button" class="close" data-bs-dismiss="modal" aria-bs-label="Close">
					<span aria-bs-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body ">
					
					<div class="row mb-3">
						<label for="inputPassword3" class="col-sm-2 col-form-label">ID студента</label>
						<div class="col-sm-10">
						<input type="number" name="change" class="form-control" id="inputPassword3">
						</div>
					</div>
				</div>
				<div class="modal-footer">
				<button type="submit" class="btn btn-success">Открыть</button>
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
					
				</div>
			</form>
  		</div>
	</div>
	<div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel2" aria-hidden="true">
  		<div class="modal-dialog modal-dialog-centered">
			<form class="modal-content" action="php_req/auth.php" method="GET">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel2">Вход администратора</h5>
					<button type="button" class="close" data-bs-dismiss="modal" aria-bs-label="Close">
					<span aria-bs-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body ">
					<div class="row mb-3">
						<label for="inputEmail3" class="col-sm-2 col-form-label">Login</label>
						<div class="col-sm-10">
						<input type="input" name="login" class="form-control" id="inputEmail3">
						</div>
					</div>
					<div class="row mb-3">
						<label for="inputPassword3" class="col-sm-2 col-form-label">Password</label>
						<div class="col-sm-10">
						<input type="password" name="pass" class="form-control" id="inputPassword3">
						</div>
					</div>
				</div>
				<div class="modal-footer">
				<button type="submit" class="btn btn-success">Войти</button>
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
					
				</div>
			</form>
  		</div>
	</div>
	<div class="modal fade " id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-bs-hidden="true">
  		<div class="modal-dialog modal-dialog-centered">
			<form class="modal-content" action="php_req/show_group_members.php" method="GET">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel">Выберите группу</h5>
					<button type="button" class="close" data-bs-dismiss="modal" aria-bs-label="Close">
					<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body ">
					
						<?php include("php_req/group.php");?>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Закрыть</button>
					<button type="submit" class="btn btn-primary" >Искать</button>
				</div>
			</form>
  		</div>
	</div>
		
	<div class="modal fade" id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel1" aria-hidden="true">
  		<div class="modal-dialog modal-dialog-centered">
			<form class="modal-content" action="php_req/stat.php" method="GET">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel1">Статистика</h5>
					<button type="button" class="close" data-bs-dismiss="modal" aria-bs-label="Close">
					<span aria-bs-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body ">
					
						<? include("php_req/stat.php");?>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
					
				</div>
			</form>
  		</div>
	</div>
		<!---------------------------------------------------------------------- main --->
		<div class="container container-fluid main_content">
			<div class="welcome_block mt-4 mr-3">
				<h1 class="logo">Добро пожаловать на сайт QR</h1>
				<hr>
				<h2>Здесь ведется учет студентов ФПМиВТ с информации о их вакцинации</h2>
				<hr>
				<span class="display-6">Вы можете:</span>
				<a role="button" class=" btn btn-success btn-lg d-flex justify-content-center m-3" tabindex="-1" data-bs-toggle="modal" data-bs-target="#exampleModal">
				Просмотреть список студентов конкретной группы
					</a>
					<a role="button" class=" btn btn-success btn-lg d-flex justify-content-center m-3" tabindex="-1" data-bs-toggle="modal" data-bs-target="#exampleModal1">
				Вывод статистики о вакцинации
					</a>
					<a href="php_req/ended.php" class=" btn btn-success btn-lg d-flex justify-content-center m-3" >
				Просмотр списка студентов с истекшим QR-кодом
					</a>
					<a href="php_req/noqr.php" class=" btn btn-success btn-lg d-flex justify-content-center m-3" >
				Просмотр списка студентов без QR-кодов
					</a>
					<?
						if(isset($_SESSION['admin'])):
					?>
					<span class="display-6">Для Админа:</span>
					<a role="button" class=" btn btn-success btn-lg d-flex justify-content-center m-3" tabindex="-1" data-bs-toggle="modal" data-bs-target="#exampleModal3">
						Изменить статус QR-кода
					</a>
					<a role="button" class=" btn btn-success btn-lg d-flex justify-content-center m-3" tabindex="-1" data-bs-toggle="modal" data-bs-target="#exampleModal1">
						Добавить
					</a>
					<? endif;?>
				</div>
		</div>
	</div>
	  <script src="js/bootstrap.bundle.js"></script>
</body>
</html>
<?php
session_start();
require("../php_connection/connect.php");
$res=$conn->query("CALL `Завершившиеся QR`();");
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="../css/bootstrap.css">
	<link rel="stylesheet" href="../css/main_style.css">
	<title>Списки студентов</title>
</head>
<body>

	<div class="container container-lg container-fluid ">
	
	<div class="headr d-flex justify-content-between align-items-center"><h1 class="m-2 mt-3">Список лиц с истекшим QR </h1>
		<a href="../index.php" class="back mr-2 btn btn-danger">Назад</a>
	</div>
	
		
		<div class="container container-fluid mb-2">
			<?echo '
						<div class="row pb-2 pt-3 border-bottom btn-primary">
						<div class="col-sm">
							Название группы
						</div>
						<div class="col-sm">
						Фамилия
						</div>
						<div class="col-sm">
						Имя
						</div>
						<div class="col-sm">
						Отчество
						</div>
						<div class="col-sm">
						Привит
						</div>
						<div class="col-sm">
						Переболел
						</div>
						<div class="col-sm">
						Дата окончания QR
						</div>';
						if(isset($_SESSION['admin'])){
							print '<div class="col-sm">
							</div>';}
						  print '</div>
							';
				while($row=$res->fetch_assoc()){
						echo '
						<div class="row pb-1 pt-1 btn-success">
						<div class="col-sm">
						  '.$row["Название группы"].'
						</div>
						<div class="col-sm">
						'.$row["Фамилия"].'
						</div>
						<div class="col-sm">
						'.$row["Имя"].'
						</div>
						<div class="col-sm">
						'.$row["Отчество"].'
						</div>
						<div class="col-sm">
						'.$row["Привит"].'
						</div>
						<div class="col-sm">
						'.$row["Переболел"].'
						</div>
						<div class="col-sm">
						'.$row["Дата окончания QR"].'
						</div>';
						if(isset($_SESSION['admin'])){
							print '<div class="col-sm">
							<form action="change_qr_status.php" method="GET">
							<button type="submit" class="btn btn-warning" name="change" value="'.$row['id student'].'">Изменить</button>
							</form>
							</div>';}
						  print '</div>';

				}
			?>

		</div>
	</div>
</body>
</html>
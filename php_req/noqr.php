<?php
require("../php_connection/connect.php");
$res=$conn->query("CALL `Нет QR`();");
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
	
	<div class="headr d-flex justify-content-between align-items-center"><h1 class="m-2 mt-3">Список лиц без QR </h1>
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
						</div>
					  </div>
						';
				while($row=$res->fetch_assoc()){
						echo '
						<div class="row pb-1 btn-success">
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
						</div>
					  </div>
						';

				}
			?>

		</div>
	</div>
</body>
</html>
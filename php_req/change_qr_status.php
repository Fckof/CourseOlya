<?  
session_start();
$s=$_GET['change'];
require("../php_connection/connect.php");
$res=$conn->query("SELECT * FROM `qr_code` WHERE `id student`=$s");
$row=$res->fetch_assoc();
if($row<1){
	exit('<div class="headr d-flex justify-content-between align-items-center">
	<h1 class="m-2 mt-3">Такого студента нет</h1>
	<a href="../index.php" class="back mr-2 btn btn-danger">Назад</a>
	</div>');
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="../css/bootstrap.css">
	<link rel="stylesheet" href="../css/main_style.css">
	<title>Статус QR студента <?echo $row['id student'];?></title>
</head>
<body>

	<div class="container container-lg container-fluid ">
	<div class="headr d-flex justify-content-between align-items-center"><h1 class="m-2 mt-3">Изменить статус QR студента <?echo $row['id student']?> </h1>
		<a href="../index.php" class="back mr-2 btn btn-danger">Назад</a>
	</div>
		<div class="container container-fluid mb-2">
			<form action="update.php" method="POST" class="d-flex flex-column justify-content-center">
				<div class="row mb-3 mt-5 ">
								<label for="input1" class="col-sm-2 col-form-label h1">ID студента</label>
								<div class="col-sm-6 ">
								<input type="text"  class="form-control" id="input1" disabled value="<?echo $row['id student']?>">
								<input type="text" name="id_st" class="form-control" hidden id="input1" value="<?echo $row['id student']?>">
								</div>
				</div>
				<div class="row mb-3 mt-5 ">
								<label for="input2" class="col-sm-2 col-form-label h1">ID вакцины</label>
								<div class="col-sm-6 ">
									<select name="vac_id" id="input2" class="form-control">
										<?php
										if($row['id vac']=="A"){
											print '<option value="'.$row['id vac'].'" selected>'.$row['id vac'].'</option>';
											print '<option value="B" >B</option>';
											print '<option value="C" >C</option>';
										}elseif($row['id vac']=="B"){
											print '<option value="A" >A</option>';
											print '<option value="'.$row['id vac'].'" selected>'.$row['id vac'].'</option>';
											print '<option value="C" >C</option>';
										}
										elseif($row['id vac']=="C"){
											print '<option value="A" >A</option>';
											print '<option value="B" >B</option>';
											print '<option value="'.$row['id vac'].'" selected>'.$row['id vac'].'</option>';
										}
										else{
											print '<option value="" selected></option>';
											print '<option value="A" >A</option>';
											print '<option value="B" >B</option>';
											print '<option value="C" >C</option>';
										}
										?>
									</select>
								</div>
				</div>
				<div class="row mb-3 mt-5 ">
								<label for="input3" class="col-sm-2 col-form-label h1">Дата окончания</label>
								<div class="col-sm-6 ">
								<input type="date" name="date_end" class="form-control" id="input3"  value="<?echo $row['Дата окончания QR']?>">
								</div>
				</div>
				<div class="row mb-3 mt-5 ">
						<label for="input4" class="col-sm-2 col-form-label h1">Переболел</label>
						<div class="col-sm-6 ">
						<select name="illed" id="input4" class="form-control">
										<?php
										if($row['Переболел']=="1"){
											print '<option value="1" selected>Да</option>';
											print '<option value="0" >Нет</option>';
											
										}
										else{
											print '<option value="1" >Да</option>';
											print '<option value="0" selected>Нет</option>';
										}
										?>
									</select>
									</div>
					</div>
					<div class="row mb-3 mt-5 ">
						<label for="input5" class="col-sm-2 col-form-label h1">Привит</label>
						<div class="col-sm-6 ">
						<select name="vaccined" id="input5" class="form-control">
										<?php
										if($row['Привит']=="1"){
											print '<option value="1" selected>Да</option>';
											print '<option value="0" >Нет</option>';
											
										}
										else{
											print '<option value="1" >Да</option>';
											print '<option value="0" selected>Нет</option>';
										}
										?>
									</select>
									</div>
					</div>
			</div>
			<button type="submit" class="btn btn-success">Изменить</button>
			</form>
	</div>
</body>
</html>
<?  
session_start();
require("../php_connection/connect.php");
$illed=$_POST["illed"];
$vac_id=$_POST["vac_id"];
$vaccined=$_POST["vaccined"];
$id=$_POST["id_st"];
$date_end=$_POST["date_end"];
$res=$conn->query("CALL `Изменить информацию о QR`('$vaccined', '$vac_id', '$illed', '$date_end', '$id');");

if($res){
	echo "<script>alert('Данные успешно обновлены')</script>";
}else{
	echo "<script>alert('Ошибка')</script>";
}
sleep(0.5);
Header("Location:./change_qr_status.php?change=".$id);

?>
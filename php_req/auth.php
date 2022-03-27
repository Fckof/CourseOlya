<?php
session_start();
require("../php_connection/connect.php");
$login=$_GET['login'];
$pass=$_GET['pass'];
$res=$conn->query("SELECT `login`,`pass` FROM `users`");
$row=$res->fetch_assoc();
if($login==$row['login'] and $pass==$row['pass']){
	$_SESSION['admin']="ADMIN";
	Header("Location: ../index.php");
}
?>
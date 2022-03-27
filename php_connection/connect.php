<?php
$DB_NAME="students";
$DB_LOCATION="localhost";
$DB_USER="root";
$DB_PASS="";
$conn=new mysqli($DB_LOCATION,$DB_USER,$DB_PASS,$DB_NAME) or die("Не подключилось к базе данных");

?>
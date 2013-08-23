<?php
$studio = $_GET["studio"];
$details = file_get_contents("http://172.16.10.2".$studio."0/statusboard/status");
echo $details;
?>
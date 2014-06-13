<?php
$ip = $_GET["ip"];
$timeout = stream_context_create(array('http' => array('timeout' => 1))); 
$details = file_get_contents("http://172.16.10.".$ip."/statusboard/status", 0, $timeout);
echo $details;
?>
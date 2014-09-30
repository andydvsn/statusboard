<?php
header("Content-Type: text/css");
?>

.studio {
	text-align: <?php $hour = date("H");

if (($hour >= 9) && ($hour < 17)) { 
	echo "left;"; 
} else { 
	echo "right;"; 
}

?>

}
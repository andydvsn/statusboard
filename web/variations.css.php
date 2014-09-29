<?php
header("Content-Type: text/css");
?>

.studio {
	text-align: <?php $hour = date("H");

if (($hour > 9) && ($hour < 16)) { 
	echo "left;"; 
} else { 
	echo "right;"; 
}

?>

}
<?php
include "../server/server.php";

if (!isset($_SESSION["username"])) {
	if (isset($_SERVER["HTTP_REFERER"])) {
		header("Location: " . $_SERVER["HTTP_REFERER"]);
	}
}

$purok = $conn->real_escape_string($_POST["purok"]);
$details = $conn->real_escape_string($_POST["details"]);
$id = $conn->real_escape_string($_POST["id"]);

if (!empty($purok)) {
	$query = "UPDATE purok SET `name` = '$purok', `details`='$details' WHERE id=$id;";
	$result = $conn->query($query);

	if ($result === true) {
		$_SESSION["message"] = "Sitio/Zone has been updated!";
		$_SESSION["status"] = "success";
	} else {
		$_SESSION["message"] = "Something went wrong!";
		$_SESSION["status"] = "danger";
	}
} else {
	$_SESSION["message"] = "No Sitio/Zone ID found!";
	$_SESSION["status"] = "danger";
}

header("Location: ../purok.php");

$conn->close();

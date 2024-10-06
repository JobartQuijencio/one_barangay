<?php
include "../bootstrap/index.php";

ob_start(); // Start output buffering

if (!isset($_SESSION["username"])) {
	if (isset($_SERVER["HTTP_REFERER"])) {
		header("Location: " . $_SERVER["HTTP_REFERER"]);
		exit(); // Always exit after a header redirect
	}
}

/**
 * Handle profile image
 */
$id = getBody("id", $_POST); // base 64 image
$profileCamera = getBody("profileimg", $_POST); // base 64 image
$profileFile = $_FILES["img"];

$imgFilename = empty($profileCamera) ? null : $profileCamera;

if ($profileFile["name"]) {
	$uniqId = uniqid(date("YmdhisU"));
	$ext = pathinfo($profileFile["name"], PATHINFO_EXTENSION);
	$imgFilename = "$uniqId.$ext";
	$imgDir = "../assets/uploads/$imgFilename";

	move_uploaded_file($profileFile["tmp_name"], $imgDir);
}

// If you need to debug, you can use var_dump here (but after header redirections):
// echo "<pre>";
// var_dump($imgFilename);
// echo "</pre>";

$result = $db
	->update("users")
	->where("id", $id)
	->set([
		"avatar" => $imgFilename,
	])
	->exec();
$_SESSION["avatar"] = $imgFilename;
$_SESSION["message"] = "Profile has been updated!";
$_SESSION["status"] = "success";

if (isset($_SERVER["HTTP_REFERER"])) {
	header("Location: " . $_SERVER["HTTP_REFERER"]);
	exit(); // Always exit after a header redirect
}

$conn->close();

ob_end_flush(); // End output buffering and flush the output

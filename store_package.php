<?php
session_start();
error_reporting(0);

// DB connection
$host = "localhost";
$dbname = "tms";
$user = "root";
$pass = "";

try {
    $dbh = new PDO("mysql:host=$host;dbname=$dbname", $user, $pass);
    $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("DB Error: " . $e->getMessage());
}

// Check form submission
if (isset($_POST['submit'])) {
    $email = $_SESSION['login']; // assuming the user is logged in
    $package_name = $_POST['package_name'];
    $booking_type = $_POST['booking_type'];
    $transport = $_POST['transport'];
    $features = $_POST['features'];
    $members = $_POST['members'];

    $sql = "INSERT INTO tblissuess (UserEmail, PackageName, BookingType, Transport, Features, Members) 
            VALUES (:email, :package_name, :booking_type, :transport, :features, :members)";
    
    $stmt = $dbh->prepare($sql);
    $stmt->bindParam(':email', $email);
    $stmt->bindParam(':package_name', $package_name);
    $stmt->bindParam(':booking_type', $booking_type);
    $stmt->bindParam(':transport', $transport);
    $stmt->bindParam(':features', $features);
    $stmt->bindParam(':members', $members);

    if ($stmt->execute()) {
        $_SESSION['msg'] = "Package submitted successfully!";
        echo "<script type='text/javascript'> document.location = 'thankyou.php'; </script>";
    } else {
        $_SESSION['msg'] = "Submission failed.";
        echo "<script type='text/javascript'> document.location = 'thankyou.php'; </script>";
    }
}
?>

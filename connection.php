<?php
// Database connection parameters
$hostname = "localhost:3306";  // Replace with your MySQL host
$username = "SYSTEM"; // Replace with your MySQL username
$password = "Aryan@0812"; // Replace with your MySQL password
$database = "bank"; // Replace with your MySQL database name

// Create a database connection
$conn = mysqli_connect("localhost:3306", "SYSTEM", "Aryan@0812", "bank");

// Check the connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}
echo "Connected successfully";

// Close the connection when done
mysqli_close($conn);
?>

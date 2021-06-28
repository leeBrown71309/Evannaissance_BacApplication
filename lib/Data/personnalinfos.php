<?php
//met a jour les infos personnelles du tuteur

include("connexion.php");

$fullname = $_POST['fullname'];
$age = $_POST['age'];
$phone = $_POST['phone'];
$email = $_POST['email'];


$sql = "SELECT * FROM users WHERE email= '".$email."'";

    $result = mysqli_query($conn,$sql);
    $count = mysqli_num_rows($result);

    if($count == 0){
        echo json_encode("Error");
    }else{
        
        $update = "UPDATE users SET fullname ='".$fullname."',age = '".$age."',phone ='".$phone."' WHERE users.email ='".$email."'";
        $query = mysqli_query($conn,$update);

        if($query){
            echo json_encode("succes");
        }
    }





?>
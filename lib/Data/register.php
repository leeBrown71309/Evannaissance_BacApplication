
<?php

   include("connexion.php");


    $login = $_POST['login'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    
    
    $sql = "SELECT * FROM users WHERE  login= '".$login."' AND email= '".$email."' AND password= '".$password."'";

    $result = mysqli_query($conn,$sql);
    $count = mysqli_num_rows($result);

    if($count == 1){
        echo json_encode("Error");
    }else{
        
        $insert = "INSERT INTO users(login,email,password) VALUES('".$login."','".$email."','".$password."')";
        $query = mysqli_query($conn,$insert);

        if($query){
            echo json_encode("succes");
        }
    }
?>
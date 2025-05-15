<?php
    header("Access-Control-Allow-Origin: *"); 
    $conn = new mysqli("localhost", "flutter_160422041","ubaya","flutter_160422041");
    if($conn->connect_error) {
        $arr= ["result"=>"error","message"=>"unable to connect"];
    }
    
    extract($_POST);
    $sql = "SELECT * FROM master_user where user_id=? and user_password=?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ss",$user_id,$user_password);
    $stmt->execute();
    $result = $stmt->get_result();
    if ($result->num_rows > 0) {
    $r=mysqli_fetch_assoc($result);
    $arr=["result"=>"success","user_name"=>$r['user_name']];
    } else {
    $arr= ["result"=>"error","message"=>"sql error: $sql"];
    }
    echo json_encode($arr);
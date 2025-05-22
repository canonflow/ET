<?php
    header("Access-Control-Allow-Origin: *"); 
    $arr=null;
    $conn = new mysqli("localhost", "flutter_160422041","ubaya","flutter_160422041");
    if($conn->connect_error) {
        $arr= ["result"=>"error","message"=>"unable to connect"];
    }

    extract($_POST);
    $sql="INSERT INTO movie(title,overview,runtime,release_date,homepage,url)
    VALUES(?,?,?,?,?,?)";

    $stmt=$conn->prepare($sql);
    $stmt->bind_param("ssisss",$title,$overview,$runtime,$release_date,$homepage,$url);
    $stmt->execute();
    
    if ($stmt->affected_rows > 0) {
        $arr=["result"=>"success","id"=>$conn->insert_id];
    } else {
        $arr=["result"=>"fail","Error"=>$conn->error];
    }
    echo json_encode($arr);
<?php
  header("Access-Control-Allow-Origin: *"); 
  $arr=null;
  $conn = new mysqli("localhost", "flutter_160422041","ubaya","flutter_160422041");
  if($conn->connect_error) {
    $arr= ["result"=>"error","message"=>"unable to connect"];
  }
  $sql = "SELECT * FROM person ";
  $stmt = $conn->prepare($sql);
  $stmt->execute();
  $result = $stmt->get_result(); 
    $data=[];
  if ($result->num_rows > 0) {
    while($r=mysqli_fetch_assoc($result))
    {
        array_push($data,$r);
    }
    $arr=["result"=>"success","data"=>$data];
  } else {
    $arr= ["result"=>"error","message"=>"sql error: $sql"];
  }
  echo json_encode($arr);
  $stmt->close();
  $conn->close();
?>
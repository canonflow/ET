<?php

    header("Access-Control-Allow-Origin: *"); 
    $arr=null;
    $conn = new mysqli("localhost", "flutter_160422041","ubaya","flutter_160422041");
    if($conn->connect_error) {
        $arr= ["result"=>"error","message"=>"unable to connect"];
    }
    if (!isset($_POST['user_id']) || !isset($_POST['items'])) {
        echo json_encode(["result"=>"error","message"=>"Missing parameters"]);
        exit;
    }

    extract($_POST);
    $sql = "INSERT INTO penjualan(user_id,tanggal) VALUES (?,now())";
    $stmt = $conn->prepare($sql);
    if (!$stmt) {
        echo json_encode(["result" => "error", "message" => "Prepare failed: " . $conn->error]);
        exit;
    }
    $stmt->bind_param("s", $user_id);
    if (!$stmt->execute()) {
        echo json_encode(["result" => "error", "message" => "Execute failed: " . $stmt->error]);
        exit;
    }
    $penjualan_id = $conn->insert_id;
    $arr_item = explode("|", $items);
    foreach ($arr_item as $item) {
        $arrdata = explode(",", $item);
        if (count($arrdata) != 2) continue;
        $sql = "INSERT INTO item_penjualan(penjualan_id,movie_id,jumlah) VALUES (?,?,?)";
        $stmt = $conn->prepare($sql);
        if (!$stmt) continue;
        $stmt->bind_param("iii", $penjualan_id, $arrdata[0], $arrdata[1]);
        $stmt->execute();
    }
    $arr = ["result"=>"success","message"=>"Data penjualan berhasil ditambahkan"];
    echo json_encode($arr);
?>

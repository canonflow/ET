<?php
    header("Access-Control-Allow-Origin: *"); 
    $conn = new mysqli("localhost", "flutter_160422041","ubaya","flutter_160422041");
    if($conn->connect_error) {
        $arr= ["result"=>"error","message"=>"unable to connect"];
    }
    $id=$_POST['id']; 
    $sql = "SELECT * FROM movie where movie_id = ? ";
    $stmt = $conn->prepare($sql);
            $stmt->bind_param("i",$id);
    $stmt->execute();
    $result = $stmt->get_result();
    if ($result->num_rows > 0) {
        $r=mysqli_fetch_assoc($result);
        // ===== GENRE =====
        $sql2 = "SELECT genre_name FROM genre inner join movie_genres 
        on genre.genre_id=movie_genres.genre_id 
        where movie_id=$id ";
        $stmt2 = $conn->prepare($sql2);
        $stmt2->execute();
        $genres=[];
        $result2 = $stmt2->get_result();
        if ($result2->num_rows > 0) {
            while($r2=mysqli_fetch_assoc($result2)) {
                array_push($genres,$r2);
            }
        }
        $r["genres"]=$genres;

        // ===== CASTS =====
        $sql3 = "SELECT mc.character_name as character_name, p.person_name as person_name 
        FROM movie_cast as mc inner join person as p
        on mc.person_id = p.person_id 
        where mc.movie_id = $id";
        $stmt3 = $conn->prepare($sql3);
        $stmt3->execute();
        $casts = [];
        $result3 = $stmt3->get_result();
        if ($result3->num_rows > 0) {
            while($r3 = mysqli_fetch_assoc($result3)) {
                $information = $r3['person_name'] . " - " . $r3['character_name'];
                array_push($casts, $information);
            }
        }
        $r['casts'] = $casts;


        $arr=["result"=>"success","data"=>$r];
    } else {
        $arr= ["result"=>"error","message"=>"sql error: $sql"];
    }
    echo json_encode($arr);

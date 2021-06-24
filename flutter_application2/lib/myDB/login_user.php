<?php

include 'config.php';

global $db;
$json = file_get_contents('php://input');
$obj = json_decode($json,true);
$username = $obj['username'];
$mdp = $obj['mdp'];


$query = $db->query("SELECT * FROM user WHERE username = '$username' AND mdp = '$mdp'");

$statement = $connect->prepare($query);

$statement->execute();

$res = array();

while ($res = $statement->fetch()) {
    array_push(
        $myarray, array(
            "id"=>$res['id'],
            "heading"=>$res['heading'],
            "body"=>$res['body']
        )
    );
}

echo json_encode($res);

?>
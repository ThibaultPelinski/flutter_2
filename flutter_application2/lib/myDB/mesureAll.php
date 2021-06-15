<?php

include 'config.php';

$query = $db->query("SELECT * FROM Mesure_table");

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

<?php

header('Access-Control-Allow-Origin: *');
 
try
 {    // connection à la base de données
     // On se connecte à MySQL
     $connect = new PDO('mysql:host=localhost;dbname=mesure', 'marcel1968', 'Marcel&3436');

    
    $connect->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
 }

 catch(Exception $e)
 {
     die('Erreur : '.$e->getMessage());  // En cas d'erreur, on affiche un message et on arrête tout
 }


$id = $_POST['id'];

$sql =  "SELECT * FROM 'Mesure_Table' ORDER BY  '".$id."' DESC ";

//$statement = $connect->prepare($query);  "body"    => date_format($res['M_date'],"Y/m/d H:i:s"),

$statement->execute();



?>

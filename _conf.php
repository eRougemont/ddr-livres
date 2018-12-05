<?php
ini_set('display_errors', '1');
error_reporting(-1);
return array(
  "title" => "Rougemont", // Nom du corpus
  "srcdir" => dirname(__FILE__), // Dossier source, depuis lequel exécuter la commande de mise à jour
  "cmdup" => "git pull 2>&1", // Commande de mise à jour des sources
  "user" => "", // Code utilisateur, à renseigner obligatoirement à l’installation
  "pass" => "", // Mot de passe, à renseigner obligatoirement à l’installation
  "srcglob" => array( "xml/*.xml" ), // sources XML à publier
  "sqlite" => "rougemont.sqlite", // nom de la base avec les métadonnées
  "formats" => "article, toc, html, markdown, iramuteq", // formats générés
);
?>

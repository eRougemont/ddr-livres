<?php
$conf = include(dirname(__FILE__)."/conf.php");
include(dirname(dirname(__FILE__))."/Teinte/Build.php");
if (php_sapi_name() == "cli") {
  work($conf);
  exit();
}
?>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Administration, haine du théâtre</title>
    <link rel="stylesheet" type="text/css" href="../Teinte/tei2html.css" />
    <style>
label {width: 25em; display: block; text-align: right;}

    </style>
  </head>
  <body>
    <div id="center" style="padding: 1em; ">
      <h1><a href="pull.php">Administration</a>, <a href="." target="_blank"><?=$conf['title']?></a></h1>
      <form method="POST">
        <label>Utilisateur
          <input name="user"/>
        </label>
        <label>Mot de passe
          <input name="pass" type="password"/>
        </label>
        <label>Forcer
          <input name="force" type="checkbox"/>
          <button name="up" type="submit">Mettre à jour</button>
        </label>
      </form>
      <section>
      <?php
  if (!isset($_POST['user']));
  else if (!isset($_POST['pass']));
  else if ($_POST['user'] != $conf['user']) {
    echo "Mauvais code utilisateur";
  }
  else if ($_POST['pass'] != $conf['pass']) {
    echo "Mauvais mot de passe";
  }
  else {
    work($conf, isset($_POST['force']));
  }
      ?>
      </section>
    </div>
  </body>
</html>
<?php
function work($conf, $force=null) {
  if (isset($conf['cmdup'])) {
    $getcwd = getcwd();
    chdir($conf['srcdir']);
    echo 'Mise à jour distante <pre style="white-space: pre-wrap;">'."\n";
    passthru($conf['cmdup']);
    chdir($getcwd);
    echo '</pre>'."\n";
  }
  echo 'Transformations <pre style="white-space: pre-wrap;">'."\n";
  $build = new Teinte_Build($conf);
  if ($force) $build->clean();
  $build->glob();
  echo '</pre>'."\n";
}
?>

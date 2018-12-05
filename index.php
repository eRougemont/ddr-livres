<?php
header('content-type: text/html; charset=utf-8');
if (!file_exists( $path = dirname(__FILE__)."/conf.php")) {
  echo '<h1>Problème de configuration, fichier conf.php introuvable.</h1>';
  exit();
}
$conf = include(dirname(__FILE__)."/conf.php");
include(dirname(dirname(__FILE__))."/Teinte/Web.php");
include(dirname(dirname(__FILE__))."/Teinte/Base.php");
$base = new Teinte_Base($conf['sqlite']);
$path = Teinte_Web::pathinfo(); // document demandé
$basehref = Teinte_Web::basehref(); //
$teinte = $basehref."../Teinte/";

// chercher le doc dans la base
$docid = current(explode('/', $path));
$query = $base->pdo->prepare("SELECT * FROM doc WHERE code = ?; ");
$query->execute(array($docid));
$doc = $query->fetch();
$q = null;
if (isset($_REQUEST['q'])) $q=$_REQUEST['q'];



?><!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title><?php
if($doc) echo $doc['title'].' — ';
echo $conf['title'];
    ?></title>
    <link rel="stylesheet" type="text/css" href="<?= $teinte ?>tei2html.css" />
  </head>
  <body>
    <div id="center">
      <header id="header">
        <h1>
          <?php
if (!$path && $base->search) echo '<a href="'.$basehref.'">'.$conf['title'].'</a>';
else {
  echo '<a href="'.$basehref.'?'.$_COOKIE['lastsearch'].'">'.$conf['title'].'</a>';
}
          ?>
        </h1>
      </header>
      <div id="contenu">
        <aside id="aside">
          <?php
if ($doc) {
// <a target="_blank" href="https://obvil.github.io/critique/sainte-beuve/'.$doc['code'].'.xml" title="XML/TEI">tei</a>,
// <a target="_blank" href="epub/'.$doc['code'].'.epub" title="Livre électronique">epub</a>,
// <a target="_blank" href="kindle/'.$doc['code'].'.mobi" title="Mobi, format propriétaire Amazon">kindle</a>,

  echo '
  <nav id="download"><small>Télécharger :</small>
    <a target="_blank" href="markdown/'.$doc['code'].'.md" title="Markdown">texte brut</a>,
    <a target="_blank" href="iramuteq/'.$doc['code'].'.txt" title="Iramuteq">iramuteq</a>,
    <a target="_blank" href="html/'.$doc['code'].'.html">html</a>.
  </nav>
  ';

  // auteur, titre, date
  echo '<header>';
  if ($doc['byline']) echo "\n".'<div class="byline">'.$doc['byline'] .'</div>';
  echo "\n".'<a class="title" href="'.$basehref.$doc['code'].'/">';
  if ($doc['date']) echo $doc['date'].', ';
  echo $doc['title'].'</a>';
  echo "\n".'</header>';
  echo '
    <form action="#mark1">
      <a title="Retour aux résultats" href="'.$basehref.'?'.$_COOKIE['lastsearch'].'"><img src="'.$basehref.'../theme/img/fleche-retour-corpus.png" alt="←"/></a>
      <input name="q" value="'.str_replace('"', '&quot;', $base->p['q']).'"/><button type="submit">🔎</button>
    </form>
  ';
  // table des matières, quand il y en a une
   if (file_exists($f="toc/".$doc['code']."_toc.html")) readfile($f);
}
// doc statique sans mise à jour
else if (file_exists($f="doc/".$docid."_toc.html")) {
  readfile($f);
}
// accueil ? formulaire de recherche général
// <a target="_blank" href="epub/" title="Livre électronique">epub</a>,
// <a target="_blank" href="kindle/" title="Mobi, format propriétaire Amazon">kindle</a>,
else {
  echo '
  <nav id="download"><small>Téléchagements :</small>
    <a target="_blank" href="markdown/" title="Markdown">texte brut</a>,
    <a target="_blank" href="iramuteq/">iramuteq</a>,
    <a target="_blank" href="html/">html</a>.
  </nav>
  ';

  echo'
<form action="">
  <input style="width: 100%;" name="q" class="text" placeholder="Rechercher de mots" value="'.str_replace('"', '&quot;', $base->p['q']).'"/>
  <div><label>De <input placeholder="année" name="start" class="year" value="'.$base->p['start'].'"/></label> <label>à <input class="year" placeholder="année" name="end" value="'.$base->p['end'].'"/></label></div>
  <button type="reset" onclick="Form.reset(this.form); this.form.submit(); ">Effacer</button>
  <button type="submit" style="float: right; ">Rechercher</button>
</form>
  ';
}
          ?>
        </aside>
        <div id="main">
          <nav id="toolbar">
            <?php
            ?>
          </nav>
          <div id="article" class="<?php echo $doc['class']; ?>">
            <?php
if ($doc) {
  $html = file_get_contents("article/".$doc['code']."_art.html");
  if ($q) echo $base->hilite($doc['id'], $q, $html);
  else echo $html;
}
// doc statique sans mise à jour
else if (file_exists($f="doc/".$docid."_art.html")) {
  readfile($f);
}
else if ($base->search) {
  $base->biblio(array("no", "title", "occs"), "SEARCH");
}
// pas de livre demandé, montrer un rapport général
else {
  // readfile("doc/presentation.html");
  $base->biblio(array("no", "title"));
}
            ?>
            <a id="gotop" href="#top">▲</a>
          </div>
        </div>
      </div>
      <?php
// footer
      ?>
    </div>
    <script type="text/javascript" src="<?= $teinte ?>Tree.js">//</script>
    <script type="text/javascript" src="<?= $teinte ?>Sortable.js">//</script>
  </body>
</html>

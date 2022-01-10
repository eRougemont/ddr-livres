<?php

$res = array(
  "@[  ][–—][  ]@u" => " — ",
  "@\. — @u" => ". — ",
  "@ — ([^\n—.?!;]+?) — @u" => " — $1 — ",
  "@ — @" => " — "
);

$home = dirname(__FILE__).'/';
foreach (glob($home."*.xml") as $srcfile) {
  echo "$srcfile\n";
  $xml = file_get_contents($srcfile);
  $xml = preg_replace(array_keys($res), array_values($res), $xml);
  file_put_contents($srcfile, $xml);
}
?>

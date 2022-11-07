<?php

declare(strict_types=1);

$teinte = dirname(__DIR__) . '/teinte/';
include_once($teinte . 'php/autoload.php');

use Psr\Log\{LogLevel};
use Oeuvres\Kit\{LoggerCli};
use Oeuvres\Teinte\{TeiSource};

$readme = "# Rougemont, livres, les sources XML/TEI

Liens vers les fichiers XML/TEI. En cliquant, un texte devrait vous apparaître 
sans balises et proprement mis en page, avec une transformation XSLT à la volée
qui se fait dans le navigateur.

";
$dst_url = "https://erougemont.github.io/ddr-livres/";
$readme .= TeiReadme::readme(__DIR__, $dst_url);
file_put_contents(__DIR__ . "/README.md", $readme);

class TeiReadme
{

    public static function readme($src_dir, $dst_url)
    {
        $logger = new LoggerCli(LogLevel::INFO);
        $tei_source = new TeiSource($logger);
        $readme = [];
        $readme[] = "| N° | Auteur | Date | Titre | XML/TEI |";
        $readme[] = "| -: | :----- | ---: | :---- | ------: |";
        $i = 1;
        // is glob always sorting ?
        foreach (glob($src_dir . "/*.xml") as $tei_file) {
            $tei_name = pathinfo($tei_file,  PATHINFO_FILENAME);
            if ($tei_name[0] == '_' || $tei_name[0] == '.') continue;

            $tei_basename = basename($tei_file);
            
            $tei_source->load($tei_file);
            $meta = $tei_source->meta();
            $readme[] = "|$i.|" . $meta['byline'] 
            . "|" . $meta['date'] 
            . "|" . $meta['title']
            . "|" . "[$tei_basename]($dst_url$tei_basename)" 
            . "|";


            $i++;
        }

        return implode("\n", $readme);
    }
}

<?php

$fp = fopen("php://stdin", "r");
$in = '';
while($in != "quit") {
    echo "php> ";
    $in=trim(fgets($fp));
    eval ($in);
    echo "\n";
    }

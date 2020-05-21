<?php
$displayFields = array(
    'id',
    'title',
    'price',
    'currency'
);

echo $this->Table->createTable(
    $products,
    $displayFields
);
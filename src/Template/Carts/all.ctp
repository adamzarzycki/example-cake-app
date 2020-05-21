<?php
$displayFields = array(
    'id',
    'cart_id',
    'product_id'
);

echo $this->Table->createTable(
    $carts,
    $displayFields
);
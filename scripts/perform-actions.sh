#!/usr/bin/env bash
set -ex bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

$SCRIPTPATH/add-product.sh
sleep 2

$SCRIPTPATH/add-not-unique-product.sh
sleep 2

$SCRIPTPATH/edit-product.sh
sleep 2

$SCRIPTPATH/delete-product.sh
sleep 2

$SCRIPTPATH/add-product-to-cart.sh
sleep 2
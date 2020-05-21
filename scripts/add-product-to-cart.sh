#!/usr/bin/env bash
set -ex bash

curl -d '{"id":1, "cart_id": 1, "product_id": "5"}' -H 'Content-Type: application/json' http://localhost:8081/carts.json
curl -d '{"id":2, "cart_id": 1, "product_id": "4"}' -H 'Content-Type: application/json' http://localhost:8081/carts.json

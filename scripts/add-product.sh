#!/usr/bin/env bash
set -ex bash

curl -d '{"id": 6, "title": "GTA V", "price": 0, "currency": "USD"}' -H 'Content-Type: application/json' http://localhost:8081/products.json
curl -d '{"id": 7, "title": "Fifa 22", "price": 9.99, "currency": "USD"}' -H 'Content-Type: application/json' http://localhost:8081/products.json

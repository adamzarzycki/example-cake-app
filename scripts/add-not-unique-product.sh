#!/usr/bin/env bash
set -ex bash

curl -d '{"id": 8, "title": "Fifa 22", "price": 15, "currency": "USD"}' -H 'Content-Type: application/json' http://localhost:8081/products.json
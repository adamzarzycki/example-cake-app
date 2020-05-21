#!/usr/bin/env bash
set -ex bash

curl -d '{"id": 4, "title": "Sims"}' -H 'Content-Type: application/json' http://localhost:8081/products.json
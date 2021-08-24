#!/bin/bash

cd configuration/app
docker build -t app:1.0 -f app.dockerfile .

cd ../web
docker build -t web:1.0 -f web.dockerfile .

cd ../..
docker-compose up -d
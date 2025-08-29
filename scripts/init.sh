#!/bin/bash

# Создание БД
sleep 10
airflow db migrate
sleep 10

# Создание пользователя
airflow users create \
          --username admin \
          --firstname admin \
          --lastname admin \
          --role Admin \
          --email admin@example.org \
          -p password

# Запуск шедулера и вебсервера
airflow scheduler & airflow api-server --port 8080

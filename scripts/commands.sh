#!/bin/sh

# O shell irá encerrar a execução do script quando um comando falhar
set -e

while ! nc -z $POSTGRES_HOST $POSTGRES_PORT; do
    echo " Waiting for Postgres Database Startup ($POSTGRES_HOST $POSTGRES_PORT) ..."
    sleep 0.1
done

echo " Postgres Database Start Successfull ($POSTGRES_HOST $POSTGRES_PORT)"

collectstatic.sh
python manage.py makemigrations --noinput
python manage.py migrate --noinput
python manage.py runserver 0.0.0.0:8000
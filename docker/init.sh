#!/bin/sh -e

psql --variable=ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
  CREATE DATABASE "interview_development";
  CREATE DATABASE "interview_test";
EOSQL

psql --variable=ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname=interview_development <<-EOSQL
  CREATE EXTENSION "citext";
EOSQL

psql --variable=ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname=interview_test <<-EOSQL
  CREATE EXTENSION "citext";
EOSQL

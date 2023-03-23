#!/bin/bash
db_name="$1"
set echo off

echo "Copying data files to tmp"
cp ./*.csv /tmp

if [$db_name = ""]; then
    db_name=postgres
fi

echo "Building Database - $db_name"
psql -d $db_name < ./source_schema.sql

echo "Loading Data - $db_name"
psql -d $db_name < ./data_load.sql
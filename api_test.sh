#!/bin/bash
status_code=$(curl --write-out %{http_code} --out /dev/null --silent "localhost:8000/r_squared")

if [ $status_code = 200 ];
then
    echo "PASS: The API is reachable"
else
	echo "FAIL: The API is unreachable"
	    exit 1
fi
#!/bin/bash

mongo digitory --eval "db.$1.$2($3)"


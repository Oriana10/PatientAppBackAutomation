#!/bin/bash

# Prompt the user for the module name
read -p "Module Name: " nombre_modulo

# Create the module folder
mkdir -p "$nombre_modulo"

# Create subdirectories inside the module folder
for carpeta in "endpoints" "functions" "views"; do
    mkdir -p "$nombre_modulo/$carpeta"
done

# Create files inside the base folder
touch "$nombre_modulo/main.py"
touch "$nombre_modulo/__init__.py"

# Create files inside the endpoints folder
for archivo in "post.py" "put.py" "delete.py" "get.py" "__init__.py"; do
    touch "$nombre_modulo/endpoints/$archivo"
done

# Create files inside the functions folder
touch "$nombre_modulo/functions/__init__.py"
mkdir -p "$nombre_modulo/functions/crud"
touch "$nombre_modulo/functions/crud/__init__.py"
for archivo in "create.py" "delete.py" "read.py" "update.py" "__init__.py"; do
    touch "$nombre_modulo/functions/crud/$archivo"
done

# Create files inside the views folder
touch "$nombre_modulo/views/schemas.py"

#echo "Structure successfully created in the "$module_name" folder."
echo $nombre_modulo

#!/bin/bash

# Create Files and Folders
echo "Creating module structure..."
nombre_modulo_plural=$(sh ./createFolders.sh)

# Get word derivatives from the module to generate a correct grammar in the subsequent code.
echo "Searching for correct syntax for code generation..."
nombre_modulo_singular=$(python ./getSingular.py $nombre_modulo_plural)
#nombre_modulo_genero_singular=$(python ./getGrammaticalGender.py $nombre_modulo_plural) # doesnt work :(
read -p "Singular article: " nombre_modulo_genero_singular

# Create Main Module
echo "Creating main module..."
sh ./mainModule.sh $nombre_modulo_plural

# Create Endpoints
echo "Creating endpoints..."
sh ./deleteEndpoint.sh $nombre_modulo_plural $nombre_modulo_singular $nombre_modulo_genero_singular
sh ./getEndpoint.sh $nombre_modulo_plural $nombre_modulo_singular $nombre_modulo_genero_singular
sh ./postEndpoint.sh $nombre_modulo_plural $nombre_modulo_singular $nombre_modulo_genero_singular
sh ./putEndpoint.sh $nombre_modulo_plural $nombre_modulo_singular $nombre_modulo_genero_singular

# Functions
echo "Creating functions..."
sh ./createFunction.sh $nombre_modulo_plural $nombre_modulo_singular $nombre_modulo_genero_singular
sh ./deleteFunction.sh $nombre_modulo_plural $nombre_modulo_singular $nombre_modulo_genero_singular
sh ./readFunction.sh $nombre_modulo_plural $nombre_modulo_singular $nombre_modulo_genero_singular
sh ./updateFunction.sh $nombre_modulo_plural $nombre_modulo_singular $nombre_modulo_genero_singular

echo "Module complete."
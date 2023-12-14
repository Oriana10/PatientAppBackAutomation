#!/bin/bash

# Create Files and Folders
echo "Creating module structure..."
nombre_modulo=$(sh ./createFolders.sh)

# Get word derivatives from the module to generate a correct grammar in the subsequent code.
echo "Searching for correct syntax for code generation..."
nombre_modulo_plural=$(python ./getPlural.py $nombre_modulo)
#nombre_modulo_genero=$(python ./getGrammaticalGender.py $nombre_modulo) # queda corregir este codigo
nombre_modulo_genero="los"

# Create Endpoints
echo "Generando endpoints..."
sh ./deleteEndpoint.sh $nombre_modulo $nombre_modulo_plural $nombre_modulo_genero
sh ./getEndpoint.sh $nombre_modulo $nombre_modulo_plural $nombre_modulo_genero
sh ./postEndpoint.sh $nombre_modulo $nombre_modulo_plural $nombre_modulo_genero
sh ./putEndpoint.sh $nombre_modulo $nombre_modulo_plural $nombre_modulo_genero

# Functions
echo "Generando functions..."
sh ./createFunction.sh $nombre_modulo $nombre_modulo_plural $nombre_modulo_genero
sh ./deleteFunction.sh $nombre_modulo $nombre_modulo_plural $nombre_modulo_genero
sh ./readFunction.sh $nombre_modulo $nombre_modulo_plural $nombre_modulo_genero
sh ./updateFunction.sh $nombre_modulo $nombre_modulo_plural $nombre_modulo_genero

echo "Module complete."
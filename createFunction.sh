#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Error: Proporcione el nombre del módulo como argumento."
    exit 1
fi

nombre_modulo_plural=$1
nombre_modulo_singular=$2
nombre_modulo_genero_singular=$3
archivo_create="$nombre_modulo_plural/functions/crud/create.py"

{
  cat <<EOF
from views import models
from service.modules.$nombre_modulo_plural.views import schemas
from sqlalchemy.orm import Session
from functions.utilities import create_entity

def create_$nombre_modulo_singular(db: Session, ${nombre_modulo_singular}: schemas.${nombre_modulo_plural^}Upload):
    db_${nombre_modulo_singular} = models.${nombre_modulo_plural^}(**${nombre_modulo_singular}.dict())
    return create_entity(db, db_${nombre_modulo_singular})
EOF
} > "$archivo_create"
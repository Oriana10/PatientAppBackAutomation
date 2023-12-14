#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Error: Proporcione el nombre del módulo como argumento."
    exit 1
fi

nombre_modulo=$1
nombre_modulo_plural=$2
nombre_modulo_genero=$3
archivo_create="$nombre_modulo/functions/crud/create.py"

{
  cat <<EOF
from views import models
from service.modules.$nombre_modulo_plural.views import schemas
from sqlalchemy.orm import Session
from functions.utilities import create_entity

def create_$nombre_modulo_plural(db: Session, ${nombre_modulo_plural}: schemas.${nombre_modulo_plural^}Upload):
    db_${nombre_modulo_plural} = models.${nombre_modulo_plural^}(**${nombre_modulo_plural}.dict())
    return create_entity(db, db_${nombre_modulo_plural})
EOF
} > "$archivo_create"
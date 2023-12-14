#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Error: Proporcione el nombre del módulo como argumento."
    exit 1
fi

nombre_modulo_plural=$1
nombre_modulo_singular=$2
nombre_modulo_genero_singular=$3
archivo_delete="$nombre_modulo_plural/functions/crud/delete.py"

{
  cat <<EOF
from sqlalchemy.orm import Session
from . import read
from functions.utilities import delete_entity

def delete_$nombre_modulo_singular(db: Session, ${nombre_modulo_singular}_id: int):
    ${nombre_modulo_singular}_db = read.get_${nombre_modulo_singular}(db, ${nombre_modulo_singular}_id).first()
    if not ${nombre_modulo_singular}_db:
        return False
    return delete_entity(db, ${nombre_modulo_singular}_db)
EOF
} > "$archivo_delete"
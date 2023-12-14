#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Error: Proporcione el nombre del módulo como argumento."
    exit 1
fi

nombre_modulo=$1
nombre_modulo_plural=$2
nombre_modulo_genero=$3
archivo_delete="$nombre_modulo/functions/crud/delete.py"

{
  cat <<EOF
from sqlalchemy.orm import Session
from . import read
from functions.utilities import delete_entity

def delete_$nombre_modulo(db: Session, ${nombre_modulo}_id: int):
    ${nombre_modulo}_db = read.get_${nombre_modulo}(db, ${nombre_modulo}_id).first()
    if not ${nombre_modulo}_db:
        return False
    return delete_entity(db, ${nombre_modulo}_db)
EOF
} > "$archivo_delete"
#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Error: Proporcione el nombre del módulo como argumento."
    exit 1
fi

nombre_modulo_plural=$1
nombre_modulo_singular=$2
nombre_modulo_genero_singular=$3
archivo_read="$nombre_modulo_plural/functions/crud/read.py"

{
  cat <<EOF
from views import models
from sqlalchemy.orm import Session

def get_$nombre_modulo_plural(db: Session, filters: dict = None, skip: int = 0, limit: int = 100):
    query = db.query(models.${nombre_modulo_plural^})
    if filters:
        for key, value in filters.items():
            query = query.filter(getattr(models.${nombre_modulo_plural^}, key).like(f'%{value}%'))
    return query.order_by(models.${nombre_modulo_plural^}.id).offset(skip).limit(limit)

def get_$nombre_modulo_singular(db: Session, ${nombre_modulo_singular}_id: int):
    return db.query(models.${nombre_modulo_plural^}).filter(models.${nombre_modulo_plural^}.id == ${nombre_modulo_singular}_id)
EOF
} > "$archivo_read"
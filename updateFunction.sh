#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Error: Proporcione el nombre del módulo como argumento."
    exit 1
fi

nombre_modulo_plural=$1
nombre_modulo_singular=$2
nombre_modulo_genero_singular=$3
archivo_update="$nombre_modulo_plural/functions/crud/update.py"

{
  cat <<EOF
from sqlalchemy.orm import Session
from service.modules.$nombre_modulo_plural.views import schemas
from . import read

def update_$nombre_modulo_singular(db: Session, $nombre_modulo_singular: schemas.${nombre_modulo_plural^}Upload, ${nombre_modulo_singular}_id: int):
    ${nombre_modulo_singular}_db = read.get_$nombre_modulo_singular(db, ${nombre_modulo_singular}_id).first()

    if not ${nombre_modulo_singular}_db:
        return False

    datos_a_actualizar = {key: value for key, value in ${nombre_modulo_singular}.dict().items() if value}
    ${nombre_modulo_singular}_db.update(datos_a_actualizar)
    db.commit()
    db.refresh(${nombre_modulo_singular}_db)
    return True

EOF
} > "$archivo_update"


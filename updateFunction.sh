#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Error: Proporcione el nombre del módulo como argumento."
    exit 1
fi

nombre_modulo=$1
nombre_modulo_plural=$2
nombre_modulo_genero=$3
archivo_update="$nombre_modulo/functions/crud/update.py"

{
  cat <<EOF
from sqlalchemy.orm import Session
from service.modules.$nombre_modulo_plural.views import schemas
from . import read

def update_$nombre_modulo(db: Session, $nombre_modulo: schemas.${nombre_modulo_plural^}Upload, ${nombre_modulo}_id: int):
    ${nombre_modulo}_db = read.get_$nombre_modulo(db, ${nombre_modulo}_id).first()

    if not ${nombre_modulo}_db:
        return False

    datos_a_actualizar = {key: value for key, value in ${nombre_modulo}.dict().items() if value}
    ${nombre_modulo}_db.update(datos_a_actualizar)
    db.commit()
    db.refresh(${nombre_modulo}_db)
    return True

EOF
} > "$archivo_update"


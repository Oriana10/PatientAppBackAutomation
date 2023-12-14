#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Error: Proporcione el nombre del módulo como argumento."
    exit 1
fi

nombre_modulo_plural=$1
nombre_modulo_singular=$2
nombre_modulo_genero_singular=$3
archivo_delete="$nombre_modulo_plural/endpoints/delete.py"

{
  cat <<EOF
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from functions.db import get_db
from resources.log.logger import logger
from service.modules.$nombre_modulo_plural.functions.crud import delete

router = APIRouter()

@router.delete("/{${nombre_modulo_singular}_id}", tags=["$nombre_modulo_plural"], status_code=201, response_model=dict)
def delete_$nombre_modulo_singular(${nombre_modulo_singular}_id: int, db: Session = Depends(get_db)):
    respuesta = delete.delete_$nombre_modulo_singular(db, ${nombre_modulo_singular}_id)

    if not respuesta:
        logger.warning(f'No se pudo eliminar $nombre_modulo_genero_singular $nombre_modulo_singular ID {${nombre_modulo_singular}_id} porque no existe.')
        raise HTTPException(status_code=404, detail=f'${nombre_modulo_genero_singular^} $nombre_modulo_singular no se puede eliminar porque no existe.')

    logger.trace(f'Se elimino $nombre_modulo_genero_singular $nombre_modulo_singular con el ID {${nombre_modulo_singular}_id}')
    return {"detail":"Se elimnó $nombre_modulo_genero_singular $nombre_modulo_singular correctamente."}

EOF
} > "$archivo_delete"
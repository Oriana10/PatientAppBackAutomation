#!/bin/bash

# Verificar si se proporciona el nombre del módulo como argumento
if [ $# -eq 0 ]; then
    echo "Error: Proporcione el nombre del módulo como argumento."
    exit 1
fi

# Nombre del módulo
nombre_modulo_plural=$1
nombre_modulo_singular=$2
nombre_modulo_genero_singular=$3

# Ruta al archivo get.py
archivo_get="$nombre_modulo_plural/endpoints/get.py"

# Generar el enspoint y moverlo al archivo get.py
{
  cat <<EOF
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from cachetools import cached, TTLCache
from functions.db import get_db
from resources.log.logger import logger
from service.modules.$nombre_modulo_plural.functions.crud import read
from service.modules.$nombre_modulo_plural.views import schemas

router = APIRouter()

cache = TTLCache(
    maxsize=100,
    ttl=600
)

@router.get("/", tags=["$nombre_modulo_plural"], status_code=200, response_model=list[schemas.${nombre_modulo_plural^}])
def get_$nombre_modulo_plural(skip: int = None,
                limit: int = None,
                db: Session = Depends(get_db),
                filters: dict = None):

    @cached(cache)
    def obtener_$nombre_modulo_plural():
        $nombre_modulo_plural = read.get_$nombre_modulo_plural(db).all()
        logger.trace(f'Se buscaron todos los $nombre_modulo_plural')
        return $nombre_modulo_plural

    return obtener_$nombre_modulo_plural()

@router.get("/{${nombre_modulo_singular}_id}", tags=["$nombre_modulo_plural"], status_code=200, response_model=schemas.${nombre_modulo_plural^})
def get_$nombre_modulo_singular(${nombre_modulo_singular}_id: int, db: Session = Depends(get_db)):

    @cached(cache)
    def obtener_$nombre_modulo_singular(${nombre_modulo_singular}Id: int):
        $nombre_modulo_singular = read.get_$nombre_modulo_singular(db, ${nombre_modulo_singular}Id).first()
        if not $nombre_modulo_singular:
            logger.warning(f'No se pudo consultar $nombre_modulo_genero_singular $nombre_modulo_singular ID {${nombre_modulo_singular}Id} porque no existe')
            raise HTTPException(status_code=404, detail='No se pudo encontrar $nombre_modulo_genero_singular $nombre_modulo_singular')
        logger.trace(f'Se buscó $nombre_modulo_genero_singular $nombre_modulo_singular con el ID {${nombre_modulo_singular}Id}')
        return $nombre_modulo_singular

    return obtener_$nombre_modulo_singular(${nombre_modulo_singular}_id)
EOF
} > "$archivo_get"


#echo "Archivo $archivo_get creado con éxito." # add exception


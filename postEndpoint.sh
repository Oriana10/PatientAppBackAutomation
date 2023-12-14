#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Error: Proporcione el nombre del módulo como argumento."
    exit 1
fi

nombre_modulo=$1
nombre_modulo_plural=$2
nombre_modulo_genero=$3
archivo_post="$nombre_modulo/endpoints/post.py"

{
  cat <<EOF
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from functions.db import get_db
from resources.log.logger import logger
from service.modules.$nombre_modulo.functions.crud import create
from service.modules.$nombre_modulo.views import schemas

router = APIRouter()

@router.post("/", tags=["$nombre_modulo_plural"], status_code=200, response_model=schemas.${nombre_modulo_plural^})
def create_$nombre_modulo($nombre_modulo: schemas.${nombre_modulo_plural^}Upload, db: Session = Depends(get_db)):
    ${nombre_modulo}_db = create.create_$nombre_modulo(db, $nombre_modulo)
    logger.trace('Se creo una $nombre_modulo')
    return ${nombre_modulo}_db
EOF
} > "$archivo_post"
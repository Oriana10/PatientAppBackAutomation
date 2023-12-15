#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Error: Proporcione el nombre del módulo como argumento."
    exit 1
fi

nombre_modulo_plural=$1
archivo_delete="$nombre_modulo_plural/main.py"

{
  cat <<EOF
from .endpoints import delete, get, post, put
from fastapi import APIRouter

router = APIRouter(prefix='/$nombre_modulo_plural')

router.include_router(delete.router)
router.include_router(get.router)
router.include_router(post.router)
router.include_router(put.router)
EOF
} > "$archivo_delete"





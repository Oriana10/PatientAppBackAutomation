from pattern.es import singularize
import sys

def obtener_singular(palabra):
    return singularize(palabra)

if __name__ == "__main__":   
    if len(sys.argv) != 2:
        print("Error. Uso: python obtenerSingular.py <palabra>")
        sys.exit(1)

    palabra = sys.argv[1]
    palabra_singular = obtener_singular(palabra)

    print(palabra_singular)
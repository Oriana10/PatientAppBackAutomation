from pattern.es import pluralize
import sys

def obtener_plural(palabra):
    return pluralize(palabra)

if __name__ == "__main__":   
    if len(sys.argv) != 2:
        print("Error. Uso: python obtenerPlural.py <palabra>")
        sys.exit(1)

    palabra = sys.argv[1]
    palabra_plural = obtener_plural(palabra)

    print(palabra_plural)

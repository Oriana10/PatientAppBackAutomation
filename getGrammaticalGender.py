import spacy

def obtener_articulo(palabra):
    nlp = spacy.load('es_core_news_sm')
    doc = nlp(palabra)

    # Determinar el género y artículo
    genero = doc[0]._.gender
    articulo = 'el' if genero == 'Masc' else 'la'

    return articulo

if __name__ == "__main__":
    palabra = input("Ingrese una palabra: ")
    resultado = obtener_articulo(palabra)

    print(f"El artículo definido para '{palabra}' es '{resultado}'.")



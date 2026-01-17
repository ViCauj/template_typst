# Typst Template

Ce template a été créé par Vincent Caujolle.

## Utilisation

Pour utiliser ce template, vous devez importer le fichier `lib.typ` dans votre document `.typ`.

```typst
#import "lib.typ": *
// ou #import "@local/template:1.0.0": *

#show: doc => conf(
  title:[Un titre super bien],
  author: [Vincent Caujolle, Albert Einstein],
  abstract: [#lorem(40)],
  columns: 2,
  doc
)
```

## Fonctions

- `conf(doc, title: none, author: none, abstract: none, columns: 2)`: Configure la page avec un titre, un auteur, un résumé et un nombre de colonnes.
- `def(body)`: Crée un bloc de définition.
- `prop(body)`: Crée un bloc de propriété.
- `thm(body)`: Crée un bloc de théorème.
- `demo(body, type:none)`: Crée un bloc de démonstration (On peut préciser si on veut le type de démonstration `thm` ou `prop`)
- `expl(body)`: Crée un bloc d'exemple.
- `rem(body)`: Crée un bloc de remarque.

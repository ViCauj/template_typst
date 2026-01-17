#import "@preview/suiji:0.5.1": *

#let dice = (sym.die.one, sym.die.two, sym.die.three, sym.die.four, sym.die.five, sym.die.six)
#let today = datetime.today()
#let seed = today.year() * 10000 + today.month() * 100 + today.day()

#let conf(doc, title:none, author: none, abstract: none, columns: 2) = {
  show heading: it => {
    set text(font: "Fira Sans");
    set block(below: 1em);
    it
  };
  set heading(numbering: "1.");
  show strong: set text(font: "Fira Sans");
  set par(
    justify: true,
  );
  set page(
    paper: "us-letter",
    numbering: "1",
    columns: columns,
    footer: context {
      let rng = gen-rng-f(seed + counter(page).get().first());
      let (rng, resultat) = integers(rng, low: 1, high: 6, size: 2);
      set text(size: 15pt);
      
      grid(
        columns: (1fr, auto, 1fr),
        align(left, dice.at(resultat.at(0))),
        align(center, counter(page).display()),
        align(right, dice.at(resultat.at(1))),
      )
    },
  );
  
  if title != none { 
    place(top + center, float: true, scope: "parent",clearance: 5em)[
      #set align(center)
      #text(size: 30pt, weight: "bold", font: "Fira Sans")[#title]
      
      #if author != none {
        block(width: 80%,)[
          #text(size: 15pt)[#author]
        ]
        v(3em)
      }
      #if abstract != none {
        block(width: 80%,)[
          #set align(center)
          #set par(justify: true)

          *Abstract* \
          _ #abstract _
        ]
      }
    ]
  }
  
  doc
}

#let def_counter = counter("def")
#let def(body) = {
  def_counter.step()
  block(
    width: 100%,
    inset: 1em,
    spacing: 2em,
    radius: (
      top-left: 0%,
      top-right: 5%,
      bottom-left: 0%,
      bottom-right: 5%
    ),
    stroke: (left: 2pt + green, top: none, right: none, bottom: none),
    fill: rgb(0, 128, 0, 10%), 
    [
      *Définition #context def_counter.display()* #body
    ]
  )
}

#let prop_counter = counter("prop")
#let prop(body) = {
  prop_counter.step()
  block(
    width: 100%,
    inset: 1em,
    spacing: 2em,
    radius: (
      top-left: 0%,
      top-right: 5%,
      bottom-left: 0%,
      bottom-right: 5%
    ),
    stroke: (left: 2pt + red, top: none, right: none, bottom: none),
    fill: rgb(128, 0, 0, 10%), 
    [
      *Propriété #context prop_counter.display()* #body
    ]
  )
}

#let thm_counter = counter("thm")
#let thm(body) = {
  thm_counter.step()
  block(
    width: 100%,
    inset: 1em,
    spacing: 2em,
    radius: (
      top-left: 0%,
      top-right: 5%,
      bottom-left: 0%,
      bottom-right: 5%
    ),
    stroke: (left: 2pt + blue, top: none, right: none, bottom: none),
    fill: rgb(0, 0, 128, 10%), 
    [
      *Théorème #context thm_counter.display()* #body
    ]
  )
}

#let demo(body, qed: sym.errorbar.square.filled) = {
  block(
    width: 100%,
    inset: (left: 1em, right: 1em),
    spacing: 2em,
    radius: (
      top-left: 0%,
      top-right: 5%,
      bottom-left: 0%,
      bottom-right: 5%
    ),
    stroke: (left:  2pt + black, top: none, right: none, bottom: none),
    [
      *Démonstration* #body ~ #h(1fr) #box(rotate(90deg, qed))
    ]
  )
}

#let expl(body) = {
  block(
    width: 100%,
    inset: 1em,
    spacing: 2em,
    radius: (
      top-left: 0%,
      top-right: 5%,
      bottom-left: 0%,
      bottom-right: 5%
    ),
    stroke: (left: (dash: "dashed", paint: purple, thickness: 2pt), top: none, right: none, bottom: none),
    fill: rgb(128, 0, 128, 5%),
    [
      *Exemple* #body
    ]
  )
}

#let rem(body) = {
  block(
    width: 100%,
    inset: 1em,
    spacing: 2em,
    radius: (
      top-left: 0%,
      top-right: 5%,
      bottom-left: 0%,
      bottom-right: 5%
    ),
    stroke: (left: 2pt + orange, top: none, right: none, bottom: none),
    fill: rgb(255, 255, 128, 40%),
    [
      *Remarque* #body
    ]
  )
}

/*
  Typst Template
  Author: Vincent Caujolle
  Version: 1.0.0
*/

#import "@preview/suiji:0.5.1": *
#import "@preview/fancy-tiling:1.0.0": *

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

  show heading.where(level:1): it => {
    counter(math.equation).update(0)
    it
  }
  set math.equation(supplement: none, numbering: n => {
    numbering("(1.1)", counter(heading).get().first(), n)
  })
  show math.equation: it => {
    if it.block and not it.has("label") and it.numbering != none {
      counter(math.equation).update(n => n - 1)
      math.equation(numbering: none, block: true, it.body)
    } else {
      it
    }
  }

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

#let demo(body, qed: sym.errorbar.square.filled, type: none) = {
  let fill_color = white
  let stroke_color = black
  let v_inset = 0em
  if type == thm {
    fill_color = rgb(0, 0, 128, 10%)
    stroke_color = blue
    v_inset = 1em
  } else if type == prop {
    fill_color = rgb(128, 0, 0, 10%)
    stroke_color = red
    v_inset = 1em
  }

  block(
    width: 100%,
    inset: (left: 1em, right: 1em, top: v_inset, bottom: v_inset),
    spacing: 2em,
    radius: (
      top-left: 0%,
      top-right: 5%,
      bottom-left: 0%,
      bottom-right: 5%
    ),
    stroke: (left:  2pt + stroke_color, top: none, right: none, bottom: none),
    fill: diagonal-stripes(stripe-color: fill_color, size: 10pt, thickness-ratio: 50%),
    [
      *Démonstration* #body #align(right)[#box(rotate(90deg, qed))]
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
    fill: checkerboard(cell-color: rgb(255, 255, 128, 50%)),
    [
      *Remarque* #body
    ]
  )
}

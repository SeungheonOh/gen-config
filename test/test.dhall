let Map = https://prelude.dhall-lang.org/v15.0.0/Map/Type
let Vimrc : Type = {
  set : Map Text Text,
  binding: Map Text (Map Text Text),
  raw : Text
  }
let Toml : Type = {
  a : Text,
  b : Text
  }
let Comb = <ConfigVimrc: Vimrc| ConfigToml: Toml>
in
[Comb.ConfigVimrc ./vimrc.dhall,
Comb.ConfigToml {
  a = "a",
  b = "b",
},
]
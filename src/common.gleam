import gleam/dict
import gleam/int
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/string

pub fn lines(s: String) {
  s |> string.split("\n")
}

pub fn paragraphs(s: String) {
  s |> string.split("\n\n")
}

pub fn spaces(s: String) {
  s |> string.split(" ")
}

pub fn separated_numbers(s: String, sep: String) -> List(Int) {
  s |> string.split(sep) |> list.filter_map(int.parse)
}

pub fn sum(ln) {
  ln |> list.fold(0, fn(a, b) { a + b })
}

pub fn map_or_unwrap(opt: Option(a), init: b, f: fn(a) -> b) -> b {
  opt |> option.map(f) |> option.unwrap(init)
}

pub fn then_some(b: Bool, v) {
  case b {
    True -> Some(v)
    False -> None
  }
}

pub fn then_ok(b: Bool, v, e) {
  case b {
    True -> Ok(v)
    False -> Error(e)
  }
}

pub fn is_positive(i) {
  i > 0
}

pub fn is_negative(i) {
  i < 0
}

pub fn list_product(a_s: List(a), b_s: List(b)) -> List(List(#(a, b))) {
  a_s
  |> list.fold([], fn(acc: List(List(#(a, b))), a) {
    let a_list: List(#(a, b)) =
      b_s
      |> list.fold([], fn(acc, b) { [#(a, b), ..acc] })
      |> list.reverse

    [a_list, ..acc]
  })
}

pub fn enumerate(l: List(item)) -> List(#(Int, item)) {
  l |> list.index_map(fn(a, i) { #(i, a) })
}

pub fn dict_of_indices(l: List(item)) -> dict.Dict(Int, item) {
  l |> enumerate |> dict.from_list
}

pub fn fold_with_rest(
  l: List(item),
  initial: acc,
  f: fn(acc, item, List(item)) -> acc,
) -> acc {
  case l {
    [] -> initial
    [first, ..rest] -> {
      let acc = f(initial, first, rest)
      fold_with_rest(rest, acc, f)
    }
  }
}

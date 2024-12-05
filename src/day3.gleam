import common
import data/day3 as data
import gleam/int
import gleam/io
import gleam/list
import gleam/option.{Some}
import gleam/regexp

pub fn main() {
  io.println("part1 answer:" <> { data.input() |> part1 |> int.to_string })
  io.println("part2 answer:" <> { data.input() |> part2 |> int.to_string })
}

pub fn part1(s: String) {
  let assert Ok(re) = regexp.from_string("mul\\((\\d{1,3}),(\\d{1,3})\\)")
  re
  |> regexp.scan(s)
  |> list.map(fn(matches) {
    let assert [Some(a), Some(b)] = matches.submatches
    let assert Ok(a) = a |> int.parse
    let assert Ok(b) = b |> int.parse

    a * b
  })
  |> common.sum
}

type State {
  Enabled
  Disabled
}

pub fn part2(s: String) {
  let assert Ok(re) =
    regexp.from_string("(mul\\((\\d{1,3}),(\\d{1,3})\\)|do\\(\\)|don't\\(\\))")
  let result =
    re
    |> regexp.scan(s)
    |> list.fold(#(Enabled, 0), fn(acc, matches) {
      case acc.0, matches.content {
        Disabled, "do()" -> #(Enabled, acc.1)
        Disabled, _ -> acc
        Enabled, "don't()" -> #(Disabled, acc.1)
        Enabled, "do()" -> acc
        Enabled, _ -> {
          let assert [_, Some(a), Some(b)] = matches.submatches
          let assert Ok(a) = a |> int.parse
          let assert Ok(b) = b |> int.parse

          #(Enabled, acc.1 + a * b)
        }
      }
    })

  result.1
}

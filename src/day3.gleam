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

pub fn part2(s: String) {
  s
  |> common.lines
  |> list.length
}

import common
import data/day1 as data
import gleam/bool
import gleam/dict
import gleam/function
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

pub fn main() {
  io.println("part1 answer:" <> { data.input() |> part1 |> int.to_string })
  io.println("part2 answer:" <> { data.input() |> part2 |> int.to_string })
}

pub fn part1(input: String) {
  let #(left, right) =
    input |> common.lines |> list.map(parse_line) |> list.unzip
  let left = left |> list.sort(int.compare)
  let right = right |> list.sort(int.compare)

  list.zip(left, right)
  |> list.map(fn(tup) { tup.0 - tup.1 |> int.absolute_value })
  |> common.sum
}

fn parse_line(s) {
  let assert [left, right] =
    s
    |> common.spaces
    |> list.filter(fn(s) { s |> string.is_empty |> bool.negate })
    |> list.map(fn(s) { s |> int.parse |> result.unwrap(0) })

  #(left, right)
}

pub fn part2(input: String) {
  let #(left, right) =
    input |> common.lines |> list.map(parse_line) |> list.unzip
  let left = left |> counts
  let right = right |> counts

  left
  |> dict.fold(0, fn(sum, value, count) {
    sum + { value * count * { right |> dict.get(value) |> result.unwrap(0) } }
  })
}

fn counts(l) {
  l
  |> list.group(function.identity)
  |> dict.map_values(fn(_, v) { v |> list.length })
}

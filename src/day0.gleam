import common
import data/day0 as data
import gleam/int
import gleam/io
import gleam/list

pub fn main() {
  io.println("part1 answer:" <> { data.input() |> part1 |> int.to_string })
  io.println("part2 answer:" <> { data.input() |> part2 |> int.to_string })
}

pub fn part1(s: String) {
  s
  |> common.lines
  |> list.length
}

pub fn part2(s: String) {
  s
  |> common.lines
  |> list.length
}

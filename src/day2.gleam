import common
import data/day2 as data
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
  input
  |> common.lines
  |> list.map(fn(line) {
    line
    |> string.split(" ")
    |> list.map(fn(s) { s |> int.parse |> result.unwrap(0) })
  })
  |> list.map(fn(line) {
    line
    |> list.window(2)
    |> list.map(fn(tup) {
      let assert [first, second] = tup
      first - second
    })
  })
  |> list.filter(fn(diffs) {
    let small_diffs =
      diffs
      |> list.map(int.absolute_value)
      |> list.all(fn(diff) { diff == 1 || diff == 2 || diff == 3 })
    let all_positive = diffs |> list.all(common.is_positive)
    let all_negative = diffs |> list.all(common.is_negative)
    small_diffs && { all_positive || all_negative }
  })
  |> list.length
}

pub fn part2(input: String) {
  input
  |> common.lines
  |> list.map(fn(line) {
    line
    |> string.split(" ")
    |> list.map(fn(s) { s |> int.parse |> result.unwrap(0) })
  })
  |> list.filter(fn(line) {
    line |> line_acceptable
    || line
    |> list.combinations(list.length(line) - 1)
    |> list.any(line_acceptable)
  })
  |> list.length
}

fn line_acceptable(line) {
  let diffs =
    line
    |> list.window(2)
    |> list.map(fn(tup) {
      let assert [first, second] = tup
      first - second
    })
  let small_diffs =
    diffs
    |> list.map(int.absolute_value)
    |> list.all(fn(diff) { diff == 1 || diff == 2 || diff == 3 })
  let all_positive = diffs |> list.all(common.is_positive)
  let all_negative = diffs |> list.all(common.is_negative)
  small_diffs && { all_positive || all_negative }
}

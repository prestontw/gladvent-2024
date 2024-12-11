import common
import data/day7 as data
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/set
import gleam/string

pub fn main() {
  io.println("part1 answer:" <> { data.input() |> part1 |> int.to_string })
  io.println("part2 answer:" <> { data.input() |> part2 |> int.to_string })
}

fn parse(s: String) {
  s
  |> common.lines
  |> list.map(fn(line) {
    let assert [test_value, numbers] = line |> string.split(": ")
    let test_value = test_value |> int.parse |> result.unwrap(0)
    let numbers = numbers |> common.separated_numbers(" ")
    #(test_value, numbers)
  })
}

fn can_be_combined(equation) {
  let #(test_value, numbers) = equation
  let assert [first, ..rest] = numbers
  let combinations =
    rest
    |> list.fold([first] |> set.from_list, fn(running_numbers, number) {
      let summed = running_numbers |> set.map(fn(n) { n + number })
      let multiplied = running_numbers |> set.map(fn(n) { n * number })
      summed |> set.union(multiplied)
    })
  case combinations |> set.contains(test_value) {
    True -> Ok(test_value)
    False -> Error(Nil)
  }
}

pub fn part1(s: String) {
  s
  |> parse
  |> list.filter_map(can_be_combined)
  |> common.sum
}

pub fn part2(s: String) {
  s
  |> common.lines
  |> list.length
}

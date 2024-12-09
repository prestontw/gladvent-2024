import common
import data/day4 as data
import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/set
import gleam/string
import grid

pub fn main() {
  io.println("part1 answer:" <> { data.input() |> part1 |> int.to_string })
  io.println("part2 answer:" <> { data.input() |> part2 |> int.to_string })
}

type Direction {
  N
  NW
  W
  SW
  S
  SE
  E
  NE
}

fn direction_delta(d: Direction) -> #(Int, Int) {
  case d {
    N -> #(0, -1)
    NW -> #(-1, -1)
    W -> #(-1, 0)
    SW -> #(-1, 1)
    S -> #(0, 1)
    SE -> #(1, 1)
    E -> #(1, 0)
    NE -> #(1, -1)
  }
}

fn move(point: #(Int, Int), d: Direction) -> #(Int, Int) {
  common.move(point, d |> direction_delta)
}

fn star_4(point: #(Int, Int)) -> List(List(#(Int, Int))) {
  let range = list.range(1, 3)
  [N, NW, W, SW, S, SE, E, NE]
  |> list.fold([], fn(acc, direction) {
    let ray =
      range
      |> list.scan(point, fn(acc, _) { acc |> move(direction) })

    [[point, ..ray], ..acc]
  })
}

fn slash(point: #(Int, Int)) -> List(#(Int, Int)) {
  [point, point |> move(NE), point |> move(SW)]
}

fn backslash(point: #(Int, Int)) -> List(#(Int, Int)) {
  [point, point |> move(NW), point |> move(SE)]
}

pub fn part1(s: String) {
  let g = grid.new(s, Ok)
  let target = "XMAS" |> string.to_graphemes
  g.data
  |> dict.filter(fn(_, v) { v == "X" })
  |> dict.keys
  |> list.map(fn(pos) {
    let rays = pos |> star_4
    rays
    |> list.filter(fn(ray) {
      ray
      |> list.zip(target)
      |> list.all(fn(item) {
        let #(pos, target) = item
        g
        |> grid.get(pos)
        |> result.map(fn(char) { char == target })
        |> result.unwrap(False)
      })
    })
    |> list.length
  })
  |> common.sum
}

pub fn part2(s: String) {
  let g = s |> grid.new(Ok)
  let target = "MAS" |> string.to_graphemes |> set.from_list

  g.data
  |> dict.filter(fn(_, v) { v == "A" })
  |> dict.keys
  |> list.filter(fn(pos) {
    [pos |> slash, pos |> backslash]
    |> list.all(fn(points) {
      let letters = points |> list.filter_map(grid.get(g, _)) |> set.from_list
      letters == target
    })
  })
  |> list.length
}

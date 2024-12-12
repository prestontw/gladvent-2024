import common
import data/day8 as data
import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/option
import gleam/set
import grid

pub fn main() {
  io.println("part1 answer:" <> { data.input() |> part1 |> int.to_string })
  io.println("part2 answer:" <> { data.input() |> part2 |> int.to_string })
}

type Cell {
  Antennae(char: String)
}

fn grid(s: String) -> grid.Grid(Cell) {
  s
  |> grid.new(fn(c) {
    case c {
      "." -> Error(Nil)
      c -> Ok(Antennae(c))
    }
  })
}

fn grid_to_layers(g: grid.Grid(Cell)) -> dict.Dict(String, List(#(Int, Int))) {
  g.data
  |> dict.fold(dict.new(), fn(acc, pos, cell) {
    acc
    |> dict.upsert(cell.char, fn(value) {
      value |> option.unwrap([]) |> list.prepend(pos)
    })
  })
}

fn layer_extensions(points: List(#(Int, Int))) -> set.Set(#(Int, Int)) {
  points
  |> common.fold_with_rest(set.new(), fn(points, point, rest) {
    rest
    |> list.fold(points, fn(points, pointb) {
      points |> set.union(extend_pair(point, pointb) |> set.from_list)
    })
  })
}

fn add_points(a: #(Int, Int), b: #(Int, Int)) -> #(Int, Int) {
  #(a.0 + b.0, a.1 + b.1)
}

fn subtract_points(a: #(Int, Int), b: #(Int, Int)) -> #(Int, Int) {
  #(a.0 - b.0, a.1 - b.1)
}

fn extend_pair(a: #(Int, Int), b: #(Int, Int)) -> List(#(Int, Int)) {
  let from_b_to_a_diff = a |> subtract_points(b)
  let from_a_to_b_diff = b |> subtract_points(a)

  [a |> add_points(from_b_to_a_diff), b |> add_points(from_a_to_b_diff)]
}

pub fn part1(s: String) {
  // can process this in parallel by letter type
  let grid = s |> grid
  let layers = grid |> grid_to_layers
  layers
  |> dict.values
  |> list.fold(set.new(), fn(antinodes, layer) {
    antinodes
    |> set.union(
      layer
      |> layer_extensions
      |> set.filter(grid.within_bounds(grid, _)),
    )
  })
  |> set.size
}

pub fn part2(s: String) {
  s
  |> common.lines
  |> list.length
}

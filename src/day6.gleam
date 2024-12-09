import common
import data/day6 as data
import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/set
import grid

pub fn main() {
  io.println("part1 answer:" <> { data.input() |> part1 |> int.to_string })
  io.println("part2 answer:" <> { data.input() |> part2 |> int.to_string })
}

type Direction {
  North
  South
  East
  West
}

fn rotate_90(direction) -> Direction {
  case direction {
    North -> East
    East -> South
    South -> West
    West -> North
  }
}

fn direction_delta(d: Direction) -> #(Int, Int) {
  case d {
    North -> #(0, -1)
    West -> #(-1, 0)
    South -> #(0, 1)
    East -> #(1, 0)
  }
}

type Space {
  Wall
  Empty
  Guard
}

type State {
  State(
    grid: grid.Grid(Space),
    visited: set.Set(#(Int, Int)),
    guard_pos: #(Int, Int),
    guard_direction: Direction,
  )
}

fn parse(s: String) -> grid.Grid(Space) {
  s
  |> grid.new(fn(c) {
    case c {
      "#" -> Ok(Wall)
      "." -> Ok(Empty)
      "^" -> Ok(Guard)
      _ -> Error(Nil)
    }
  })
}

fn new_state(s: String) -> State {
  let g = s |> parse
  let assert [#(guard_pos, _)] =
    g.data
    |> dict.filter(fn(_, val) {
      case val {
        Guard -> True
        _ -> False
      }
    })
    |> dict.to_list

  let g = g |> grid.set(guard_pos, Empty)

  State(
    grid: g,
    visited: set.from_list([guard_pos]),
    guard_pos: guard_pos,
    guard_direction: North,
  )
}

type Stop {
  OffMap
  Cycle
}

fn next_state(s: State) -> Result(State, Stop) {
  let next_pos =
    s.guard_pos |> common.move(s.guard_direction |> direction_delta)
  case next_pos |> grid.get(s.grid, _) {
    Ok(Wall) -> Ok(State(..s, guard_direction: s.guard_direction |> rotate_90))
    Ok(Empty) ->
      Ok(
        State(
          ..s,
          guard_pos: next_pos,
          visited: s.visited |> set.insert(next_pos),
        ),
      )
    Ok(Guard) -> todo
    Error(_) -> Error(OffMap)
  }
}

fn run(s: State) -> #(State, Stop) {
  case s |> next_state {
    Ok(s) -> run(s)
    Error(reason) -> #(s, reason)
  }
}

fn visited(s: String) {
  let state =
    s
    |> new_state
    |> run

  { state.0 }.visited
}

pub fn part1(s: String) {
  s |> visited |> set.size
}

pub fn part2(s: String) {
  // cycle if end back up at position going the same direction
  // check all places that we visited as our short list
  s
  |> common.lines
  |> list.length
}

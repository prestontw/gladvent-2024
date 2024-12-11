import common
import data/day6 as data
import gleam/bool
import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/option
import gleam/result
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

type State2 {
  State2(
    grid: grid.Grid(Space),
    visited: dict.Dict(#(Int, Int), set.Set(Direction)),
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

fn next_state2(s: State2) -> Result(State2, Stop) {
  let next_pos =
    s.guard_pos |> common.move(s.guard_direction |> direction_delta)
  use <- bool.guard(
    when: s.visited
      |> dict.get(s.guard_pos)
      |> result.lazy_unwrap(set.new)
      |> set.contains(s.guard_direction),
    return: Error(Cycle),
  )
  // update this to upsert
  let next_visited =
    s.visited
    |> dict.upsert(s.guard_pos, fn(val) {
      val
      |> option.lazy_unwrap(set.new)
      |> set.insert(s.guard_direction)
    })
  case next_pos |> grid.get(s.grid, _) {
    Ok(Wall) -> Ok(State2(..s, guard_direction: s.guard_direction |> rotate_90))
    Ok(Empty) -> Ok(State2(..s, guard_pos: next_pos, visited: next_visited))
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

fn run2(s: State2) -> #(State2, Stop) {
  case s |> next_state2 {
    Ok(s) -> run2(s)
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
  let visited = s |> visited
  let state = s |> new_state
  let assert [start_position] = state.visited |> set.to_list
  let obstacle_locations = visited |> set.delete(start_position)
  obstacle_locations
  |> set.filter(fn(obstacle_location) {
    let state =
      State2(
        grid: state.grid |> grid.set(obstacle_location, Wall),
        guard_pos: state.guard_pos,
        guard_direction: state.guard_direction,
        visited: dict.new(),
      )
    case state |> run2 {
      #(_, Cycle) -> True
      _ -> False
    }
  })
  |> set.size
}

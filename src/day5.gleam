import common
import data/day5 as data
import gleam/bool
import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/order
import gleam/result
import gleam/set

pub fn main() {
  io.println("part1 answer:" <> { data.input() |> part1 |> int.to_string })
  io.println("part2 answer:" <> { data.input() |> part2 |> int.to_string })
}

pub fn part1(s: String) {
  let assert [orderings, updates] = s |> common.paragraphs
  let orderings = orderings |> parse_orderings |> new_orderings
  let updates = updates |> parse_updates

  updates
  |> list.filter_map(fn(update) {
    let ordered =
      update
      |> common.fold_with_rest(True, fn(acc, first, rest) {
        acc
        && {
          rest
          |> list.all(fn(following) {
            orderings |> valid_ordering(first, following)
          })
        }
      })
    case ordered {
      True -> Ok(update |> middle_index)
      False -> Error(Nil)
    }
  })
  |> common.sum
}

type Orderings {
  Orderings(befores: dict.Dict(Int, set.Set(Int)))
}

fn new_orderings(orderings: List(#(Int, Int))) -> Orderings {
  let d =
    orderings
    |> list.fold(dict.new(), fn(d, ordering) {
      let #(x, y) = ordering
      let befores = d |> dict.get(x) |> result.unwrap(set.new())
      d |> dict.insert(x, befores |> set.insert(y))
    })

  Orderings(befores: d)
}

fn valid_ordering(o: Orderings, first, second) {
  o.befores
  |> dict.get(second)
  |> result.lazy_unwrap(set.new)
  |> set.contains(first)
  |> bool.negate
}

fn middle_index(update) {
  let positions = update |> common.dict_of_indices
  let assert Ok(value) =
    update |> list.length |> fn(l) { l / 2 } |> dict.get(positions, _)
  value
}

// for each item in updates, check to see if it exists in any item's after it ordering list

fn parse_orderings(s) {
  s
  |> common.lines
  |> list.map(fn(line) {
    let assert [before, after] = line |> common.separated_numbers("|")
    #(before, after)
  })
}

fn parse_updates(s) {
  s
  |> common.lines
  |> list.map(common.separated_numbers(_, ","))
}

pub fn part2(s: String) {
  // use list.sort and use ordering to create compare result

  let assert [orderings, updates] = s |> common.paragraphs
  let orderings = orderings |> parse_orderings |> new_orderings
  let updates = updates |> parse_updates

  updates
  |> list.filter(fn(update) {
    let ordered =
      update
      |> common.fold_with_rest(True, fn(acc, first, rest) {
        acc
        && {
          rest
          |> list.all(fn(following) {
            orderings |> valid_ordering(first, following)
          })
        }
      })
    !ordered
  })
  |> list.map(fn(update) {
    update
    |> list.sort(fn(a, b) {
      case orderings |> valid_ordering(a, b) {
        True -> order.Lt
        False -> order.Gt
      }
    })
    |> middle_index
  })
  |> common.sum
}

import common
import gleam/bool
import gleam/dict
import gleam/int
import gleam/list
import gleam/string

pub type Grid(item) {
  Grid(number_rows: Int, max_columns: Int, data: dict.Dict(#(Int, Int), item))
}

pub fn new(
  s: String,
  string_to_item: fn(String) -> Result(item, Nil),
) -> Grid(item) {
  let grid_lines = s |> common.lines
  let number_rows = grid_lines |> list.length
  let #(max_columns, data) =
    grid_lines
    |> list.index_fold(#(0, dict.new()), fn(acc, row, row_index) {
      let #(columns, data) = acc
      let max_columns = int.max(columns, row |> string.length)

      let data =
        row
        |> string.to_graphemes
        |> list.index_fold(data, fn(data, char, char_index) {
          case string_to_item(char) {
            Ok(item) -> data |> dict.insert(#(char_index, row_index), item)
            Error(_) -> data
          }
        })

      #(max_columns, data)
    })

  Grid(number_rows, max_columns, data)
}

pub fn get(g: Grid(item), pos: #(Int, Int)) -> Result(item, Nil) {
  g.data |> dict.get(pos)
}

pub fn set(g: Grid(item), pos: #(Int, Int), val: item) -> Grid(item) {
  Grid(..g, data: g.data |> dict.insert(pos, val))
}

pub fn within_bounds(g: Grid(item), pos: #(Int, Int)) -> Bool {
  pos.0 >= 0 && pos.0 < g.max_columns && pos.1 >= 0 && pos.1 < g.number_rows
}

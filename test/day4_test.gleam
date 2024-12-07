import data/day4 as data
import day4 as day
import gleeunit/should

// gleeunit test functions end in `_test`
pub fn part1_test() {
  day.part1(data.input())
  |> should.equal(2390)
}

pub fn part1_sample_test() {
  day.part1(
    "MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX",
  )
  |> should.equal(18)
}

pub fn part2_test() {
  day.part2(data.input())
  |> should.equal(1809)
}

pub fn part2_sample_test() {
  day.part2(
    "MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX",
  )
  |> should.equal(9)
}

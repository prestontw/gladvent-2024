import data/day6 as data
import day6 as day
import gleeunit/should

// gleeunit test functions end in `_test`
pub fn input_test() {
  day.part1(data.input())
  |> should.equal(4454)

  day.part2(data.input())
  |> should.equal(1)
}

pub fn sample_test() {
  let sample =
    "....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#..."
  day.part1(sample)
  |> should.equal(41)

  day.part2(sample)
  |> should.equal(6)
}

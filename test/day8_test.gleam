import data/day8 as data
import day8 as day
import gleeunit/should

// gleeunit test functions end in `_test`
pub fn part1_test() {
  day.part1(data.input())
  |> should.equal(259)
}

pub fn part1_sample_test() {
  day.part1(
    "............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............",
  )
  |> should.equal(14)
}

pub fn part2_test() {
  day.part2(data.input())
  |> should.equal(1)
}

pub fn part2_sample_test() {
  day.part2("")
  |> should.equal(1)
}
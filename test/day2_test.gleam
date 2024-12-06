import data/day2 as data
import day2 as day
import gleeunit/should

// gleeunit test functions end in `_test`
pub fn part1_test() {
  day.part1(data.input())
  |> should.equal(432)
}

pub fn part1_sample_test() {
  day.part1(
    "7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9",
  )
  |> should.equal(2)
}

pub fn part2_test() {
  day.part2(data.input())
  |> should.equal(488)
}

pub fn part2_sample_test() {
  day.part2(
    "7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9",
  )
  |> should.equal(4)
}

import data/day1 as data
import day1 as day
import gleeunit/should

// gleeunit test functions end in `_test`
pub fn part1_test() {
  day.part1(data.input())
  |> should.equal(1_530_215)
}

pub fn part1_sample_test() {
  day.part1(
    "3   4
4   3
2   5
1   3
3   9
3   3",
  )
  |> should.equal(11)
}

pub fn part2_test() {
  day.part2(data.input())
  |> should.equal(26_800_609)
}

pub fn part2_sample_test() {
  day.part2(
    "3   4
4   3
2   5
1   3
3   9
3   3",
  )
  |> should.equal(31)
}

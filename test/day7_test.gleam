import data/day7 as data
import day6_test
import day7 as day
import gleeunit/should

// gleeunit test functions end in `_test`
pub fn part1_test() {
  day.part1(data.input())
  |> should.equal(1_985_268_524_462)
}

pub fn part1_sample_test() {
  day.part1(
    "190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20",
  )
  |> should.equal(3749)
}

pub fn part2_test_() {
  let timeout_seconds = 60
  #(day6_test.Timeout, timeout_seconds, [
    fn() {
      day.part2(data.input())
      |> should.equal(1)
    },
  ])
}

pub fn part2_sample_test() {
  day.part2(
    "190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20",
  )
  |> should.equal(11_387)
}

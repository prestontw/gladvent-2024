import data/day3 as data
import day3 as day
import gleeunit/should

// gleeunit test functions end in `_test`
pub fn part1_test() {
  day.part1(data.input())
  |> should.equal(1)
}

pub fn part1_sample_test() {
  day.part1(
    "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))",
  )
  |> should.equal(161)
}

pub fn part2_test() {
  day.part2(data.input())
  |> should.equal(1)
}

pub fn part2_sample_test() {
  day.part2("")
  |> should.equal(1)
}

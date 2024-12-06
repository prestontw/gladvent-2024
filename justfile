_default: test

run day:
    gleam run -m {{day}}

test:
    gleam test

watch-test:
    watchexec -- gleam test

make-new-day day:
    cp src/day0.gleam src/{{day}}.gleam
    sed -i 's/day0/{{day}}/g' src/{{day}}.gleam

    cp test/day0_test.gleam test/{{day}}_test.gleam
    sed -i 's/day0/{{day}}/g' test/{{day}}_test.gleam

    cp src/data/day0.gleam src/data/{{day}}.gleam

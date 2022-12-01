(local aoc (require :aoc))
(local tests (require :tests))

(local days [1])

(match arg
  [nil] (each [_ day-number (ipairs days)]
          (aoc.run-day day-number))
  (where ["day" num] (tonumber num)) (aoc.run-day num)
  ["test" num] (os.exit (tests.run-test (assert (tonumber num))))
  ["test"] (os.exit (tests.run-tests)))

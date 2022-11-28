(local aoc (require :aoc))
(local tests (require :tests))

(local days [])

(match arg
  ["test" num] (os.exit (tests.run-test (assert (tonumber num))))
  ["test"] (os.exit (tests.run-tests))
  _ (each [_ day-number (ipairs days)]
      (aoc.run-day day-number)))

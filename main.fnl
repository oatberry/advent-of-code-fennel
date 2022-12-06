(local aoc (require :aoc))
(local tests (require :tests))
(local {: eprintf} (require :util))

(local days [1 2 3 4 5 6])

(fn usage []
  (eprintf "usage: aoc [DAYNUM | test [DAYNUM]]\n"))

(match arg
  [nil] (each [_ day-number (ipairs days)]
          (aoc.run-day day-number))
  ["test" day-num] (let [ok? (-> day-num
                                 tonumber
                                 (assert "command 'test' expects a number")
                                 tests.run-test)]
                     (when ok?
                       (eprintf "ok\n"))
                     (os.exit ok?))
  ["test"] (os.exit (tests.run-tests))
  (where [day-num] (tonumber day-num)) (aoc.run-day (tonumber day-num))
  _ (usage))

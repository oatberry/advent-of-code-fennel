(local aoc (require :aoc))
(local spec (require :spec))
(local {: eprintf} (require :util))

(fn check-result [day-number test-number part expected result]
  (let [ok (= result expected)]
    (when (not ok)
      (eprintf "test failed: day %d test %d part %d: expected %s, got %s\n"
               day-number test-number part expected result))
    ok))

(fn run-test [day-number]
  (let [day-spec (assert (. spec day-number))]
    (accumulate [all-ok true
                 test-number [raw-input [expected1 expected2]] (ipairs day-spec)]
      (let [day (aoc.load-day day-number)
            raw-input (match (type raw-input)
                        :function (raw-input)
                        _ raw-input)
            (soln1 soln2) (aoc.get-solutions day raw-input)
            ok1 (check-result day-number test-number 1 expected1 (soln1))
            ok2 (check-result day-number test-number 2 expected2 (soln2))]
        (and all-ok ok1 ok2)))))

(fn run-tests []
  (let [all-ok (accumulate [all-ok true
                            day-number (ipairs spec)]
                 (let [ok (run-test day-number)]
                   (and all-ok ok)))]
    (when all-ok
      (eprintf "all tests passed\n"))
    all-ok))

{: run-test
 : run-tests}

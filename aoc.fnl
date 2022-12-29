(local fennel (require :fennel))
(local https (require :ssl.https))
(local ltn12 (require :ltn12))

(local {: eprintf : new-timer} (require :util))

(local aoc {})

(fn input-filename [day-number]
  (: "inputs/day%02d.txt" :format day-number))

(fn show [soln]
  (match (type soln)
    :string soln
    _ (fennel.view soln)))

(var cookie nil)

(fn get-cookie []
  (or cookie
      (do (set cookie (with-open [f (assert (io.open "inputs/cookie"))]
                        (f:read :a)))
          cookie)))

(fn fetch-input [day-number]
  (eprintf "Downloading input for day %d...\n" day-number)
  (let [url (: "https://adventofcode.com/2022/day/%d/input" :format day-number)
        headers {:cookie (get-cookie)
                 :user-agent "git.sr.ht/~oats/aoc2022-fennel <thomas@berryhill.me>"}
        sink (-> day-number input-filename (io.open :w) ltn12.sink.file)
        _ (assert (https.request {: url : headers : sink}))]
    (aoc.read-input day-number)))

(fn aoc.run-solutions [day raw-input]
  (let [input (if day.parser
                  (day.parser raw-input)
                  raw-input)]
    (if day.solution
        (day.solution input)
        (values (day.part1 input) (day.part2 input)))))

(fn aoc.read-input [day-number]
  (let [f (io.open (input-filename day-number))]
    (if (= f nil)
        (fetch-input day-number)
        (let [raw-input (f:read :a)]
          (f:close)
          raw-input))))

(fn aoc.load-day [day-number]
  (fennel.dofile (: "days/day%02d.fnl" :format day-number)))

(fn aoc.test-parser [day-number ?raw-input]
  (let [day (aoc.load-day day-number)
        raw-input (or ?raw-input
                      (aoc.read-input day-number))
        input (if day.parser
                  (day.parser raw-input)
                  raw-input)]
    (match (type input)
      :function (icollect [v input] v)
      _ input)))

(fn aoc.run-day [day-number ?raw-input]
  (let [day (aoc.load-day day-number)
        raw-input (or ?raw-input (aoc.read-input day-number))
        timer (new-timer)
        (soln1 soln2) (aoc.run-solutions day raw-input)
        runtime-usec (timer.value)]
    (eprintf "Day %d:\n" day-number)
    (eprintf "  part 1: %s\n" (show soln1))
    (eprintf "  part 2: %s\n" (show soln2))
    (eprintf "  run time: %0.3f ms\n" (/ runtime-usec 1000))))

aoc

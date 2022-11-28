(local fennel (require :fennel))
(local https (require :ssl.https))
(local ltn12 (require :ltn12))

(local {: eprintf} (require :util))

(local aoc {})

(fn input-filename [day-number]
  (: "inputs/day%02d.txt" :format day-number))

(var cookie nil)

(fn get-cookie []
  (or cookie
      (do (set cookie (with-open [f (assert (io.open "inputs/cookie"))]
                        (f:read :a)))
          cookie)))

(fn fetch-input [day-number]
  (eprintf "Downloading input for day %d...\n" day-number)
  (let [url (: "https://adventofcode.com/2022/day/%d/input" :format day-number)
        headers {:cookie (get-cookie)}
        sink (-> day-number input-filename (io.open :w) ltn12.sink.file)
        _ (assert (https.request {: url : headers : sink}))]
    (aoc.read-input day-number)))

(fn aoc.get-solutions [day raw-input]
  (let [input (day.parser raw-input)]
    (if day.solution
        (let [(soln1 soln2) (day.solution input)]
          (values #soln1 #soln2))
        (values #(day.part1 input) #(day.part2 input)))))

(fn aoc.read-input [day-number]
  (let [f (io.open (input-filename day-number))]
    (if (= f nil)
        (fetch-input day-number)
        (let [raw-input (f:read :a)]
          (f:close)
          raw-input))))

(fn aoc.load-day [day-number]
  (fennel.dofile (: "days/day%02d.fnl" :format day-number)))

(fn aoc.test-parser [day-number]
  (let [day (aoc.load-day day-number)
        input (day.parser (aoc.read-input day-number))]
    (match (type input)
      :function (icollect [v input] v)
      _ input)))

(fn aoc.run-day [day-number]
  (let [day (aoc.load-day day-number)
        (soln1 soln2) (aoc.get-solutions day (aoc.read-input day-number))]
    (eprintf "Day %d:\n" day-number)
    (eprintf "  part 1: %s\n" (soln1))
    (eprintf "  part 2: %s\n" (soln2))))

aoc

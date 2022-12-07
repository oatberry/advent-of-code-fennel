;;; Advent of Code 2022 - Day 6
;;; In Which We Slice Strings
;;;
;;; I was kind of hoping this might be a general packet-framing problem, alas.
;;; All we need to do is write a generic find-first-group-of-N-unique-characters
;;; algorithm, which is what find-n-unique does!

(fn str->set [str]
  (collect [char (str:gmatch ".")] char true))

(fn table-size [t]
  (accumulate [size 0 _ (pairs t)] (+ size 1)))

(fn find-n-unique [n input]
  (fn loop [index]
    (let [substr (input:sub index (+ index n -1))
          chars (str->set substr)]
      (if (= (table-size chars) n)
          index
          (loop (+ index 1)))))
  (+ n -1 (loop 1)))

{:part1 (partial find-n-unique 4)
 :part2 (partial find-n-unique 14)}

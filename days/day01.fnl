;;; Advent of Code 2022 - Day 1
;;; In Which We Utilize Sorting
;;;
;;; Here we go! Ez-pz: sum each section of numbers, and then sort (in descending
;;; order) the sums to determine the most calorie-laden elves.

(fn parser [raw-input]
  (icollect [rations (string.gmatch (.. raw-input "\n") "(.-)\n\n")]
    (icollect [calories (string.gmatch rations "(%d+)")]
      (tonumber calories))))

(fn sum [nums]
  (accumulate [sum 0
               _ num (ipairs nums)]
    (+ sum num)))

(fn solution [input]
  (let [total-calories (icollect [_ nums (ipairs input)]
                         (sum nums))]
    (table.sort total-calories #(> $1 $2))
    (match total-calories
      [c1 c2 c3] (values c1 (+ c1 c2 c3)))))

{: parser
 : solution}

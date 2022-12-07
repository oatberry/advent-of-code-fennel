;;; Advent of Code 2022 - Day 4
;;; Ranges
;;;
;;; Pretty straightforward; compare the upper and lower bounds of both parts of
;;; each line to see what kind of overlap there is.

(fn parser [raw-input]
  (icollect [n1 n2 n3 n4 (raw-input:gmatch "(%d+)-(%d+),(%d+)-(%d+)")]
    [[(tonumber n1) (tonumber n2)] [(tonumber n3) (tonumber n4)]]))

(fn fully-contains? [[min1 max1] [min2 max2]]
  (and (<= min1 min2) (>= max1 max2)))

(fn overlap? [[min1 max1] [min2 max2]]
  (>= (math.min max1 max2) (math.max min1 min2)))

(fn part1 [input]
  (accumulate [count 0
               _ [range1 range2] (ipairs input)]
    (if (or (fully-contains? range1 range2)
            (fully-contains? range2 range1))
        (+ count 1)
        count)))

(fn part2 [input]
  (accumulate [count 0
               _ [range1 range2] (ipairs input)]
    (if (overlap? range1 range2)
        (+ count 1)
        count)))

{: parser
 : part1
 : part2}

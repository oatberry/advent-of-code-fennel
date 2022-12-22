;;; Advent of Code 2022 - Day 9
;;; In Which We Learn the Ropes

(fn parser [raw-input]
  (icollect [dir count (raw-input:gmatch "([UDLR]) (%d+)")]
    [dir (tonumber count)]))

(fn change-pos! [pos [dx dy]]
  (tset pos 1 (+ (. pos 1) dx))
  (tset pos 2 (+ (. pos 2) dy))
  pos)

(fn pos-delta [[x1 y1] [x2 y2]]
  (values (- x1 x2) (- y1 y2)))

(fn unit-vector [x y]
  [(if (= 0 x) 0 (// x (math.abs x)))
   (if (= 0 y) 0 (// y (math.abs y)))])

(fn make-rope-sim [knot-count]
  (var knots (fcollect [_ 1 knot-count] [0 0]))
  (var tail-visited {"0,0" true})

  (local dirs {:U [0 1] :D [0 -1] :L [-1 0] :R [1 0]})

  (fn record-tail-pos! []
    (let [[x y] (. knots knot-count)]
      (tset tail-visited (: "%s,%s" :format x y) true)))

  (fn move! [dir]
    (change-pos! (. knots 1) (. dirs dir))
    (for [i 1 (- knot-count 1)]
      (let [lead-knot (. knots i)
            follow-knot (. knots (+ i 1))
            (dx dy) (pos-delta lead-knot follow-knot)]
        (when (> (math.max (math.abs dx) (math.abs dy)) 1)
          (change-pos! follow-knot (unit-vector dx dy)))))
    (record-tail-pos!))

  (fn count-visited-positions []
    (accumulate [total 0
                 _ _ (pairs tail-visited)]
      (+ total 1)))

  {: move!
   : count-visited-positions})

(fn solve [knot-count directions]
  (local rope-sim (make-rope-sim knot-count))
  (each [_ [dir count] (ipairs directions)]
    (for [_ 1 count] (rope-sim.move! dir)))
  (rope-sim.count-visited-positions))

{: parser
 :part1 (partial solve 2)
 :part2 (partial solve 10)}

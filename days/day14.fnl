;;; Advent of Code 2022 - Day 14
;;; In Which We Taste The Air of Time Blown Past Falling Sands

(fn parser [raw-input]
  (icollect [line (raw-input:gmatch "[^\n]+")]
    (icollect [n1 n2 (line:gmatch "(%d+),(%d+)")]
      [(tonumber n1) (tonumber n2)])))

(fn max-key [tbl]
  (-> (icollect [k _ (pairs tbl)] k)
      (table.unpack)
      (math.max)))

(fn make-simulator [rock-paths]
  (local world [])

  (fn place! [x y item]
    (let [column (or (. world x) [])]
      (tset column y item)
      (tset world x column)))

  (fn draw-rock! [[x1 y1] [x2 y2]]
    (if (= x1 x2) (for [y (math.min y1 y2) (math.max y1 y2)]
                    (place! x1 y "#"))
        (= y1 y2) (for [x (math.min x1 x2) (math.max x1 x2)]
                    (place! x y1 "#"))))

  (each [_ path (ipairs rock-paths)]
    (for [i 1 (- (length path) 1)]
      (draw-rock! (. path i) (. path (+ i 1)))))

  (local floor-level (-> (icollect [_ column (pairs world)]
                           (max-key column))
                         (table.unpack)
                         (math.max)
                         (+ 2)))

  (fn blocked? [x y] (or (= y floor-level)
                         (not= nil (?. world x y))))

  (fn drop-sand! [x y]
    (if (not (blocked? x (+ y 1))) (drop-sand! x (+ y 1))
        (not (blocked? (- x 1) (+ y 1))) (drop-sand! (- x 1) (+ y 1))
        (not (blocked? (+ x 1) (+ y 1))) (drop-sand! (+ x 1) (+ y 1))
        (blocked? x y) false
        (do (place! x y "o")
            (if (= floor-level (+ y 1)) :floor true))))

  (var sand-dropped 0)
  (fn drop-sand-until! [predicate]
    (each [sand #(drop-sand! 500 0)
           &until (predicate sand)]
      (set sand-dropped (+ sand-dropped 1)))
    sand-dropped)

  {: drop-sand-until!})

(fn solution [rock-paths]
  (let [sim (make-simulator rock-paths)
        until-floor (sim.drop-sand-until! #(= $ :floor))
        until-blocked (sim.drop-sand-until! #(not $))]
    (values until-floor (+ until-blocked 1))))

{: parser : solution}

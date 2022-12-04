(fn parser [raw-input]
  (icollect [them me (raw-input:gmatch "(.) (.)")]
    [them me]))

(local score {:X 1 :Y 2 :Z 3})

(fn draw? [them me]
  (= (- (them:byte 1) 65)
     (- (me:byte 1) 88)))

(fn part1 [input]
  (accumulate [total-score 0
               _ moves (ipairs input)]
    (+ total-score (match moves
                     [:C :X] (+ 6 score.X)
                     [:A :Y] (+ 6 score.Y)
                     [:B :Z] (+ 6 score.Z)
                     [them me] (if (draw? them me)
                                   (+ 3 (. score me))
                                   (. score me))))))

(local lose {:A (. score :Z) :B (. score :X) :C (. score :Y)})
(local draw {:A (. score :X) :B (. score :Y) :C (. score :Z)})
(local win {:A (. score :Y) :B (. score :Z) :C (. score :X)})

(fn part2 [input]
  (accumulate [total-score 0
               _ moves (ipairs input)]
    (+ total-score (match moves
                     [them :X] (. lose them)
                     [them :Y] (+ 3 (. draw them))
                     [them :Z] (+ 6 (. win them))))))

{: parser
 : part1
 : part2}

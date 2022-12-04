(fn parser [raw-input]
  (icollect [them me (raw-input:gmatch "(.) (.)")]
    [(- (them:byte 1) 65) (- (me:byte 1) 88)]))

(fn scoring-part1 [them me]
  (let [outcome (-> me (- them) (+ 1) (% 3))
        bonus (* outcome 3)]
    (+ bonus me 1)))

(fn scoring-part2 [them outcome]
  (let [bonus (* outcome 3)
        me (-> outcome (- 1) (+ them) (% 3))]
    (+ bonus me 1)))

(fn solve [scoring input]
  (accumulate [total-score 0
               _ round (ipairs input)]
    (+ total-score (scoring (table.unpack round)))))

{: parser
 :part1 (partial solve scoring-part1)
 :part2 (partial solve scoring-part2)}

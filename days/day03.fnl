(fn str->set [str]
  (collect [char (string.gmatch str ".")] char true))

(fn element-is-in-all? [elem sets]
  (accumulate [result true
               _ s (ipairs sets)
               &until (not result)]
    (and result (. s elem))))

(fn intersection [first ...]
  (let [rest [...]]
    (collect [k (pairs first)]
      (when (element-is-in-all? k rest)
        (values k true)))))

(fn priority [letter]
  (- (letter:byte 1)
     (if (letter:match "[a-z]") 96 38)))

(fn part1 [input]
  (accumulate [priority-sum 0
               sack (input:gmatch "%S+")]
    (let [half-len (-> sack length (/ 2) (math.tointeger))
          item1 (str->set (sack:sub 1 half-len))
          item2 (str->set (sack:sub (+ half-len 1)))
          shared-item (next (intersection item1 item2))]
      (+ priority-sum (priority shared-item)))))

(fn part2 [input]
  (accumulate [priority-sum 0
               sack1 sack2 sack3 (input:gmatch "(%S+)\n(%S+)\n(%S+)")]
    (let [shared-item (next (intersection (str->set sack1)
                                          (str->set sack2)
                                          (str->set sack3)))]
      (+ priority-sum (priority shared-item)))))

{:parser (fn [x] x)
 : part1
 : part2}

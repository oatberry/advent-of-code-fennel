;;; Advent of Code 2022 - Day 13
;;; In Which We Order Packets

(fn tokenize [str]
  (var i 1)

  (fn peek [] (str:sub i i))

  (fn advance []
    (let [char (str:sub i i)]
      (set i (+ i 1))
      char))

  (fn next-token []
    (match (peek)
      "," (do (advance) (next-token))
      "[" (advance)
      "]" (advance)
      "" nil
      _ (-> (icollect [char peek &until (char:match "[^%d]")]
              (advance))
            (table.concat)))))

(fn parse-packet [next-token]
  (match (next-token)
    "[" (icollect [value #(parse-packet next-token)] value)
    "]" nil
    digits (tonumber digits)))

(fn parser [raw-input]
  (icollect [packet (raw-input:gmatch "[^\n]+")]
    (parse-packet (tokenize packet))))

(fn compare [v1 v2]
  (match [(type v1) (type v2)]
    [:nil _] :lt
    [_ :nil] :gt
    [:number :number] (if (< v1 v2) :lt (= v1 v2) :eq :gt)
    [:table :number] (compare v1 [v2])
    [:number :table] (compare [v1] v2)
    _ (do (fn loop [i]
            (if (<= i (math.max (length v1) (length v2)))
                (match (compare (. v1 i) (. v2 i))
                  :eq (loop (+ i 1))
                  order order)
                :eq))
          (loop 1))))

(fn part1 [packets]
  (fn loop [i]
    (if (<= i (length packets))
        (let [p1 (. packets (- i 1))
              p2 (. packets i)]
          (+ (match (compare p1 p2)
               :lt (// i 2)
               _ 0)
             (loop (+ i 2))))
        0))
  (loop 2))

(fn insert! [packets p]
  (fn loop [i]
    (if (= :lt (compare p (. packets i)))
        (do (table.insert packets i p)
            i)
        (loop (+ i 1))))
  (loop 1))

(fn part2 [packets]
  (table.sort packets #(= :lt (compare $1 $2)))
  (let [i1 (insert! packets [[2]])
        i2 (insert! packets [[6]])]
    (* i1 i2)))

{: parser : part1 : part2}

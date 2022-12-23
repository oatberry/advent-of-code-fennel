;;; Advent of Code 2022 - Day 11
;;; In Which We Monkey Around

(fn calculate-supermodulous [monkeys]
  (let [supermodulous (accumulate [product 1
                                   _ m (ipairs monkeys)]
                        (* product m.modulous))]
    (tset monkeys :supermodulous supermodulous)
    monkeys))

(fn parser [raw-input]
  (-> (icollect [raw-monkey (string.gmatch (.. raw-input "\n") "(.-)\n\n")]
        (let [items-line (raw-monkey:match "items: [^\n]+\n")
              items (icollect [item (items-line:gmatch "%d+")] (tonumber item))
              (lhs binop rhs) (raw-monkey:match "new = (%S+) ([%*%+]) (%S+)")
              modulous (tonumber (raw-monkey:match "divisible by (%d+)"))
              true-monkey (tonumber (raw-monkey:match "true:.-(%d)"))
              false-monkey (tonumber (raw-monkey:match "false:.-(%d)"))]
          {: items : modulous : true-monkey : false-monkey
           :inspected 0
           :expr [binop
                  (or (tonumber lhs) lhs)
                  (or (tonumber rhs) rhs)]}))
      (calculate-supermodulous)))

(fn eval-expr [[op lhs rhs] item]
  (let [lhs (match lhs :old item _ lhs)
        rhs (match rhs :old item _ rhs)]
    (match op "*" (* lhs rhs) "+" (+ lhs rhs))))

(fn round [part monkeys]
  (each [_ monkey (ipairs monkeys)]
    (each [item #(table.remove monkey.items 1)]
      (let [new-worry (eval-expr monkey.expr item)
            new-worry* (if (= part :part1)
                           (// new-worry 3)
                           (% new-worry monkeys.supermodulous))
            monkey-num (if (= 0 (% new-worry* monkey.modulous))
                           monkey.true-monkey
                           monkey.false-monkey)
            target-monkey-items (. monkeys (+ monkey-num 1) :items)]
        (table.insert target-monkey-items new-worry*)
        (set monkey.inspected (+ monkey.inspected 1))))))

(fn solution [part times input]
  (local monkeys (parser input))
  (for [_ 1 times] (round part monkeys))
  (let [counts (icollect [_ monkey (ipairs monkeys)]
                 monkey.inspected)]
    (table.sort counts #(> $1 $2))
    (match counts
      [a b] (* a b))))

{:part1 (partial solution :part1 20)
 :part2 (partial solution :part2 10000)}

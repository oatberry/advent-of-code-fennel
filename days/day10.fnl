;;; Advent of Code 2022 - Day 10
;;; In Which We Scan Lines

(fn parser [raw-input]
  (icollect [line (raw-input:gmatch "[^\n]+")]
    (icollect [word (line:gmatch "%S+")]
      (or (tonumber word) word))))

(fn make-cpu [program]
  (var cycles 1)
  (var pc 1)
  (var x 1)
  (var exec-counter 0)
  (var op #nil)

  (local instructions {:noop [1 #nil]
                       :addx [2 #(set x (+ x $))]})

  (fn fetch []
    (let [instr (. program pc)
          [exec-time op-fn] (. instructions (. instr 1))]
      (set op #(op-fn (select 2 (table.unpack instr))))
      (set exec-counter exec-time)
      (set pc (+ pc 1))))

  (fn next-pixel []
    (when (= exec-counter 0)
      (fetch))
    (set exec-counter (- exec-counter 1))
    (let [crt-column (-> cycles (- 1) (% 40))
          pixel-on? (or (= crt-column x)
                        (= crt-column (- x 1))
                        (= crt-column (+ x 1)))]
      (when (= exec-counter 0)
        (op))
      (set cycles (+ cycles 1))
      pixel-on?))

  (fn signal-strength-at [cycles*]
    (while (not= cycles cycles*)
      (next-pixel))
    (* cycles x))

  (fn next-screen-line []
    (table.concat (fcollect [i 1 40] (if (next-pixel) "#" "."))))

  {: signal-strength-at : next-screen-line})

(fn part1 [input]
  (let [cpu (make-cpu input)]
    (accumulate [sum 0
                 _ cycles (ipairs [20 60 100 140 180 220])]
      (+ sum (cpu.signal-strength-at cycles)))))

(fn part2 [input]
  (let [cpu (make-cpu input)
        crt-lines (fcollect [_ 1 6] (cpu.next-screen-line))]
    (string.format "\n%s" (table.concat crt-lines "\n"))))

{: parser
 : part1
 : part2}

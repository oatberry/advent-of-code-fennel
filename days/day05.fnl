(fn parse-stacks [raw-stacks]
  (let [num-stacks (tonumber (raw-stacks:match "(%d+) $"))
        lines (icollect [line (raw-stacks:gmatch " *%[[^\n]+")] line)
        stacks (fcollect [i 1 num-stacks] [])]
    (for [i (length lines) 1 -1]
      (let [crates (icollect [crate (string.gmatch (. lines i) ".(.)..?")]
                     crate)]
        (for [i 1 num-stacks]
          (when (not= (. crates i) " ")
            (table.insert (. stacks i) (. crates i))))))
    stacks))

(fn parse-instructions [raw-insts]
  (icollect [move from to (raw-insts:gmatch "move (%d+) from (%d+) to (%d+)")]
    [(tonumber move) (tonumber from) (tonumber to)]))

(fn parser [raw-input]
  (let [(stacks instructions) (raw-input:match "(.+)\n\n(.+)")]
    {:stacks (parse-stacks stacks)
     :instructions (parse-instructions instructions)}))

(fn copy-state [{: instructions : stacks}]
  {: instructions
   :stacks (icollect [_ stack (ipairs stacks)]
             (icollect [_ crate (ipairs stack)]
               crate))})

(fn secret-msg [stacks]
  (table.concat (icollect [_ stack (ipairs stacks)]
                  (table.remove stack))))

(fn part1 [input]
  (let [{: instructions : stacks} (copy-state input)]
    (each [_ [move from to] (ipairs instructions)]
      (for [i 1 move]
        (table.insert (. stacks to) (table.remove (. stacks from)))))
    (secret-msg stacks)))

(fn part2 [input]
  (let [{: instructions : stacks} (copy-state input)]
    (each [_ [move from to] (ipairs instructions)]
      (let [stack-len (length (. stacks from))]
        (for [i 1 move]
          (table.insert (. stacks to) (table.remove (. stacks from)
                                                    (+ stack-len (- move) 1))))))
    (secret-msg stacks)))

{: parser
 : part1
 : part2}

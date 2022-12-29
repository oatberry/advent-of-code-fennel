;;; Advent of Code 2022 - Day 12
;;; In Which We Search, Breadthily

(fn node [row col]
  (string.format "%s,%s" row col))

(fn neighbors [matrix row col]
  (let [adjs [[-1 0] [1 0] [0 -1] [0 1]]]
    (var i 0)
    #(do (set i (+ i 1))
         (match (. adjs i)
           [drow dcol] [(+ row drow) (+ col dcol)]))))

(fn elevation [height-code]
  (match height-code
    "S" (string.byte "a")
    "E" (string.byte "z")
    _ (string.byte height-code)))

(fn neighbor-reachable? [this-height neighbor-height]
  (and neighbor-height this-height
       (>= 1 (- (elevation neighbor-height) (elevation this-height)))))

(fn add-adj! [adj-lists [row col] [neighbor-row neighbor-col]]
  (match (. adj-lists (node row col))
    nil (tset adj-lists (node row col) [(node neighbor-row neighbor-col)])
    list (table.insert list (node neighbor-row neighbor-col))))

(fn parser [input]
  (let [matrix (icollect [line (input:gmatch "[^\n]+")]
                 (icollect [char (line:gmatch ".")]
                   char))
        forward-adjs {}
        backward-adjs {}
        graph {:forward #(or (. forward-adjs $) [])
               :backward #(or (. backward-adjs $) [])
               :node-height #(match (string.match $ "(%d+),(%d+)")
                               (row col) (-> matrix
                                             (. (tonumber row) (tonumber col))
                                             elevation))}]
    (for [row 1 (length matrix)]
      (for [col 1 (length (. matrix 1))]
        (match (. matrix row col)
          "S" (set graph.S (node row col))
          "E" (set graph.E (node row col)))
        (each [[n-row n-col] (neighbors matrix row col)]
          (let [this-height (. matrix row col)
                neighbor-height (?. matrix n-row n-col)]
            (when (neighbor-reachable? this-height neighbor-height)
              (add-adj! forward-adjs [row col] [n-row n-col])
              (add-adj! backward-adjs [n-row n-col] [row col]))))))
    graph))

(fn make-queue []
  (var tbl {:head 1 :tail 1})

  {:en (fn [v]
         (tset tbl tbl.tail v)
         (set tbl.tail (+ tbl.tail 1)))
   :de #(when (< tbl.head tbl.tail)
          (let [v (. tbl tbl.head)]
           (tset tbl tbl.head nil)
           (set tbl.head (+ tbl.head 1))
           v))})

(fn bfs [graph start end-predicate direction]
  (local adj-fn (. graph direction))
  (var seen {start true})
  (var queue (make-queue))

  (fn loop [[this-node steps]]
    (if (end-predicate this-node)
        steps
        (do (each [_ adj-node (ipairs (adj-fn this-node))]
              (when (not (. seen adj-node))
                (tset seen adj-node true)
                (queue.en [adj-node (+ steps 1)])))
            (-?> (queue.de) (loop)))))

  (loop [start 0]))

(fn part1 [graph]
  (bfs graph graph.S #(= $ graph.E) :forward))

(fn part2 [graph]
  (bfs graph graph.E #(= (graph.node-height $) 97) :backward))

{: parser
 : part1
 : part2}

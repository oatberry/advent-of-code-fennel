;;; Advent of Code 2022 - Day 8
;;; In Which We Survey Trees (the woody kind)

(fn parser [input]
  (let [trees (icollect [line (input:gmatch "[^\n]+")]
                (icollect [tree (line:gmatch ".")]
                  {:height (tonumber tree)
                   :visible? false}))]
    (set trees.n-rows (length trees))
    (set trees.n-cols (length (. trees 1)))

    (fn trees.point-in-bounds [trees row col]
      (and (> row 0) (> col 0) (<= row trees.n-rows) (<= col trees.n-cols)))

    (fn trees.set-tree-visibility! [trees row col]
      (let [tree (. trees row col)]
        (when (> tree.height trees.cur-height)
          (set tree.visible? true)
          (set trees.cur-height tree.height))))

    (fn trees.count-visible [trees]
      (var n-visible 0)
      (each [_ row (ipairs trees)]
        (each [_ tree (ipairs row)]
          (when tree.visible? (set n-visible (+ n-visible 1)))))
      n-visible)

    (fn trees.score-direction [trees row col [d-row d-col]]
      (local tree-height (. trees row col :height))
      (fn loop [row col count]
        (let [row (+ row d-row) col (+ col d-col)]
          (if (not (trees:point-in-bounds row col))
              count

              (>= (. trees row col :height) tree-height)
              (+ count 1)

              (loop row col (+ count 1)))))
      (loop row col 0))

    (fn trees.scenic-score [trees row col]
      (accumulate [score 1
                   _ sight-vector (ipairs [[-1 0] [0 1] [1 0] [0 -1]])]
        (* score (trees:score-direction row col sight-vector))))

    (fn trees.traverse! [trees proc
                         outer-end
                         inner-start inner-end inner-dir]
      (for [outer 1 (or outer-end trees.n-rows)]
        (set trees.cur-height -1)
        (for [inner (or inner-start 1) (or inner-end trees.n-cols) (or inner-dir 1)]
          (proc outer inner))))

    trees))

(fn part1 [trees]
  (let [rows-then-cols #(trees:set-tree-visibility! $1 $2)
        cols-then-rows #(trees:set-tree-visibility! $2 $1)
        traversals {:west-east [rows-then-cols
                                trees.n-rows
                                1 trees.n-cols 1]
                    :north-south [cols-then-rows
                                  trees.n-cols
                                  1 trees.n-rows 1]
                    :east-west [rows-then-cols
                                trees.n-rows
                                trees.n-cols 1 -1]
                    :south-north [cols-then-rows
                                  trees.n-cols
                                  trees.n-rows 1 -1]}]
    (each [_ traversal (pairs traversals)]
      (trees:traverse! (table.unpack traversal)))

    (trees:count-visible)))

(fn part2 [trees]
  (var scores [])
  (trees:traverse! #(table.insert scores (trees:scenic-score $1 $2)))
  (math.max (table.unpack scores)))

{: parser
 : part1
 : part2}

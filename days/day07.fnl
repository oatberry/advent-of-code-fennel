;;; Advent of Code 2022 - Day 7
;;; In Which We Plant Trees
;;;
;;; For the parsing stage, I wrote a simple lil tree generator that takes in the
;;; "shell session" one line and a time and cobbles together the shape of the FS
;;; tree, moving up and down as `cd` and `ls` reveal its structure and file
;;; sizes!
;;;
;;; Both parts are solved at near the same time. `solution` walks through tree,
;;; recursively talling up all the directories' sizes and storing them in a
;;; list, which we then sort for the convenience of part 2.
;;;
;;; Part 1 only needs us to walk through the list of dir sizes and sum up the
;;; ones with size <= 100,000. Part 2 searches through the sorted list of sizes
;;; until it comes to the first one that's large enough that, when deleted, will
;;; meet the needed amount of free space!

(fn words [line]
  (icollect [word (line:gmatch "%S+")]
    word))

(fn parser [raw-input]
  (local root {})
  (var cwd root)
  (each [line (raw-input:gmatch "[^\n]+")]
    (match (words line)
      ["$" "ls"] nil
      ["$" "cd" "/"] (set cwd root)
      ["$" "cd" dir] (set cwd (. cwd dir))
      ["dir" dir] (tset cwd dir {".." cwd})
      [size file] (tset cwd file (tonumber size))))
  root)

(fn part1 [dir-sizes]
  (accumulate [sum 0
               _ size (ipairs dir-sizes)]
    (if (> size 100_000) sum (+ sum size))))

(fn part2 [dir-sizes]
  (local free-space (- 70_000_000 (. dir-sizes (length dir-sizes))))
  (fn loop [i]
    (let [free-space* (+ free-space (. dir-sizes i))]
      (if (< free-space* 30_000_000)
          (loop (+ i 1))
          (. dir-sizes i))))
  (loop 1))

(fn solution [fs-tree]
  (local dir-sizes [])
  (fn dir-size [node]
    (let [size (accumulate [size 0
                            name dir-or-size (pairs node)]
                 (if (= name "..")
                     size
                     (+ size (match (type dir-or-size)
                               :number dir-or-size
                               :table (dir-size dir-or-size)))))]
      (table.insert dir-sizes size)
      size))

  (dir-size fs-tree)
  (table.sort dir-sizes)
  (values (part1 dir-sizes) (part2 dir-sizes)))

{: parser
 : solution}

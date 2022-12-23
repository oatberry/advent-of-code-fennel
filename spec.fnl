(local aoc (require :aoc))

{1 [["1000\n2000\n3000\n\n4000\n\n5000\n6000\n\n7000\n8000\n9000\n\n10000\n"
     [24000 45000]]

    [#(aoc.read-input 1)
     [66487 197301]]]

 2 [["A Y\nB X\nC Z\n"
     [15 12]]

    [#(aoc.read-input 2)
     [12156 10835]]]

 3 [["vJrwpWtwJgWrhcsFMMfFFhFp\njqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL\nPmmdzqPrVvPwwTWBwg\nwMqvLMZHhHMvwLHjbvcjnnSBnvTQFn\nttgJtRGJQctTZtZT\nCrZsJsPPZsGzwwsLwLmpwMDw\n"
     [157 70]]

    [#(aoc.read-input 3)
     [7737 2697]]]

 4 [["2-4,6-8\n2-3,4-5\n5-7,7-9\n2-8,3-7\n6-6,4-6\n2-6,4-8\n"
     [2 4]]

    [#(aoc.read-input 4)
     [526 886]]]

 5 [["    [D]    \n[N] [C]    \n[Z] [M] [P]\n 1   2   3 \n\nmove 1 from 2 to 1\nmove 3 from 1 to 3\nmove 2 from 2 to 1\nmove 1 from 1 to 2\n"
     ["CMZ" "MCD"]]

    [#(aoc.read-input 5)
     ["RNZLFZSJH" "CNSFCGJSM"]]]

 6 [["mjqjpqmgbljsphdztnvjfqwrcgsmlb"
     [7 19]]
    ["bvwbjplbgvbhsrlpgdmjqwftvncz"
     [5 23]]
    ["nppdvjthqldpwncqszvftbrmjlhg"
     [6 23]]
    ["nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"
     [10 29]]
    ["zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"
     [11 26]]

    [#(aoc.read-input 6)
     [1542 3153]]]

 7 [["$ cd /\n$ ls\ndir a\n14848514 b.txt\n8504156 c.dat\ndir d\n$ cd a\n$ ls\ndir e\n29116 f\n2557 g\n62596 h.lst\n$ cd e\n$ ls\n584 i\n$ cd ..\n$ cd ..\n$ cd d\n$ ls\n4060174 j\n8033020 d.log\n5626152 d.ext\n7214296 k\n"
     [95437 24933642]]

    [#(aoc.read-input 7)
     [1453349 2948823]]]

 8 [["30373\n25512\n65332\n33549\n35390\n"
     [21 8]]

    [#(aoc.read-input 8)
     [1715 374400]]]

 9 [["R 4\nU 4\nL 3\nD 1\nR 4\nD 1\nL 5\nR 2\n"
     [13 1]]

    ["R 5\nU 8\nL 8\nD 3\nR 17\nD 10\nL 25\nU 20\n"
     [88 36]]

    [#(aoc.read-input 9)
     [6018 2619]]]

 10 [["addx 15\naddx -11\naddx 6\naddx -3\naddx 5\naddx -1\naddx -8\naddx 13\naddx 4\nnoop\naddx -1\naddx 5\naddx -1\naddx 5\naddx -1\naddx 5\naddx -1\naddx 5\naddx -1\naddx -35\naddx 1\naddx 24\naddx -19\naddx 1\naddx 16\naddx -11\nnoop\nnoop\naddx 21\naddx -15\nnoop\nnoop\naddx -3\naddx 9\naddx 1\naddx -3\naddx 8\naddx 1\naddx 5\nnoop\nnoop\nnoop\nnoop\nnoop\naddx -36\nnoop\naddx 1\naddx 7\nnoop\nnoop\nnoop\naddx 2\naddx 6\nnoop\nnoop\nnoop\nnoop\nnoop\naddx 1\nnoop\nnoop\naddx 7\naddx 1\nnoop\naddx -13\naddx 13\naddx 7\nnoop\naddx 1\naddx -33\nnoop\nnoop\nnoop\naddx 2\nnoop\nnoop\nnoop\naddx 8\nnoop\naddx -1\naddx 2\naddx 1\nnoop\naddx 17\naddx -9\naddx 1\naddx 1\naddx -3\naddx 11\nnoop\nnoop\naddx 1\nnoop\naddx 1\nnoop\nnoop\naddx -13\naddx -19\naddx 1\naddx 3\naddx 26\naddx -30\naddx 12\naddx -1\naddx 3\naddx 1\nnoop\nnoop\nnoop\naddx -9\naddx 18\naddx 1\naddx 2\nnoop\nnoop\naddx 9\nnoop\nnoop\nnoop\naddx -1\naddx 2\naddx -37\naddx 1\naddx 3\nnoop\naddx 15\naddx -21\naddx 22\naddx -6\naddx 1\nnoop\naddx 2\naddx 1\nnoop\naddx -10\nnoop\nnoop\naddx 20\naddx 1\naddx 2\naddx 2\naddx -6\naddx -11\nnoop\nnoop\nnoop\n"
      [13140 "
##..##..##..##..##..##..##..##..##..##..
###...###...###...###...###...###...###.
####....####....####....####....####....
#####.....#####.....#####.....#####.....
######......######......######......####
#######.......#######.......#######....."]]

     [#(aoc.read-input 10)
      [13180 "
####.####.####..##..#..#...##..##..###..
#.......#.#....#..#.#..#....#.#..#.#..#.
###....#..###..#....####....#.#..#.###..
#.....#...#....#....#..#....#.####.#..#.
#....#....#....#..#.#..#.#..#.#..#.#..#.
####.####.#.....##..#..#..##..#..#.###.."]]]}

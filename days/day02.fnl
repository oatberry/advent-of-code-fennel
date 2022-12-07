;;; Advent of Code 2022 - Day 2
;;; In Which I "Discover" the Math of Rock, Paper, Scissors
;;;
;;; I first implemented a quick-n-dirty solution utilizing Fennel's excellent
;;; `match` macro, but was a little unsatisfied that so much code was needed for
;;; what felt like a relatively simple problem. After glancing at others'
;;; solutions in r/adventofcode and seeing the phrase "modular arithmetic", I
;;; immediately ran back to the drawing board to figure out the math of Rock,
;;; Paper, Scissors (for short, RPS) and bang out a more concise solution.
;;;
;;; It turns out we can treat each move of RPS as a number in the integers
;;; modulo 3. For example: {0, 1, 2} with 0 representing Rock, 1 representing
;;; Paper, and 2 representing scissors. Conventiently this closely tracks with
;;; the A,B,C and X,Y,Z representation in the puzzle input.
;;;
;;; The main observation here is that given an integer (a move) in this set, we
;;; can find the move that it beats by subtracting 1, and the move that it loses
;;; to by adding 1. Using this info, we can infer that subtracting one move from
;;; another will tell us whether it is +1 away from the other move (winning) or
;;; -1 away (losing); though we should think 2 instead of -1 (as we're working
;;; with the integers modulo 3). And of course, 0 means we have a draw.
;;;
;;; Now for the next "convenient" occurence, we can observe that the bonus
;;; scores laid out by the puzzle (0 for losing, 3 for draw, and 6 for winning)
;;; happen to be what you get when you multiply 0, 1, and 2 each by 3! (not
;;; modulo 3) However, we determined that 0 corresponds to a draw, 1 to
;;; winning, and 2 to losing. We can easily map this onto the desired values by
;;; cycling them each one to the right, adding 1. The point score of our move is
;;; found by simply adding one to the move, not modulo 3.
;;;
;;; Now, if we let T = their move and M = our move, the formula for deciding a
;;; score of a round of RPS is: 3 * ((M - T + 1) mod 3) + M + 1
;;;
;;; For part 2 of the puzzle, armed with our new knowledge, we can easily
;;; determine which move to play to get the desired outcome by taking their
;;; move, adding the desired outcome minus 1, with the magic of modulo 3 landing
;;; us on the move that meets the wanted outcome.

(fn parser [raw-input]
  (icollect [them me (raw-input:gmatch "(.) (.)")]
    [(- (them:byte 1) 65) (- (me:byte 1) 88)]))

(fn scoring-part1 [them me]
  (let [outcome (-> me (- them) (+ 1) (% 3))
        bonus (* outcome 3)]
    (+ bonus me 1)))

(fn scoring-part2 [them outcome]
  (let [bonus (* outcome 3)
        me (-> them (+ outcome) (- 1) (% 3))]
    (+ bonus me 1)))

(fn solve [scoring input]
  (accumulate [total-score 0
               _ round (ipairs input)]
    (+ total-score (scoring (table.unpack round)))))

{: parser
 :part1 (partial solve scoring-part1)
 :part2 (partial solve scoring-part2)}

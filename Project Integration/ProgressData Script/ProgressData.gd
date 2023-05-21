extends Node

enum puzzle_types {MailboxPuzzle, BuildingPoweringPuzzle, MechanicPuzzle, SantaClausPuzzle}

var lessons_unlocked = [1] #[1, 2, 3]
# if lesson 2 is unlocked, lesson 1 is complete
# if lesson 3 is unlocked, lesson 2 is complete
var lesson_3_completed: bool = false #true

var lesson_1_puzzles_unlocked = [puzzle_types.MailboxPuzzle]
var lesson_2_puzzles_unlocked = [] #[puzzle_types.BuildingPoweringPuzzle, puzzle_types.MechanicPuzzle, puzzle_types.SantaClausPuzzle]
var lesson_3_puzzles_unlocked = [] #[puzzle_types.BuildingPoweringPuzzle, puzzle_types.MechanicPuzzle, puzzle_types.SantaClausPuzzle]

# Lesson 1
var mailbox_levels_unlocked = [1] #[1, 2, 3]

# Lesson 2
var building_powering_levels_unlocked = [] #[1, 2, 3]
var mechanic_levels_unlocked = [] #[1, 2, 3]
var santa_claus_levels_unlocked = [] #[1]

# Lesson 3
var building_powering_vf_levels_unlocked = [] #[3]
var mechanic_vf_levels_unlocked = [] #[3]
var santa_claus_vf_levels_unlocked = []
var level_lost_last = [0, 0, 0, 0] #[0, 3, 3, 0]

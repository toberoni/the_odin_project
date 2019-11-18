# Knight's Travails

This exercise is part of the [The Odin Project](http://www.theodinproject.com/courses/ruby-programming/lessons/data-structures-and-algorithms).

A knight in chess can move to any square on the standard 8x8 chess board from any other square on the board, given enough turns ([see this animation](https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Knight%27s_tour_anim_2.gif/250px-Knight%27s_tour_anim_2.gif)).

Its basic move is two steps forward and one step to the side. It can face any direction.

## What it does

The `knight_moves()` function takes two arrays as an input, where `knight_moves([start_position],[end_position])`, and returns the shortest path from one location to another.
For example:
- `knight_moves([0,0],[1,2]) #=> [[0,0],[1,2]]`
- `knight_moves([0,0],[3,3]) #=> [[0,0],[1,2],[3,3]]`
- `knight_moves([3,3],[0,0]) #=> [[3,3], [2,1], [0,0]]`
- `knight_moves([0,0],[7,7]) #=> [[0,0], [1,2], [0,4], [1,6], [3,7], [5,6], [7,7]]`

---

Example output:

```
irb> knight.knight_moves([3,3], [4,3])
The knight needs at least 3 turn(s) to reach this position.
[3,3]
[4,5]
[2,4]
[4,3]
```

## How it works

To find a path, this script builds a tree of nested valid moves. 

- A valid move ends inside a 8x8 chessboard.
- Breadth-first search is performed to find the end coordinates.
- If a tree's node & the end have the same coordinates, a path (containing all its parent nodes) is printed.

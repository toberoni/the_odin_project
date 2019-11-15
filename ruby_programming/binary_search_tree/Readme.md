# Binary Search Trees

Part of [The Odin Project Curriculum](https://www.theodinproject.com/courses/ruby-programming/lessons/data-structures-and-algorithms).

## Task

Build a simple binary search tree in this assignment. In this lesson, our tree won’t handle duplicate values as they are more complicated and result in trees that are much harder to balance. Be sure to always remove duplicate values or check for an existing value before inserting.

## Implementation

A `Node` class.

A `Tree` class which accepts an array when initialized.

An `#insert` and `#delete` method which accepts a value to insert/delete.

A `#find` method which accepts a value and returns the node with the given value.

A `#level_order` method which accepts a block. The method traverses the tree in breadth-first level order and yields each node to the provided block. This method is implemented using iteration and recursion. The method returns an array of values if no block is given.

`#inorder`, `#preorder`, and `#postorder` methods which accept a block. Each method traverses the tree in their respective depth-first order and yields each node to the provided block. Returns an array of values if no block is given.

A `#depth` method which accepts a node and returns the depth(number of levels) beneath the node.

A `#balanced?` method which checks if the tree is balanced. A balanced tree is one where the difference between heights of left subtree and right subtree is not more than 1.

A `#rebalance!` method which rebalances an unbalanced tree.

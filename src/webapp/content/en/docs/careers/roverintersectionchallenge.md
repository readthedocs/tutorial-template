---
title: "Rover Intersection Challenge"
description: ""
lead: ""
date: 2022-02-25T14:40:56+01:00
lastmod: 2022-02-25T14:40:56+01:00
draft: false
images: []
menu:
  docs:
    parent: "careers"
type: docs
weight: 2
---


### We would like you to complete the following Rover Intersection Challenge

A squad of robotic rovers are to be landed by NASA on a plateau on Mars.

This plateau, which is curiously rectangular, must be navigated by the rovers so that their onboard cameras can get a complete view of the surrounding terrain to send back to Earth.

A rover's position is represented by a combination of x and y coordinates. The plateau is divided up into a grid to simplify navigation. An example position might be `0, 0` which means the rover is in the bottom left corner.

In order to control a rover, NASA sends a simple string of letters. The possible letters are `'N'(Up)`, `'S'(Down)`, `'E'(Right)`, and `'W'(Left)` which makes the rover move one block in that direction

The movements have the following effect on the rover position
- N : (x, y+1)
- S : (x, y-1)
- E : (x+1, y)
- W : (x-1, y)

#### Input

The first line of input is the upper-right coordinates of the plateau, the lower-left coordinates are assumed to be `0, 0`.

The rest of the input is information pertaining to the rovers that have been deployed. Each rover has two lines of input. The first line gives the rover's initial position, and the second line is a series of instructions telling the rover how to explore the plateau.

The position is made up of two integers, corresponding to the x and y coordinates.

#### Output

The output of the program should be the intersection points of the rovers

### Your objectives

- It is your job to write code that will execute the commands from the input and identify the intersection paths of the rovers
- You can write the code in whatever language/framework you prefer.
- You should try not to spend more than 4 hours on the assignment and you can submit it whenever you have the time.
- Please make sure your code is pushed to github.com for review and share the link once you are done.
- In the readme file please include instructions on how one would build and run your code with an example.

#### Example Test Input
```
4 4 // The upper-right coordinates of the plateau 
0 2 // The first rover's initial position
NEESSS // The series of instructions telling the first rover how to explore the plateau
4 1 // The second rover's initial position
WWWNNNEEE // The series of instructions telling the second rover how to explore the plateau
```
#### Example Expected Output
```
2 1 // Intersection point 1
1 3 // Intersection point 2
```
#### Visual representation
```
.+--0
+*+..
X||..
.+*-X
..0..
```
```
Legend:
X : Start
0 : End
. : Empty
+ : Turn
|, - : Linear Movement
* : Intersection
```
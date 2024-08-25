extends Node
#VARIABLE 
var Cycle = 0

func newGame():
	Cycle = 1

func endCycle():
	Cycle += 1

func getCycle():
	return Cycle

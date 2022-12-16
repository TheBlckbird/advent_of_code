import Foundation

@main
public struct DayNine {

    struct Position: Equatable {
        var x: Int
        var y: Int
    }
    
    // struct PositionsRope {
    //     var head: Position
    //     var tail: Position
    // }

    struct PositionsRope: Equatable {
        var knots: [Position]
    }
    
    
    public static func main() {
        let dayNine = DayNine()

        let example: String = """
        R 4
        U 4
        L 3
        D 1
        R 4
        D 1
        L 5
        R 2
        """

        let input: [String] = dayNine.parseInput(input: PuzzleInput().input)
        // let input: [String] = dayNine.parseInput(input: example)
        var totalScore: Int = 0
        var totalScoreLongRope: Int = 0
        var totalSteps: Int = 0

        var visitedPositionsShortRope: [Position] = []
        var shortRope: PositionsRope = PositionsRope(knots: [Position(x: 0, y: 0), Position(x: 0, y: 0)])

        var visitedPositionsLongRope: [Position] = []
        var longRope: PositionsRope = PositionsRope(knots: [Position(x: 0, y: 0), Position(x: 0, y: 0),Position(x: 0, y: 0), Position(x: 0, y: 0),Position(x: 0, y: 0), Position(x: 0, y: 0),Position(x: 0, y: 0), Position(x: 0, y: 0),Position(x: 0, y: 0), Position(x: 0, y: 0)])

        for line in input {
            let instructions = line.components(separatedBy: " ")
            // print(instructions)
            let steps: Int = Int(instructions[1]) ?? 0
            let direction: Character = Character(instructions[0])

            for _ in 0..<steps {
                shortRope = dayNine.moveRope(direction: direction, positions: shortRope)
                longRope = dayNine.moveRope(direction: direction, positions: longRope)

                if !visitedPositionsShortRope.contains(shortRope.knots[1]) {
                    totalScore += 1
                    visitedPositionsShortRope.append(shortRope.knots[1])
                }

                if !visitedPositionsLongRope.contains(longRope.knots[9]) {
                    totalScoreLongRope += 1
                    visitedPositionsLongRope.append(longRope.knots[9])
                }

                

            }

            totalSteps += steps
            
        }

        print("Part 1: \(totalScore)")
        print("Part 2: \(totalScoreLongRope)")
        print("Total Steps: \(totalSteps)")

    }

    func moveRope(direction: Character, positions: PositionsRope) -> PositionsRope {

        var newPositions: PositionsRope = positions

        switch direction {
        case "R":
            newPositions.knots[0].x += 1                

        case "L":
            newPositions.knots[0].x -= 1

        case "U":
            newPositions.knots[0].y += 1

        case "D":
            newPositions.knots[0].y -= 1

        default:
            print("Error")
        }

        newPositions = moveTail(positions: newPositions)

        return newPositions
    }

    func moveTail(positions: PositionsRope) -> PositionsRope {
        
        var newPositions: PositionsRope = positions

        for i in 0..<positions.knots.count {

            if i == 0 {
                continue
            }

            if (
                // (positions.tail.x == positions.head.x && positions.tail.y == positions.head.y) ||
                // (positions.tail.x == positions.head.x && positions.tail.y == positions.head.y + 1) ||
                // (positions.tail.x == positions.head.x && positions.tail.y == positions.head.y - 1) ||
                // (positions.tail.x == positions.head.x + 1 && positions.tail.y == positions.head.y) ||
                // (positions.tail.x == positions.head.x - 1 && positions.tail.y == positions.head.y) ||
                // (positions.tail.x == positions.head.x + 1 && positions.tail.y == positions.head.y + 1) ||
                // (positions.tail.x == positions.head.x - 1 && positions.tail.y == positions.head.y - 1) ||
                // (positions.tail.x == positions.head.x + 1 && positions.tail.y == positions.head.y - 1) ||
                // (positions.tail.x == positions.head.x - 1 && positions.tail.y == positions.head.y + 1)
                (abs(newPositions.knots[i - 1].x - newPositions.knots[i].x) <= 1 && abs(newPositions.knots[i - 1].y - newPositions.knots[i].y) <= 1)
            ) {
                // print("\(newPositions): no change")
                return newPositions
            }

            if newPositions.knots[i - 1].x > newPositions.knots[i].x && newPositions.knots[i - 1].y == newPositions.knots[i].y {
                newPositions.knots[i].x += 1 //

            } else if newPositions.knots[i - 1].x < newPositions.knots[i].x && newPositions.knots[i - 1].y == newPositions.knots[i].y {
                newPositions.knots[i].x -= 1

            } else if newPositions.knots[i - 1].y > newPositions.knots[i].y && newPositions.knots[i - 1].x == newPositions.knots[i].x {
                newPositions.knots[i].y += 1 //

            } else if newPositions.knots[i - 1].y < newPositions.knots[i].y && newPositions.knots[i - 1].x == newPositions.knots[i].x {
                newPositions.knots[i].y -= 1

            } else {
                let xDifference: Int = newPositions.knots[i - 1].x - newPositions.knots[i].x
                let yDifference: Int = newPositions.knots[i - 1].y - newPositions.knots[i].y
                // print(xDifference)
                // print(yDifference)

                newPositions.knots[i].x -= xDifference < 0 ? 1 : -1
                newPositions.knots[i].y -= yDifference < 0 ? 1 : -1

                // if abs(xDifference) > abs(yDifference) {
                //     if xDifference > 0 {
                //         newPositions.tail.x += 1
                //     } else {
                //         newPositions.tail.x -= 1
                //     }

                // } else {
                //     if yDifference > 0 {
                //         newPositions.tail.y += 1
                //     } else {
                //         newPositions.tail.y -= 1
                //     }
                // }
            }

        }

        // print(newPositions)

        return newPositions
        
    }

    func parseInput(input: String) -> [String] {
        let inputArray = input.components(separatedBy: CharacterSet.newlines)

        return inputArray
    }
}

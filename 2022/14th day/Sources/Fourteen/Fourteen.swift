import Foundation

@main
public struct Fourteen {

    struct CoordinateSystemStuff {
        var coordinateSystem: [[Character]]
        var initialSandCoordinates: Position
    }

    struct Position {
        var x: Int
        var y: Int
    }

    public static func main() {
        let this: Fourteen = Fourteen()

        // let input: [[[String]]] = this.parseInput(input: PuzzleInput.example)
        let input: [[[String]]] = this.parseInput(input: PuzzleInput.input)

        var totalSand: Int = 0
        
        var coordinateSystemStuff: CoordinateSystemStuff = this.createCoordinateSystem(input: input)
        // this.showCoordinateSystem(coordinateSystemStuff: coordinateSystemStuff)

        var sandPosition: Position = coordinateSystemStuff.initialSandCoordinates

        // while true {
        //     sandPosition = this.sandFall(coordinateSystemStuff: coordinateSystemStuff)

        //     coordinateSystemStuff.coordinateSystem[sandPosition.y][sandPosition.x] = "o"
        //     // this.showCoordinateSystem(coordinateSystemStuff: coordinateSystemStuff)

        //     totalSand += 1
        //     // print("Part 1: \(totalSand)")
        //     // if sandPosition.y >= coordinateSystemStuff.coordinateSystem.count - 1 {
        //     //     print("Part 1: \(totalSand)")
        //     //     break
        //     // }
        // }

        var coordinateSystemStuff2: CoordinateSystemStuff = this.createCoordinateSystem(input: input, part2: true)

        while true {
            sandPosition = this.sandFall(coordinateSystemStuff: coordinateSystemStuff2, part2: true)

            coordinateSystemStuff2.coordinateSystem[sandPosition.y][sandPosition.x] = "o"
            this.showCoordinateSystem(coordinateSystemStuff: coordinateSystemStuff)

            totalSand += 1
            // if sandPosition.y >= coordinateSystemStuff.coordinateSystem.count - 1 {
            //     print("Part 1: \(totalSand)")
            //     break
            // }
        }

            print("Part 2: \(totalSand + 1)")
        this.showCoordinateSystem(coordinateSystemStuff: coordinateSystemStuff)
    }

    func sandFall(coordinateSystemStuff: CoordinateSystemStuff, part2: Bool = false) -> Position {
        var x: Int = coordinateSystemStuff.initialSandCoordinates.x
        var y: Int = coordinateSystemStuff.initialSandCoordinates.y

        let coordinateSystem: [[Character]] = coordinateSystemStuff.coordinateSystem
        


        while true {
            // print("looped", terminator: " ")

            if y + 1 > coordinateSystem.count || x + 1 > coordinateSystem[0].count || x - 1 < 0 {
                print("out of bounds")
                return Position(x: x, y: y + 1)
            }

            if coordinateSystem[y + 1][x] == " " {
                // return Position(x: x, y: y + 1)
                y += 1
                continue
            }

            if coordinateSystem[y + 1][x - 1] == " " {
                // return Position(x: x - 1, y: y + 1)
                x -= 1
                y += 1

                continue
            }

            if coordinateSystem[y + 1][x + 1] == " " {
                // return Position(x: x + 1, y: y + 1)
                x += 1
                y += 1

                continue
            }

            if part2 && y == coordinateSystemStuff.initialSandCoordinates.y && x == coordinateSystemStuff.initialSandCoordinates.x {
                let list: [Int] = [0,0,0,0,0]
                print(list[10])

            }

            break
        }

        return Position(x: x, y: y)
    }

    func showCoordinateSystem(coordinateSystemStuff: CoordinateSystemStuff) {
        let coordinateSystem: [[Character]] = coordinateSystemStuff.coordinateSystem
        // let initialSandCoordinates: Position = coordinateSystemStuff.initialSandCoordinates

        for lineIndex in 0..<coordinateSystem.count {
            let line: [Character] = coordinateSystem[lineIndex]

            for charIndex in 0..<line.count {
                let char: Character = line[charIndex]
                print(char, terminator: "")
            }

            print()
        }
    }

    func createCoordinateSystem(input: [[[String]]], part2: Bool = false) -> CoordinateSystemStuff {
        var coordinateSystem: [[Character]] = []
        var initialSandCoordinates: Position = Position(x: 0,y: 0)

        var smallestX: Int = input.map { $0.map { Int($0[0])! }.min()! }.min()!
        var biggestX: Int = input.map { $0.map { Int($0[0])! }.max()! }.max()!
        var smallestY: Int = input.map { $0.map { Int($0[1])! }.min()! }.min()!
        var biggestY: Int = input.map { $0.map { Int($0[1])! }.max()! }.max()!

        let floorlength: Int = (biggestY - smallestY) * 2 + 1
        print(floorlength)
        if part2 {
            biggestX += (floorlength - 1) / 2 + 100
            smallestX -= (floorlength - 1) / 2 + 100
        }

        // let rangeX: Range = smallestX..<biggestX
        if smallestX > 500 {
            smallestX = 500
            initialSandCoordinates.x = 0
        } else if biggestX < 500 {
            biggestX = 500
            initialSandCoordinates.x = biggestX - smallestX
        } else {
            initialSandCoordinates.x = 500 - smallestX
        }
        
        if smallestY > 0 {
            smallestY = 0
            initialSandCoordinates.y = 0
        } else if biggestY < 0 {
            biggestY = 0
            initialSandCoordinates.y = biggestY - smallestY
        } else {
            initialSandCoordinates.y = 0 - smallestY
        }
        

        for _ in smallestY...biggestY {
            var line: [Character] = []
            for _ in smallestX...biggestX {
                line.append(" ")
            }
            coordinateSystem.append(line)
        }
        

        for line in input {
            for rockIndex in 0..<line.count {
                // print(rock)
                let rock: [String] = line[rockIndex]
                let x: Int = Int(rock[0])! - smallestX
                let y: Int = Int(rock[1])! - smallestY

                if rockIndex < line.count - 1 {
                    let nextRock: [String] = line[rockIndex + 1]
                    let nextX: Int = Int(nextRock[0])! - smallestX
                    let nextY: Int = Int(nextRock[1])! - smallestY

                    if x == nextX {
                        for yIndex in min(y, nextY)...max(y, nextY) {
                            coordinateSystem[yIndex][x] = "#"
                        }
                    } else {
                        for xIndex in min(x, nextX)...max(x, nextX) {
                            coordinateSystem[y][xIndex] = "#"
                        }
                    }
                }

                coordinateSystem[y][x] = "#"

            }
        }

        coordinateSystem[initialSandCoordinates.y][initialSandCoordinates.x] = "+"
        if part2 {
            coordinateSystem.append(Array(repeating: " ", count: coordinateSystem[0].count))
            coordinateSystem.append(Array(repeating: "#", count: coordinateSystem[0].count))
            showCoordinateSystem(coordinateSystemStuff: CoordinateSystemStuff(coordinateSystem: coordinateSystem, initialSandCoordinates: Position(x: 0, y: 0)))
        }

        return CoordinateSystemStuff(coordinateSystem: coordinateSystem, initialSandCoordinates: initialSandCoordinates)
    }

    func parseInput(input: String) -> [[[String]]] {
        let inputArray: [String] = input.components(separatedBy: CharacterSet.newlines)
        let inputArraySplitted: [[String]] = inputArray.map { $0.components(separatedBy: " -> ") }
        let arrayToReturn: [[[String]]] = inputArraySplitted.map { $0.map { $0.components(separatedBy: ",") } }

        return arrayToReturn
    }
}

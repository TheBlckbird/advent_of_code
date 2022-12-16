import Foundation

extension Array {
    func itemFromBack(index: Int) -> Element? {
        guard index < count else { return nil }
        
        return self[count - index - 1]
    }

}

@main
public struct DayFive {

    struct Move {
        let quantity: Int
        let fromWhere: Int
        let toWhere: Int
    }

    public static func main() {
        let moves: [Move] = DayFive().parseMovesInput(movesInput: PuzzleInput().movesInput)
        var crates: [[String]] = DayFive().parseCratesInput()
        var cratesPart2: [[String]] = DayFive().parseCratesInput()

        for move in moves {
            for _ in 0..<move.quantity {
                crates = DayFive().moveCrate(fromWhere: move.fromWhere, toWhere: move.toWhere, crates: crates)
            }

            cratesPart2 = DayFive().moveMultipleCrates(quantity: move.quantity, fromWhere: move.fromWhere, toWhere: move.toWhere, crates: cratesPart2)
        }

        var resultPart1: String = ""
        var resultPart2: String = ""

        for crate in crates {
            resultPart1 += crate.last!
        }

        for crate in cratesPart2 {
            resultPart2 += crate.last!
        }

        print("Part 1: \(resultPart1)")
        print("Part 2: \(resultPart2)")
    }

    func moveCrate(fromWhere: Int, toWhere: Int, crates: [[String]]) -> [[String]] {
        var cratesMoved: [[String]] = crates
        let crateToMove: String = crates[fromWhere - 1].last!
        cratesMoved[fromWhere - 1].removeLast()
        cratesMoved[toWhere - 1].append(crateToMove)

        return cratesMoved
    }

    func moveMultipleCrates(quantity: Int, fromWhere: Int, toWhere: Int, crates: [[String]]) -> [[String]] {
        var cratesMoved: [[String]] = crates

        for i in 0..<quantity {
            let crateToMove: String = crates[fromWhere - 1].itemFromBack(index: quantity - i - 1)!
            cratesMoved[fromWhere - 1].remove(at: crates[fromWhere - 1].count - i - 1)
            cratesMoved[toWhere - 1].append(crateToMove)
        }

        // let crateToMove: String = crates[fromWhere - 1].last!
        // cratesMoved[fromWhere - 1].removeLast()
        // cratesMoved[toWhere - 1].append(crateToMove)

        return cratesMoved
    }

    func parseCratesInput() -> [[String]] {
        /* cratesInput: String
        * let inputArray: [String] = cratesInput.components(separatedBy: CharacterSet.newlines)
        * for line in inputArray {
        * }
        */

        let crates: [[String]] = [
            ["B", "W", "N"],
            ["L", "Z", "S", "P", "T", "D", "M", "B"],
            ["Q", "H", "Z", "W", "R"],
            ["W", "D", "V", "J", "Z", "R"],
            ["S", "H", "M", "B"],
            ["L", "G", "N", "J", "H", "V", "P", "B"],
            ["J", "Q", "Z", "F", "H", "D", "L", "S"],
            ["W", "S", "F", "J", "G", "Q", "B"],
            ["Z", "W", "M", "S", "C", "D", "J"]
        ]

        return crates
    }

    func parseMovesInput(movesInput: String) -> [Move] {
        let inputArray: [String] = movesInput.components(separatedBy: CharacterSet.newlines)
        var moves: [Move] = []

        for line in inputArray {
            let move_splitted: [String] = line.components(separatedBy: " ")

            moves.append(Move(quantity: Int(move_splitted[1])!, fromWhere: Int(move_splitted[3])!, toWhere: Int(move_splitted[5])!))
        }

        return moves
    }
}

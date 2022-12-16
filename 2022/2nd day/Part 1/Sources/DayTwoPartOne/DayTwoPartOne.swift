import Foundation

@main
public struct DayTwoPartOne {

    enum WinState {
        case win
        case lose
        case draw
    }

    enum GameMove {
        case rock
        case paper
        case scissors
    }

    public static func main() {
        var yourScore: Int = 0

        let rounds: [[String]] = DayTwoPartOne().ParseInput()

        for round in rounds {
            let opponentMove = DayTwoPartOne().GetMove(move: round[0])
            let yourMove = DayTwoPartOne().GetMove(move: round[1])

            let winState = DayTwoPartOne().checkWin(opponent: opponentMove, you: yourMove)

            switch winState {
                case .lose:
                    yourScore += 0
                
                case .draw:
                    yourScore += 3
                
                case .win:
                    yourScore += 6
            }

            switch yourMove {
                case .rock:
                    yourScore += 1
                
                case .paper:
                    yourScore += 2
                
                case .scissors:
                    yourScore += 3
            }
        }


        print(yourScore)
        
    }

    func GetMove(move: String) -> GameMove {
        switch move {
        case "A", "x":
            return .rock
        case "B", "Y":
            return .paper
        case "C", "Z":
            return .scissors
        default:
            return .rock
        }
    }

    func checkWin(opponent: GameMove, you: GameMove) -> WinState {

        if opponent == you {
            return .draw

        } else if opponent == GameMove.rock && you == GameMove.paper {
            return .win

        } else if opponent == GameMove.paper && you == GameMove.scissors {
            return .win

        } else if opponent == GameMove.scissors && you == GameMove.rock {
            return .win
        }

        return .lose
    }

    func ParseInput() -> [[String]] {
        let lines: [String] = PuzzleInput().input.components(separatedBy: CharacterSet.newlines)
        var parsedLines: [[String]] = []

        for line: String in lines {
            let parsedLine: [String] = line.components(separatedBy: " ")
            parsedLines.append(parsedLine)
        }

        return parsedLines
    }
}

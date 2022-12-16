import Foundation

@main
public struct DayTwoPartTwo {

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

        let rounds: [[String]] = DayTwoPartTwo().parseInput()

        for round in rounds {
            let opponentMove = DayTwoPartTwo().getMove(move: round[0])
            let whatToDo = DayTwoPartTwo().getWhatEndState(move: round[1])
            // print("\(round[1]): \(whatToDo)")
            
            // was muss geschafft werden - check
            // was brauch ich dafür
            var yourMove: GameMove = .paper

            switch whatToDo {
            case .win:
                yourMove = DayTwoPartTwo().getWhatBeatsWhat(move: opponentMove, lose: false)
            
            case .lose:
                yourMove = DayTwoPartTwo().getWhatBeatsWhat(move: opponentMove, lose: true)

            case .draw:
                yourMove = opponentMove
            }
            // print(opponentMove)
            // print(yourMove)

            let winState = DayTwoPartTwo().checkWin(opponent: opponentMove, you: yourMove)
            // print("\(whatToDo), \(winState)")

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

    func getMove(move: String) -> GameMove {
        switch move {
        case "A":
            return .rock
            
        case "B":
            return .paper
            
        case "C":
            return .scissors
            
        default:
            return .rock
        }
    }

    func getWhatEndState(move: String) -> WinState {
        switch move {
        case "X":
            return .lose
            
        case "Y":
            return .draw
            
        case "Z":
            return .win
            
        default:
            return .draw
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

    func getWhatBeatsWhat(move: GameMove, lose: Bool) -> GameMove {

        switch move {
        case .rock:
            return lose ? .scissors : .paper

        case .paper:
            return lose ? .rock : .scissors

        case .scissors:
            return lose ? .paper : .rock
        }

    }

    func parseInput() -> [[String]] {
        let lines: [String] = PuzzleInput().input.components(separatedBy: CharacterSet.newlines)
        var parsedLines: [[String]] = []

        for line: String in lines {
            let parsedLine: [String] = line.components(separatedBy: " ")
            parsedLines.append(parsedLine)
        }

        return parsedLines
    }
}

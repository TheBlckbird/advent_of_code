import Foundation

@main
public struct DayFour {
    public static func main() {
        DayFour().firstPart()
    }

    func firstPart() {
        var totalScorePartOne: Int = 0
        var totalScorePartTwo: Int = 0

        let input: [[[String]]] = DayFour().parseInput(input: PuzzleInput().input)

        for line in input {
            // if (line[0][0] <= line[1][0] && line[0][1] >= line[1][1]) || (line[0][0] >= line[1][0] && line[0][1] <= line[1][1]) {
            //     totalScore += 1
            // }
            let rangeFirst: ClosedRange = Int(line[0][0])!...Int(line[0][1])!
            let rangeSecond: ClosedRange = Int(line[1][0])!...Int(line[1][1])!

            if rangeFirst.clamped(to: rangeSecond) == rangeFirst || rangeSecond.clamped(to: rangeFirst) == rangeSecond {
                totalScorePartOne += 1
                totalScorePartTwo += 1
            } else if rangeFirst.overlaps(rangeSecond) {
                totalScorePartTwo += 1
            }
        }

        print("Part 1: \(totalScorePartOne)")
        print("Part 2: \(totalScorePartTwo)")
    }

    func parseInput(input: String) -> [[[String]]] {
        let input_array: [String] = input.components(separatedBy: CharacterSet.newlines)
        let input_array_splitted: [[String]] = input_array.map { $0.components(separatedBy: ",") }
        let input_parsed: [[[String]]] = input_array_splitted.map { $0.map { $0.components(separatedBy: "-") } }
        
        print(input_parsed[0])
        return input_parsed

    }
}

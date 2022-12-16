import Foundation

extension StringProtocol {
    subscript(offset: Int) -> Character { self[index(startIndex, offsetBy: offset)] }
    subscript(range: Range<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: ClosedRange<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: PartialRangeFrom<Int>) -> SubSequence { self[index(startIndex, offsetBy: range.lowerBound)...] }
    subscript(range: PartialRangeThrough<Int>) -> SubSequence { self[...index(startIndex, offsetBy: range.upperBound)] }
    subscript(range: PartialRangeUpTo<Int>) -> SubSequence { self[..<index(startIndex, offsetBy: range.upperBound)] }
}

@main
public struct DayThree {

    public static func main() {
        // up: ^
        // down: v
        // left: <
        // right: >

        let input: String = PuzzleInput().input

        var alreadyVisited: [[Int]] = [[0,0]]
        var currentHouseSanta: [Int] = [0, 0]
        var currentHouseRobot: [Int] = [0, 0]
        var totalHousesVisited: Int = 1

        for char in 0..<input.count {

            if char % 2 == 0 {
                switch input[char] {
                case "^":
                    currentHouseRobot[1] += 1

                case "v":
                    currentHouseRobot[1] -= 1

                case "<":
                    currentHouseRobot[0] -= 1

                case ">":
                    currentHouseRobot[0] += 1

                default:
                    print("unknown")
                }

                if !alreadyVisited.contains(currentHouseRobot) {
                    alreadyVisited.append(currentHouseRobot)
                    totalHousesVisited += 1
                }
            } else {
                switch input[char] {
                case "^":
                    currentHouseSanta[1] += 1

                case "v":
                    currentHouseSanta[1] -= 1

                case "<":
                    currentHouseSanta[0] -= 1

                case ">":
                    currentHouseSanta[0] += 1

                default:
                    print("unknown")
                }

                if !alreadyVisited.contains(currentHouseSanta) {
                    alreadyVisited.append(currentHouseSanta)
                    totalHousesVisited += 1
                }
            }

        }

        print("Part 1: \(totalHousesVisited)")
    }
}

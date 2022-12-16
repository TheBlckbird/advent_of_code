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

import Foundation

@main
public struct DaySix {

    public static func main() {
        let input: String = PuzzleInput().input
        var fourCharsTrue: Bool = false
        var fourteenCharsTrue: Bool = false

        for char in 0..<input.count {
            let fourChars: String = String(input[char..<char+4])
            let fourteenChars: String = String(input[char..<char+14])
            // print(fourChars)
            // break
            let fourCharsHasNoRepeatingChars: Bool = DaySix().checkNoRepeatingChars(input: fourChars)
            let fourteenCharsHasNoRepeatingChars: Bool = DaySix().checkNoRepeatingChars(input: fourteenChars)

            if fourCharsHasNoRepeatingChars && !fourCharsTrue {
                print("Part 1: \(char + 4)")
                fourCharsTrue = true
            }
            
            if fourteenCharsHasNoRepeatingChars && !fourteenCharsTrue {
                print("Part 2: \(char + 14)")
                fourteenCharsTrue = true
            }

            if (fourCharsTrue && fourteenCharsTrue) {
                break
            }
        }

        
    }

    func checkNoRepeatingChars(input: String) -> Bool {
        var inputEdited: String = input

        for char in input {
            // reove first char fro string
            inputEdited.removeFirst()

            // check if char is in string
            if inputEdited.contains(char) {
                return false
            }
        }


        return true
    }
}

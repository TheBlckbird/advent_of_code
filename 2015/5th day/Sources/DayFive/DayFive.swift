import Foundation

@main
public struct DayFive {
    public static func main() {
        var totalScore: Int = 0
        let input: [String] = PuzzleInput.input.components(separatedBy: CharacterSet.newlines)
        // let line: String = "haegwjzuvuyypxyu"

        for line in input {
            if DayFive().checkVowels(string: line) && DayFive().checkLetterTwice(string: line) && DayFive().checkBadSubstrings(string: line) {
                totalScore += 1
            }
        }

        print("Part 1: \(totalScore)")

        totalScore = 0

        for line in input {
            if DayFive().checkLetterPairTwice(string: line) && DayFive().checkLetterTwiceLetterBetween(string: line) {
                totalScore += 1
            }
        }

        print("Part 2: \(totalScore)")
        
    }

    func checkVowels(string: String) -> Bool {
        let regex: Regex = try! Regex("[aeiou]")

        if string.matches(of: regex).count >= 3 {
            return true
        }

        return false
    }

    func checkLetterTwice(string: String) -> Bool {
        let regex: Regex = try! Regex("(\\w)\\1{1}")

        if string.matches(of: regex).count >= 1 {
            return true
        }

        return false

    }

    func checkBadSubstrings(string: String) -> Bool {
        if string.contains("ab") || string.contains("cd") || string.contains("pq") || string.contains("xy") {
            return false
        }

        return true
    }

    func checkLetterPairTwice(string: String) -> Bool {
        let regex: Regex = try! Regex("(\\w{2}).*?(\\1)")
        
        if string.matches(of: regex).count >= 1 {
            return true
        }

        return false
    }

    func checkLetterTwiceLetterBetween(string: String) -> Bool {
        let regex: Regex = try! Regex("(\\w)\\w\\1")

        if string.matches(of: regex).count >= 1 {
            return true
        }

        return false
    }
}

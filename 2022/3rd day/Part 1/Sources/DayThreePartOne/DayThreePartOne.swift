import Foundation

@main
public struct DayThreePartOne {

    public static func main() {
        var totalScore: Int = 0

        let input: [[String]] = DayThreePartOne().parseInput(input: PuzzleInput().input)
        
        for line in input {
            let sameCharacter: Character = DayThreePartOne().getSameCharacter(first: line[0], second: line[1])
            let priorityScore: Int = DayThreePartOne().getCharacterPriority(character: sameCharacter)
            
            totalScore += priorityScore
        }

        print(totalScore)

    }

    func getSameCharacter(first: String, second: String) -> Character {
        for character in first {
            if second.contains(character) {
                return character
            }
        }

        return " "
    }

    func getCharacterPriority(character: Character) -> Int {
        let alphabet: [Character] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

        let index: Int = alphabet.firstIndex(of: character) ?? 0
        let priority: Int = index + 1

        return priority
    }

    func parseInput(input: String) -> [[String]] {
        let input_array: [String] = input.components(separatedBy: CharacterSet.newlines)
        var input_parsed: [[String]] = []

        for line in input_array {
            let half_char_count: Int = line.count / 2
            let first_half: String = String(line.prefix(half_char_count))
            let second_half: String = String(line.suffix(half_char_count))
            input_parsed.append([first_half, second_half])
        }

        return input_parsed
    }
}

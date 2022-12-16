import Foundation

@main
public struct DayThreePartTwo {

    public static func main() {
        var totalScore: Int = 0

        let input: [[String]] = DayThreePartTwo().parseInput(input: PuzzleInput().input)
        
        for line in input {
            let sameCharacter: Character = DayThreePartTwo().getSameCharacter(first: line[0], second: line[1], third: line[2])
            let priorityScore: Int = DayThreePartTwo().getCharacterPriority(character: sameCharacter)
            
            totalScore += priorityScore
        }

        print(totalScore)

    }

    func getSameCharacter(first: String, second: String, third: String) -> Character {
        for character in first {
            if second.contains(character) && third.contains(character) {
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

        for i in stride(from: 0, to: input_array.count, by: 3) {
            var line: [String] = []
            line.append(input_array[i])
            line.append(input_array[i + 1])
            line.append(input_array[i + 2])

            input_parsed.append(line)
        }

        return input_parsed
    }
}

import Foundation

@main
public struct AOC {
    public static func main() {
        AOC().parseInput(input: PuzzleInput.example)
    }

    func parseInput(input: String) -> [[Any]] {
        let inputArray: [String] = input.components(separatedBy: "\n\n")
        var outputArray: [[Any]] = []

        for listPacket in inputArray {
            let lists: [String] = listPacket.components(separatedBy: CharacterSet.newlines)
            outputArray.append([])

            for listIndex in 0..<lists.count {
                
                // let listSeperated: [String] = list.components(separatedBy: ",")

                // print(listSeperated)

                var openBrackets: Int = 0
                var currentNumber: String = ""


                for character in lists[listIndex] {
                    switch character {
                    case "[":
                        outputArray[outputArray.count - 1].append([])
                        openBrackets += 1

                    case "]":
                        openBrackets -= 1

                    case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                        currentNumber += String(character)

                    case ",":
                        break

                    default:
                        print("Error")
                    
                    }
                }

                print(list)
                
            }
        }

        return [["hi"]]
    }
}

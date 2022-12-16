import Foundation

@main
public struct DaySeven {
    public private(set) var text = "Hello, World!"

    struct FileFolder {
        let name: String
        var size: Int = 0
        var children: [FileFolder] = []
    }

    public static func main() {
        DaySeven().parseInput(input: PuzzleInput().input)
    }

    func parseInput(input: String) {
        let inputArray: [String] = input.components(separatedBy: CharacterSet.newlines)

        var currentDirectory: [String] = []
        let fileSystem: FileFolder = FileFolder(name: "root", children: [])

        for line in inputArray {
            let lineArray = line.components(separatedBy: CharacterSet.whitespaces)

            if lineArray[0] == "$" {
                if lineArray[1] == "cd" {
                    switch lineArray[2] {
                    case "/":
                        currentDirectory = []

                    case "..":
                        currentDirectory.removeLast()

                    default:
                        currentDirectory.append(lineArray[2])
                    }

                } else if lineArray[1] == "ls" {
                    var filesAndFolders: [[String]] = []

                    

                    for directory in currentDirectory {
                        let index = fileSystem.children.firstIndex(where: { $0.name == directory })
                    }
                }
            }
        }
    }
}

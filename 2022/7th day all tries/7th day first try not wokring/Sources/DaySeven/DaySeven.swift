import Foundation

@main
public struct DaySeven {

    struct Command {
        let name: String
        var terminalOutput: [File] = []
    }

    struct File {
        let fileName: String
        var fileSize: Int = 0
        var isDirectory: Bool = false
        var parents: [String]
        var subFiles: [File] = []
    }

    public static func main() {

        let example: String = """
        $ cd /
        $ ls
        dir a
        14848514 b.txt
        8504156 c.dat
        dir d
        $ cd a
        $ ls
        dir e
        29116 f
        2557 g
        62596 h.lst
        $ cd e
        $ ls
        584 i
        $ cd ..
        $ cd ..
        $ cd d
        $ ls
        4060174 j
        8033020 d.log
        5626152 d.ext
        7214296 k
        """

        let directories: [File] = DaySeven().getDirectories(input: PuzzleInput().input)
        // let directories: [File] = DaySeven().getDirectories(input: example)
        // print(directories)
        // return

        var sizesOfSmallDirectories: Int = 0

        for directory in directories {
            let size = DaySeven().getSize(files: directory.subFiles, name: directory.fileName, directories: directories)

            if size <= 100000 {
                sizesOfSmallDirectories += size
            }
            
        }

        print("Part 1: \(sizesOfSmallDirectories)")

    }

    func getSize(files: [File], name: String, directories: [File], parents: [String]) -> Int {
        var totalFileSize: Int = 0

        for file in files {
            if file.isDirectory {
                let subFiles: [File] = directories.first(where: { $0.fileName == file.fileName && $0.parents == parents.append(name) })!.subFiles

                let size = getSize(files: subFiles, name: file.fileName, directories: directories, parents: parents.append(name))

                totalFileSize += size

            } else {
                totalFileSize += file.fileSize
            }
        }

        return totalFileSize
    }


    /// aaaaaahhhh igore pls

    func getDirectories(input: String) -> [File] {
        let inputArray = input.components(separatedBy: CharacterSet.newlines)
        var inputParsed: [Command] = []

        var directories: [File] = []
        var currentDirectory: [String] = []

        for lineIndex in 0..<inputArray.count {
            let line = inputArray[lineIndex]

            if line.starts(with: "$ ls") {
                
                var itemToAppend: Command = Command(name: "ls", terminalOutput: [])

                var nextCdNotFound: Bool = true
                var iteration: Int = 0

                while nextCdNotFound {
                    iteration += 1

                    if lineIndex + iteration >= inputArray.count {
                        break
                    }

                    let nextLine: String = inputArray[lineIndex + iteration]

                    if nextLine.starts(with: "$ cd") {
                        nextCdNotFound = false

                    } else {
                        let fileLineSplitted: [String] = nextLine.components(separatedBy: " ")
                        
                        if fileLineSplitted[0] != "dir" {
                            itemToAppend.terminalOutput.append(File(fileName: fileLineSplitted[1], fileSize: Int(fileLineSplitted[0])!))
                            directories[directories.count - 1].subFiles.append(File(fileName: fileLineSplitted[1], fileSize: Int(fileLineSplitted[0])!, parents: currentDirectory))

                        } else {
                            itemToAppend.terminalOutput.append(File(fileName: fileLineSplitted[1], isDirectory: true))
                            directories[directories.count - 1].subFiles.append(File(fileName: fileLineSplitted[1], isDirectory: true, parents: currentDirectory))
                        }
                        
                    }
                }


                inputParsed.append(itemToAppend)

            } else if line.starts(with: "$ cd") {
                inputParsed.append(Command(name: "cd"))

                let cdLineSplitted: [String] = line.components(separatedBy: " ")

                

                switch cdLineSplitted[2] {
                case "/":
                    currentDirectory = ["root"]
                    directories.append(File(fileName: "root", isDirectory: true))
                    
                case "..":
                    currentDirectory.removeLast()

                default:
                    currentDirectory.append(cdLineSplitted[2])
                    directories.append(File(fileName: cdLineSplitted[2], isDirectory: true))

                    

                }
            }

        }


        return directories
    }

}

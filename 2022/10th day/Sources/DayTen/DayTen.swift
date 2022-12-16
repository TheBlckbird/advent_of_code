import Foundation

@main
public struct DayTen {

    struct CyclesRegisterX {
        var cycles: Int
        var registerX: Int
    }

    public static func main() {
        let dayTen = DayTen()

        let input: [[String]] = dayTen.parseInput(input: PuzzleInput.input)
        // let input: [[String]] = dayTen.parseInput(input: PuzzleInput.exampleData)
        var totalCycles: Int = 0
        var registerX: Int = 1

        var sumSignalStrengths: Int = 0

        for line in input {
            let newCyclesRegisterX = dayTen.doCommand(command: line)
            let cycles: Int = newCyclesRegisterX.cycles

            for _ in 0..<cycles {
                dayTen.crt(spritePosition: registerX, cycle: totalCycles)

                totalCycles += 1

                if totalCycles == 20 || totalCycles == 60 || totalCycles == 100 || totalCycles == 140 || totalCycles == 180 || totalCycles == 220 {
                    sumSignalStrengths += dayTen.getSignalStrength(cycles: totalCycles, registerX: registerX)
                }

            }

            registerX += newCyclesRegisterX.registerX
        }

        print()
        print("Part 1: \(sumSignalStrengths)")
    }

    func doCommand(command: [String]) -> CyclesRegisterX {
        var newCyclesRegisterX: CyclesRegisterX = CyclesRegisterX(cycles: 0, registerX: 0)

        switch command[0] {
        case "noop":
            newCyclesRegisterX.cycles = 1

        case "addx":
            newCyclesRegisterX.cycles = 2
            newCyclesRegisterX.registerX = Int(command[1])!

        default:
            print("Error: Unknown command '\(command[0])'")
                
        }

        return newCyclesRegisterX
    }

    func getSignalStrength(cycles: Int, registerX: Int) -> Int {

        // print("Signal strength at cycle \(cycles): \(registerX)")
        // print(cycles * registerX)
        

        return cycles * registerX
        
    }

    func crt(spritePosition: Int, cycle: Int) {
        let crtWidth: Int = 40
        
        var currentPixel: Int = cycle
        

        if cycle % crtWidth == 0 {
            print()
        }

        currentPixel -= (cycle / crtWidth) * crtWidth

        let wholeSpriteSizePosition: Range = spritePosition-1..<spritePosition+2

        if wholeSpriteSizePosition.contains(currentPixel) {
            print("#", terminator: "")
        } else {
            print(" ", terminator: "")
        }

    }

    func parseInput(input: String) -> [[String]] {
        let lines: [String] = input.components(separatedBy: CharacterSet.newlines)
        return lines.map { $0.components(separatedBy: " ") }
    }
}

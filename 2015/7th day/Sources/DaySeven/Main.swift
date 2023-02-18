struct Position {
    let x: Int
    let y: Int
}

enum Action {
    case off
    case on
    case toggle
}

struct Instruction {
    var action: Action
    var startPoint: Position
    var endPoint: Position
}

class Main {
    init() {
        var lights: [[Bool]] = [[Bool]](repeating: [Bool](repeating: false, count: 1000), count: 1000)
        var lightsBrightness: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: 1000), count: 1000)
        
        let instructions: [Instruction] = self.parseInput(input: PuzzleInput().input)

        for instruction: Instruction in instructions {
            lights = self.changeLights(lights: lights, instruction: instruction)
            lightsBrightness = self.changeLightsBrightness(lightsBrightness: lightsBrightness, instruction: instruction)
        }

        var lightsOn: Int = 0
        var totalBrightness: Int = 0

        for lightRow: [Bool] in lights {
            for light: Bool in lightRow {
                if light { lightsOn += 1 }
            }
        }

        for lightRow: [Int] in lightsBrightness {
            for light: Int in lightRow {
                totalBrightness += light
            }
        }

        print("Part 1: \(lightsOn)")
        print("Part 2: \(totalBrightness)")
    }

    func changeLights(lights: [[Bool]], instruction: Instruction) -> [[Bool]] {
        var lightsChanged: [[Bool]] = lights

        for y: Int in instruction.startPoint.y...instruction.endPoint.y {
            // print(y)
            for x: Int in instruction.startPoint.x...instruction.endPoint.x {
                // print(instruction.action)
                switch instruction.action {
                    
                case .off:
                    lightsChanged[y][x] = false
                    // print("off")

                case .on:
                    lightsChanged[y][x] = true
                    // print("on")

                case .toggle:
                    lightsChanged[y][x].toggle()
                    // print("togggle")

                }
                
            }
        }

        return lightsChanged
    }

    func changeLightsBrightness(lightsBrightness: [[Int]], instruction: Instruction) -> [[Int]] {
        var lightsChanged: [[Int]] = lightsBrightness

        for y: Int in instruction.startPoint.y...instruction.endPoint.y {
            // print(y)
            for x: Int in instruction.startPoint.x...instruction.endPoint.x {
                // print(instruction.action)
                switch instruction.action {
                    
                case .off:
                    lightsChanged[y][x] -= lightsChanged[y][x] > 0 ? 1 : 0
                    // print("off")

                case .on:
                    lightsChanged[y][x] += 1
                    // print("on")

                case .toggle:
                    lightsChanged[y][x] += 2
                    // print("togggle")

                }
                
            }
        }

        return lightsChanged
    }

    func parseInput(input: String) -> [Instruction] {
        let inputSplitted: [String.SubSequence] = input.split(separator: "\n")
        var instructions: [Instruction] = []

        for line: String.SubSequence in inputSplitted {
            var lineSplitted: [Substring.SubSequence] = line.split(separator: " ")
            var newInstruction: Instruction = Instruction(action: Action.off, startPoint: Position(x: 0, y: 0), endPoint: Position(x: 0, y: 0))

            switch lineSplitted[0] {
            case "turn":

                switch lineSplitted[1] {
                case "off":
                    newInstruction.action = Action.off

                case "on":
                    newInstruction.action = Action.on

                default:
                    print("Error: \(lineSplitted[1]) is unknown")
                }

                lineSplitted.removeFirst(2)

            case "toggle":
                newInstruction.action = Action.toggle
                lineSplitted.removeFirst()

            default:
                print("Error: \(lineSplitted[0]) is unknown")
                
            }

            let startPoint: [Substring.SubSequence] = lineSplitted[0].split(separator: ",")
            let endPoint: [Substring.SubSequence] = lineSplitted[2].split(separator: ",")

            newInstruction.startPoint = Position(x: Int(startPoint[0])!, y: Int(startPoint[1])!)
            newInstruction.endPoint = Position(x: Int(endPoint[0])!, y: Int(endPoint[1])!)

            instructions.append(newInstruction)
        }

        return instructions
    }
}
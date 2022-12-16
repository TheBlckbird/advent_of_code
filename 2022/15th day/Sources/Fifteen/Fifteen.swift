import Foundation

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}

@main
public struct Fifteen {

    struct Sensor {
        let sensor: Position
        let beacon: Position
    }

    struct Position: Equatable {
        let x: Int
        let y: Int
    }

    public static func main() {
        let this: Fifteen = Fifteen()

        // let sensors: [Sensor] = this.parseInput(input: PuzzleInput.example)
        // let lineToCheck: Int = 10
        let sensors: [Sensor] = this.parseInput(input: PuzzleInput.input)
        let lineToCheck: Int = 2000000

        var placesWhereNoBeaconOneLine: Int = 0
        
        // var biggestX: Int = 0

        var rangesOneLineSensor: [ClosedRange<Int>] = []

        
        
        for sensor in sensors {
            // let sensor = sensors[8]
            let size: Int = this.getRauteSize(sensor: sensor)

            let sensorBottomY: Int = sensor.sensor.y - size
            let sensorTopY: Int = sensor.sensor.y + size
            let sensorYRange: ClosedRange = sensorBottomY...sensorTopY
            // print("Y")
            // print(sensorLeftY, sensorRightY)

            if !sensorYRange.contains(lineToCheck) {
                continue
            }

            let lineDistanceToSensor: Int = abs(sensor.sensor.y - lineToCheck)

            let sensorLeftX: Int = sensor.sensor.x - size + lineDistanceToSensor
            let sensorRightX: Int = sensor.sensor.x + size - lineDistanceToSensor

            let sensorXRange: ClosedRange<Int> = sensorLeftX...sensorRightX
            rangesOneLineSensor.append(sensorXRange)
            
        }

        // for range in rangesOneLineSensor {
        //     print(range)
        // }
        
        var checkedBeacons: [Position] = []
        print("bei beacons")

        for beacon in sensors {
            if checkedBeacons.contains(where: { $0 == Position(x: beacon.beacon.x, y: beacon.beacon.y) }) {
                continue
            }

            checkedBeacons.append(Position(x: beacon.beacon.x, y: beacon.beacon.y))

            if beacon.beacon.y == lineToCheck {
                placesWhereNoBeaconOneLine -= 1
            }
        }

        print("bei zählen")

        let rangesOneLineSensorJoined: [Int] = rangesOneLineSensor.joined().uniqued()
        print("nach uniqued")

        for _ in rangesOneLineSensorJoined {
            placesWhereNoBeaconOneLine += 1
            // print(i)
        }

        // placesWhereNoBeaconOneLine += rangesOneLineSensor.count

        print("Part 1: \(placesWhereNoBeaconOneLine)")

    }

    func getRauteSize(sensor: Sensor) -> Int {
        return abs(sensor.beacon.x - sensor.sensor.x) + abs(sensor.beacon.y - sensor.sensor.y)
    }

    func getSensorCoverage(sensor: Sensor) -> [Position] {
        let size: Int = abs(sensor.beacon.x - sensor.sensor.x) + abs(sensor.beacon.y - sensor.sensor.y)
        
        var positions: [Position] = []

        // for i in 0..<size {
        //     // positions.append(Position(x: Int, y: Int))
        //     // for j in 1...size {
        //     //     let nextLine = 
        //     // }

        //     positions.append(Position(x: sensor.sensor.x - i, y: sensor.sensor.x - i))
        //     positions.append(Position(x: sensor.sensor.x - i, y: sensor.sensor.x + i))
        //     positions.append(Position(x: sensor.sensor.x + i, y: sensor.sensor.x - i))
        //     positions.append(Position(x: sensor.sensor.x + i, y: sensor.sensor.x + i))

        //     let nextLine: Int = i

        //     for j in 1..<nextLine + 1 {
        //         positions.append(Position(x: sensor.sensor.x - i, y: sensor.sensor.y - j))
        //         positions.append(Position(x: sensor.sensor.x - i, y: sensor.sensor.y + j))
        //         positions.append(Position(x: sensor.sensor.x + i, y: sensor.sensor.y - j))
        //         positions.append(Position(x: sensor.sensor.x + i, y: sensor.sensor.y + j))
        //     }
        // }

        for i in size * -1...size {
            
            let lineSize: Int = (size - abs(i)) * 2 + 1

            for j in lineSize / 2 * -1...lineSize / 2 {
                positions.append(Position(x: sensor.sensor.x + j, y: sensor.sensor.y + i))
            }
        }


        return positions
    }

    func drawRaute(size: Int) {
        for i in size * -1...size {
            
            let lineSize = (size - abs(i)) * 2 + 1
            let spaceLeft: Int = (size * 2 + 1 - lineSize) / 2
            print(spaceLeft, terminator: "")

            for _ in 0...spaceLeft {
                print(" ", terminator: "")
            }

            for _ in 1...lineSize {
                print("#", terminator: "")
            }
            print()
        }
    }

    func parseInput(input: String) -> [Sensor] {
        let inputArray: [String] = input.components(separatedBy: CharacterSet.newlines)

        let regex: Regex = try! Regex("[-(\\d+)]\\d*")
        // let regex: Regex = try! Regex("\\d")

        var sensors: [Sensor] = []

        for line in inputArray {
            let sensorX: Regex.Match = line.firstMatch(of: regex)!
            
            var index: String.Index = sensorX.range.upperBound
            
            var newLine: String = line
            newLine = String(line[index...])

            let sensorY: Regex.Match = newLine.firstMatch(of: regex)!
            index = sensorY.range.upperBound
            newLine = String(newLine[index...])

            let beaconX: Regex.Match = newLine.firstMatch(of: regex)!
            index = beaconX.range.upperBound
            newLine = String(newLine[index...])

            let beaconY: Regex.Match = newLine.firstMatch(of: regex)!
            index = beaconY.range.upperBound
            newLine = String(newLine[index...])

            sensors.append(Sensor(sensor: Position(x: Int(sensorX.0)!, y: Int(sensorY.0)!), beacon: Position(x: Int(beaconX.0)!, y: Int(beaconY.0)!)))
        }

        // sensors.sort(by: { $0.sensor.x + getRauteSize(sensor: $0) < $1.sensor.x + getRauteSize(sensor: $0) })

        return sensors
    }
}

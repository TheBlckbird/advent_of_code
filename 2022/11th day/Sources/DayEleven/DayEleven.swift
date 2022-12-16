import Foundation

@main
public struct DayEleven {

    struct Monkey {
        let id: Int
        var items: [Int]
        let operation: Operation
        let testDiviseBy: Int
        let testTrueDestinationMonkey: Int
        let testFalseDestinationMonkey: Int
        var inspectedItems: Int = 0
    }

    struct MonkeyThrow {
        let monkey: Monkey
        let item: Int
        let destinationMonkey: Monkey
    }

    enum OperationType {
        case add
        case multiply
        case divide
        case subtract
    }

    struct Operation {
        var method: OperationType
        var value: Int = 0
        var oldValue: Bool = false
    }

    public static func main() {
        let dayEleven = DayEleven()

        var monkeys: [Monkey] = dayEleven.parseInput(input: PuzzleInput.input)
        var monkeysPart2: [Monkey] = dayEleven.parseInput(input: PuzzleInput.input)
        // var monkeys: [Monkey] = dayEleven.parseInput(input: PuzzleInput.exampleInput)

        var allTestsMultiplied: Int = 1

        for monkey in monkeys {
            allTestsMultiplied *= monkey.testDiviseBy
        }

        for _ in 0..<20 {
            monkeys = dayEleven.oneRound(monkeys: monkeys)
        }

        var mostActiveMonkey: Int = 0
        var secondMostActiveMonkey: Int = 0
        for monkey in monkeys {
            if monkey.inspectedItems > mostActiveMonkey {
                secondMostActiveMonkey = mostActiveMonkey
                mostActiveMonkey = monkey.inspectedItems
            } else if monkey.inspectedItems > secondMostActiveMonkey {
                secondMostActiveMonkey = monkey.inspectedItems
            }
        }

        print("Part 1: \(mostActiveMonkey * secondMostActiveMonkey)")

        for _ in 0..<10_000 {
            monkeysPart2 = dayEleven.oneRound(monkeys: monkeysPart2, part2: true, allTestsMultiplied: allTestsMultiplied)
        }

        for monkey in monkeysPart2 {
            if monkey.inspectedItems > mostActiveMonkey {
                secondMostActiveMonkey = mostActiveMonkey
                mostActiveMonkey = monkey.inspectedItems
            } else if monkey.inspectedItems > secondMostActiveMonkey {
                secondMostActiveMonkey = monkey.inspectedItems
            }
            // print(monkey.inspectedItems)
        }

        print("Part 2: \(mostActiveMonkey * secondMostActiveMonkey)")

    }

    func oneRound(monkeys: [Monkey], part2: Bool = false, allTestsMultiplied: Int = 0) -> [Monkey] {
        var newMonkeys: [Monkey] = monkeys

        for monkeyIndex in 0..<newMonkeys.count {

            let monkey: Monkey = newMonkeys[monkeyIndex]
            
            for _ in 0..<monkey.items.count {
                newMonkeys[monkeyIndex].inspectedItems += 1

                let item: Int = calculateItem(operation: monkey.operation, item: newMonkeys[monkeyIndex].items[0], part2: part2, allTestsMultiplied: allTestsMultiplied)
                
                newMonkeys[monkeyIndex].items[0] = item

                let test: Bool = testItem(item: item, divisableBy: monkey.testDiviseBy)

                var destinationMonkey: Monkey = newMonkeys.first { $0.id == (test ? monkey.testTrueDestinationMonkey : monkey.testFalseDestinationMonkey) }!
                let throwItem: MonkeyThrow = throwItem(monkeyThrow: MonkeyThrow(monkey: newMonkeys[monkeyIndex], item: item, destinationMonkey: destinationMonkey))
                destinationMonkey = throwItem.destinationMonkey
                newMonkeys[monkeyIndex].items = throwItem.monkey.items
                let indexCatchingMonkey: Int = newMonkeys.firstIndex { $0.id == destinationMonkey.id }!
                newMonkeys[indexCatchingMonkey].items = destinationMonkey.items
            }

        }

        return newMonkeys
    }

    func calculateItem(operation: Operation, item: Int, part2: Bool, allTestsMultiplied: Int = 0) -> Int {
        var newItem: Int = 0
        let value: Int = operation.oldValue ? item : operation.value

        switch operation.method {
        case .add:
            newItem = item + value
        case .multiply:
            newItem = item * value
        case .divide:
            newItem = item / value
        case .subtract:
            newItem = item - value
        }
        
        if !part2 {
            newItem = Int(newItem / 3)
            return newItem
        }

        // newItem = newItem % (divisableBy * divisableBy)
        // newItem = 
        newItem %= allTestsMultiplied

        return newItem
    }

    func testItem(item: Int, divisableBy: Int) -> Bool {
        if item % divisableBy == 0 {
            return true
        } else {
            return false
        }
    }

    func throwItem(monkeyThrow: MonkeyThrow) -> MonkeyThrow {
        let item: Int = monkeyThrow.item
        var monkey: Monkey = monkeyThrow.monkey
        var destinationMonkey: Monkey = monkeyThrow.destinationMonkey

        monkey.items.removeFirst()
        destinationMonkey.items.append(item)

        return MonkeyThrow(monkey: monkey, item: item, destinationMonkey: destinationMonkey)
    }

    func parseInput(input: String) -> [Monkey] {
        let inputArray: [String] = input.components(separatedBy: "\n\n")
        var monkeysDividedArray: [[String]] = inputArray.map { $0.components(separatedBy: "\n") }
        monkeysDividedArray = monkeysDividedArray.map { $0.map { $0.trimmingCharacters(in: .whitespaces) } }

        var monkeysArray: [Monkey] = []

        let monkeyRegex: Regex = try! Regex("\\d+")
        let itemsRegex: Regex = try! Regex("\\d[\\d, ]+")
        // let operationRegex: Regex = try! Regex("[*+] \\d+")
        let testDiviseByRegex: Regex = try! Regex("\\d+")
        let testDestinationRegex: Regex = try! Regex("\\d")

        for monkey in monkeysDividedArray {
            let id: Int = Int(monkey[0].firstMatch(of: monkeyRegex)!.0)!
            let items: [Int] = monkey[1].firstMatch(of: itemsRegex)!.0.components(separatedBy: ", ").map { Int($0)! }
            // let operation: String = String(monkey[2].firstMatch(of: operationRegex)!.0)
            let operationArray: [String] = monkey[2].components(separatedBy: " ")

            var operation: Operation = Operation(method: .add)
            
            if operationArray[5] == "old" {
                operation = Operation(method: operationArray[4] == "+" ? .add : .multiply, oldValue: true)
            } else {
                operation = Operation(method: operationArray[4] == "+" ? .add : .multiply, value: Int(operationArray[5])!)
            }
            
            let testDiviseBy: Int = Int(monkey[3].firstMatch(of: testDiviseByRegex)!.0)!
            let testTrueDestinationMonkey: Int = Int(monkey[4].firstMatch(of: testDestinationRegex)!.0)!
            let testFalseDestinationMonkey: Int = Int(monkey[5].firstMatch(of: testDestinationRegex)!.0)!

            monkeysArray.append(Monkey(id: id, items: items, operation: operation, testDiviseBy: testDiviseBy, testTrueDestinationMonkey: testTrueDestinationMonkey, testFalseDestinationMonkey: testFalseDestinationMonkey))
        }

        return monkeysArray
    }
}

import Foundation

@main
public struct DayEight {

    struct TreeView {
        var isVisible: Bool
        let treesVisible: Int
    }

    public static func main() {
        let dayEight = DayEight()

        let exampleInput: String = """
        30373
        25512
        65332
        33549
        35390
        """

        let input: [String] = dayEight.parseInput(input: PuzzleInput().input)
        // let input: [String] = dayEight.parseInput(input: exampleInput)

        var totalScore: Int = 0

        var biggestScenicScore: Int = 0

        for xIndex in 0..<input.count {
            for yIndex in 0..<input[xIndex].count {

                let treeCoordinates: [Int] = [xIndex, yIndex]
                let treeVisible: TreeView = dayEight.checkTreeVisible(treeCoordinates: treeCoordinates, trees: input)

                if treeVisible.isVisible {
                    totalScore += 1
                }

                if treeVisible.treesVisible > biggestScenicScore {
                    biggestScenicScore = treeVisible.treesVisible
                }
            }
        }

        print("Part 1: \(totalScore)")
        print("Part 2: \(biggestScenicScore)")
    }

    func checkTreeVisible(treeCoordinates: [Int], trees: [String]) -> TreeView {

        let tree: Character = trees[treeCoordinates[0]][treeCoordinates[1]]

        let treesInAllDirections: [String] = getTreesInAllDirections(trees: trees, treeCoordinates: treeCoordinates)
        let treesLeft: String = treesInAllDirections[0]
        let treesRight: String = treesInAllDirections[1]
        let treesTop: String = treesInAllDirections[2]
        let treesBottom: String = treesInAllDirections[3]

        let treesLeftBigger: TreeView = checkTreesDirectionBigger(tree: Int(String(tree)) ?? 0, treesInDirection: treesLeft)
        let treesRightBigger: TreeView = checkTreesDirectionBigger(tree: Int(String(tree)) ?? 0, treesInDirection: treesRight)
        let treesTopBigger: TreeView = checkTreesDirectionBigger(tree: Int(String(tree)) ?? 0, treesInDirection: treesTop)
        let treesBottomBigger: TreeView = checkTreesDirectionBigger(tree: Int(String(tree)) ?? 0, treesInDirection: treesBottom)

        var treeView: TreeView = TreeView(isVisible: false, treesVisible: treesLeftBigger.treesVisible * treesRightBigger.treesVisible * treesTopBigger.treesVisible * treesBottomBigger.treesVisible)

        if treesLeftBigger.isVisible || treesRightBigger.isVisible || treesTopBigger.isVisible || treesBottomBigger.isVisible {
            treeView.isVisible = true
        }

        return treeView
    }

    func getTreesInAllDirections(trees: [String], treeCoordinates: [Int]) -> [String] {

        let width: Int = trees[treeCoordinates[0]].count
        let height: Int = trees.count

        let left: String = String(trees[treeCoordinates[0]][0..<treeCoordinates[1]])

        var right: String = String(trees[treeCoordinates[0]][treeCoordinates[1]..<width])
        if right.count > 0 {
            right.removeFirst()
        }

        var top: String = ""
        var bottom: String = ""

        for i in 0..<height {
            if i == treeCoordinates[0] {
                continue
            }

            if i < treeCoordinates[0] {
                top += String(trees[i][treeCoordinates[1]])
            } else {
                bottom += String(trees[i][treeCoordinates[1]])
            }
        }

        return [String(left.reversed()), right, String(top.reversed()), bottom]
        
    }

    func checkTreesDirectionBigger(tree: Int, treesInDirection: String) -> TreeView {

        var treesVisble: Int = 0

        for otherTree in treesInDirection {
            let otherTreeInt: Int = Int(String(otherTree)) ?? 0
            treesVisble += 1

            if otherTreeInt >= tree {
                return TreeView(isVisible: false, treesVisible: treesVisble)
            }
        }
        
        return TreeView(isVisible: true, treesVisible: treesVisble)
    }

    func parseInput(input: String) -> [String] {
        let inputArray: [String] = input.components(separatedBy: CharacterSet.newlines)
        
        return inputArray
    }
}

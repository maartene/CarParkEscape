import Testing
@testable import CarParkEscape

func escape(_ carpark: [[Int]]) -> [String] {
    var result = [String]()
    let startingFloor = carpark.firstIndex { floor in 
        floor.contains(2)
    }!

    var position = carpark[startingFloor].firstIndex(of: 2)!

    let exitFloor = carpark.count - 1
    
    var currentFloor = startingFloor
    if startingFloor < exitFloor {
        let stairsPosition = carpark[currentFloor].firstIndex(of: 1)!
        
        let steps = stairsPosition - position
        let direction = stairsPosition > position ? "R" : "L"
        
        result.append(contentsOf: ["\(direction)\(abs(steps))", "D1"])
        position += steps
        currentFloor += 1
    }

    let steps = carpark[currentFloor].count - position - 1
    
    result.append("R\(steps)")

    return result
}

@Suite("escape should") struct CarParkEscapeTests {
    @Test("return R1 when parking right next to the exit") func nextToExit() {
        let carPark = [
            [2, 0]
        ]

        let expectedPath = ["R1"]

        #expect(escape(carPark) == expectedPath)
    }

    @Test("return R4 when parking four spots away (all the way to the left), on the same floor as the exit") func onTheSameFloorAsExit_coupleOfSpotsAway_allTheWayToTheLeft() {
        let carPark = [
            [2, 0, 0, 0, 0]
        ]

        let expectedPath = ["R4"]

        #expect(escape(carPark) == expectedPath)
    }

    @Test("return R2 when parking in the middle of the floor of the exit") func onTheSameFloorAsExit_coupleOfSpotsAway_inTheMiddle() {
        let carPark = [
            [0, 0, 2, 0, 0]
        ]

        let expectedPath = ["R2"]

        #expect(escape(carPark) == expectedPath)
    }

    @Test("return [L1, D1, R3] when parking right next to the stairs on the second floor") func rightNextToStairsOnSecondFloor() {
        let carPark = [
            [0, 1, 2, 0, 0],
            [0, 0, 0, 0, 0]
        ]

        let expectedPath = ["L1", "D1", "R3"]

        #expect(escape(carPark) == expectedPath)
    }
    
    @Test("return [L2, D1, R3] when parking further right to the stairs on the second floor") func furtherRightToStairsOnSecondFloor() {
        let carPark = [
            [0, 1, 0, 2, 0],
            [0, 0, 0, 0, 0]
        ]

        let expectedPath = ["L2", "D1", "R3"]

        #expect(escape(carPark) == expectedPath)
    }
    
    @Test("return [R2, D1, R3] when parking further left of the stairs on the second floor") func furtherLeftToStairsOnSecondFloor() {
        let carPark = [
            [2, 0, 1, 0, 0, 0],
            [0, 0, 0, 0, 0, 0]
        ]

        let expectedPath = ["R2", "D1", "R3"]

        #expect(escape(carPark) == expectedPath)
    }
}

// Codewars examples
// @Test("A simple 2 story carpark returns the correct path") func twoStoryCarParkExample() {
//     let carPark = [
//         [1, 0, 0, 0, 2],
//         [0, 0, 0, 0, 0]
//     ]
    
//     let expectedPath = ["L4", "D1", "R4"]
    
//     #expect(escape(carPark) == expectedPath)
// }

// @Test("For a specific three story carpark, we return the correct path") func threeStoryCarParkExample() {
//     let carpark = [[2, 0, 0, 1, 0],
//                    [0, 0, 0, 1, 0],
//                    [0, 0, 0, 0, 0]]
    
//     let expectedPath = ["R3", "D2", "R1"]
    
//     #expect(escape(carpark) == expectedPath)
    
// }

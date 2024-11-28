import Testing
@testable import CarParkEscape

func escape(_ carpark: [[Int]]) -> [String] {
    var result = [String]()

    let startingFloor = Array(carpark.reversed()).firstIndex { floor in 
        floor.contains(2)
    }!

    if startingFloor > 0 {
        result.append(contentsOf: ["L1", "D1"])
    }

    let position = carpark[0].firstIndex(of: 2)!
    let steps = carpark[0].count - position - 1
    
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

    @Test("return [L1, D1, R2] when parking right next to the stairs on the second floor") func rightNextToStairsOnSecondFloor() {
        let carPark = [
            [0, 1, 2, 0, 0],
            [0, 0, 0, 0, 0]
        ]

        let expectedPath = ["L1", "D1", "R2"]

        #expect(escape(carPark) == expectedPath)
    }
}

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

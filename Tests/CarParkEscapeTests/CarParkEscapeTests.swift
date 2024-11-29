import Testing
@testable import CarParkEscape

func escape(_ carpark: [[Int]]) -> [String] {
    func movementInstruction(floor: [Int], position: Int) -> (steps: Int, instruction: String) {
        let targetPosition = floor.firstIndex(of: 1) ?? floor.count - 1
        
        let steps = targetPosition - position
        let direction = targetPosition > position ? "R" : "L"
        
        return (steps, "\(direction)\(abs(steps))")
    }
    
    var result = [String]()
    let startingFloor = carpark.firstIndex { floor in 
        floor.contains(2)
    }!

    var position = carpark[startingFloor].firstIndex(of: 2)!

    let exitFloor = carpark.count - 1
    
    var currentFloor = startingFloor
    if startingFloor < exitFloor {
        let movementInstruction = movementInstruction(floor: carpark[currentFloor], position: position)
        
        result.append(contentsOf: [movementInstruction.instruction, "D1"])
        position += movementInstruction.steps
        currentFloor += 1
    }
    
    let movementInstruction = movementInstruction(floor: carpark[currentFloor], position: position)
    
    result.append(movementInstruction.instruction)

    return result
}

@Suite("escape should") struct CarParkEscapeTests {
    @Test("return the expected escape path for a specific single floor parking garage and parking spot", arguments: [
        ([[2, 0]], ["R1"]),
        ([[2, 0, 0, 0, 0]], ["R4"]),
        ([[0, 0, 2, 0, 0]], ["R2"])
    ]) func escapePathsForSpecificSingleFloorCarParkAndParkingSpot(testcase: (carpark: [[Int]], expectedPath: [String])) {
        #expect(escape(testcase.carpark) == testcase.expectedPath)
    }
    
    @Test("return the expected escape path for two stoor parking garages and parking spots", arguments: [
        ([
            [0, 1, 2, 0, 0],
            [0, 0, 0, 0, 0]
        ], ["L1", "D1", "R3"]),
        ([
            [0, 1, 0, 2, 0],
            [0, 0, 0, 0, 0]
        ], ["L2", "D1", "R3"]),
        ([
            [2, 0, 1, 0, 0, 0],
            [0, 0, 0, 0, 0, 0]
        ], ["R2", "D1", "R3"])
    ]) func escapePathsForSpecificTwoFloorCarParkAndParkingSpot(testcase: (carpark: [[Int]], expectedPath: [String])) {
        #expect(escape(testcase.carpark) == testcase.expectedPath)
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

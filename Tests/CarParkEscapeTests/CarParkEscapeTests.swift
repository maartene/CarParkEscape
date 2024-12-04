import Testing
@testable import CarParkEscape

struct MovementInstruction: Equatable {
    let steps: Int
    let direction: String
    
    var toString: String {
        "\(direction)\(steps)"
    }
    
    static func makeMovementInstruction(floor: [Int], position: Int) -> MovementInstruction {
        let targetPosition = floor.firstIndex(of: 1) ?? floor.count - 1
        
        let distanceToTarget = abs(targetPosition - position)
        
        if distanceToTarget == 0 {
            return MovementInstruction(steps: 1, direction: "D")
        } else {
            return MovementInstruction(steps: distanceToTarget, direction: targetPosition > position ? "R" : "L")
        }
    }
}

func escape(_ carpark: [[Int]]) -> [String] {
    var movementInstructions = [MovementInstruction]()
    let startingFloor = carpark.firstIndex { floor in
        floor.contains(2)
    }!

    var position = carpark[startingFloor].firstIndex(of: 2)!

    let exitFloor = carpark.count - 1
    let exitPosition = carpark[exitFloor].count - 1
    
    var currentFloor = startingFloor
    var downCount = 0
    while currentFloor != exitFloor || position != exitPosition  {
        let movementInstruction = MovementInstruction.makeMovementInstruction(floor: carpark[currentFloor], position: position)
        
        if movementInstruction.direction == "D" {
            downCount += 1
        } else {
            if downCount > 0 {
                movementInstructions.append(MovementInstruction(steps: downCount, direction: "D"))
                downCount = 0
            }
            movementInstructions.append(movementInstruction)
        }
        
        switch movementInstruction.direction {
        case "R":
            position += movementInstruction.steps
        case "L":
            position -= movementInstruction.steps
        case "D":
            currentFloor += movementInstruction.steps
        default:
            fatalError("Only R, L and D are valid directions.")
        }
    }

    if downCount > 0 {
        movementInstructions.append(MovementInstruction(steps: downCount, direction: "D"))
    }
    
    return movementInstructions.map { $0.toString }
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
    
   @Test("return the expected escape path for three store parking garages and parking spots", arguments: [
       ([
           [0, 1, 2, 0, 0],
           [0, 0, 1, 0, 0],
           [0, 0, 0, 0, 0]
       ], ["L1", "D1", "R1", "D1", "R2"]),
   ]) func escapePathsForSpecificThreeFloorCarParkAndParkingSpot(testcase: (carpark: [[Int]], expectedPath: [String])) {
       #expect(escape(testcase.carpark) == testcase.expectedPath)
   }
    
   @Test("return the expected escape path for three store parking garages where you can go down twice", arguments: [
       ([
           [0, 1, 2, 0, 0],
           [0, 1, 0, 0, 0],
           [0, 0, 0, 0, 0],
       ], ["L1", "D2", "R3"])
   ]) func escapePathsForSpecificThreeFloorCarParkAndParkingSpot_whereYouCanGoDownTwice(testcase: (carpark: [[Int]], expectedPath: [String])) {
       #expect(escape(testcase.carpark) == testcase.expectedPath)
   }
}

// Codewars examples
@Test("A simple 2 story carpark returns the correct path") func twoStoryCarParkExample() {
    let carPark = [
        [1, 0, 0, 0, 2],
        [0, 0, 0, 0, 0]
    ]
    
    let expectedPath = ["L4", "D1", "R4"]
    
    #expect(escape(carPark) == expectedPath)
}

@Test("For a specific three story carpark, we return the correct path") func threeStoryCarParkExample() {
    let carpark = [[2, 0, 0, 1, 0],
                   [0, 0, 0, 1, 0],
                   [0, 0, 0, 0, 0]]
    
    let expectedPath = ["R3", "D2", "R1"]
    
    #expect(escape(carpark) == expectedPath)
}

@Test("For this four story carpark, we return the correct path") func fourStoryCarParkExample() {
    let carpark = [
        [0, 2, 0, 0, 1],
        [0, 0, 0, 0, 1],
        [0, 0, 0, 0, 1],
        [0, 0, 0, 0, 0]
    ]

    #expect(escape(carpark) == ["R3", "D3"])
}
    
@Test("For this other four story carpark, we return the correct path") func otherFourStoryCarParkExample() {
    let carpark = [
        [1, 0, 0, 0, 2],
        [0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0],
        [0, 0, 0, 0, 0]
    ]

    #expect(escape(carpark) == ["L4", "D1", "R4", "D1", "L4", "D1", "R4"])
}
import Testing
@testable import CarParkEscape

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

func escape(_ carpark: [[Int]]) -> [String] {
    let carPark = Array(carpark.reversed())
    
    // on what floor am I?
    let startingFloor = carPark.first { floor in
        floor.contains { space in
            space == 2
        }
    }!
    
    let startingFloorIndex = carPark.firstIndex { floor in
        floor.contains { space in
            space == 2
        }
    }!
    
    let startingSpot = startingFloor.firstIndex(of: 2)!
    
    var currentFloorIndex = startingFloorIndex
    var currentSpot = startingSpot
    var instructions = [String]()
    
    while currentFloorIndex != 0 {
        let currentFloor = carPark[currentFloorIndex]
        
        // do we need to go left or right?
        let stairsSpot = currentFloor.firstIndex(of: 1)!
        
        let isLeft = stairsSpot < startingSpot
        
        // how many steps
        let steps = abs(stairsSpot - startingSpot)
        
        let instruction = "\(isLeft ? "L" : "R")" + "\(steps)"
        
        instructions.append(instruction)
        currentFloorIndex -= 1
        currentSpot = stairsSpot
        instructions.append("D1")
    }
    
    // process the bottom floor
    let exitSpot = carPark[0].count - 1
    let steps = abs(currentSpot - exitSpot)
    instructions.append("R\(steps)")
    
    return instructions
    
}

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

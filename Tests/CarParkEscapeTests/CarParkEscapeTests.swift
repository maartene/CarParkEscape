import Testing
@testable import CarParkEscape

// This is what ChatNS proposed
func escape(_ carpark: [[Int]]) -> [String] {
    var path: [String] = []
    var currentRow = 0
    
    // Find the starting column
    var currentColumn = carpark[0].firstIndex(of: 2) ?? -1
    
    for row in carpark.indices {
        if carpark[row][currentColumn] == 1 {
            // Move left or right to circumvent obstacles
            let targetColumn = carpark[row].firstIndex(of: 0) ?? currentColumn
            if targetColumn < currentColumn {
                path.append("L\(currentColumn - targetColumn)")
            } else if targetColumn > currentColumn {
                path.append("R\(targetColumn - currentColumn)")
            }
            currentColumn = targetColumn
        }
        
        // If not on the last floor, add down movement
        if row < carpark.count - 1 {
            path.append("D1")
            currentRow += 1
        }
    }
    
    // Handle final horizontal move
    if currentColumn < carpark.last!.count - 1 {
        path.append("R\(carpark.last!.count - currentColumn - 1)")
    } else if currentColumn > 0 {
        path.append("L\(currentColumn)")
    }
    
    return path
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
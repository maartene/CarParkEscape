import Testing
@testable import CarParkEscape

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

func escape(_ carpark: [[Int]]) -> [String] {
    return ["R1"]
}

@Suite("escape should") struct CarParkEscapeTests {
    @Test("return R1 when parking right next to the exit") func nextToExit() {
        let carPark = [
            [2, 0]
        ]

        let expectedPath = ["R1"]

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

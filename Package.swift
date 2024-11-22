// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "CarParkEscape",
    products: [
        .executable(name: "CarParkEscape", targets: ["CarParkEscape"]),
    ],
    dependencies: [
        // Voeg hier afhankelijkheden toe indien nodig
    ],
    targets: [
        .executableTarget(
            name: "CarParkEscape",
            dependencies: []),
        .testTarget(
            name: "CarParkEscapeTests",
            dependencies: ["CarParkEscape"]),
    ]
)

import UIKit

var greeting = "Hello, playground"

struct Example: Codable {
    let body: String
}

let example = Example(body: "Test")
print(example.body)

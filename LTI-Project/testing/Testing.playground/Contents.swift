import Darwin
import Foundation

var a = [Int:Int]()

for i in -10..<10 {
    a[i] = i * 20
}

let sortedKeys = Array(a.keys).sorted()

var str = ""

for key in sortedKeys {
    str += "\(key)"
}

str

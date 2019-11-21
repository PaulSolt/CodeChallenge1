//
//  main.swift
//  CodeChallenge1
//
//  Created by Paul Solt on 11/20/19.
//  Copyright © 2019 Paul Solt. All rights reserved.
//

// All combinations
// Converting letters into numbers
// Squashing numbers together
// Goal is to turn any word into array all combinations using number mapping

import Foundation

/*
Objective: Given a word, generate all possible variations using these rules:
1.    A letter can map to itself or 1
For e.g. 'a' -> ['a', 1]

2.    If 2 numbers are next to each other then add them up
For e.g. for this 2 letter combination 'ab' -> ['ab', '1b', 'a1', '2']

So the word 'word' would map to:
'word' ->  ["word", "wor1", "wo1d", "wo2", "w1rd", "w1r1", "w2d", "w3", "1ord", "1or1", "1o1d", "1o2", "2rd", "2r1", "3d", "4"]
*/

func testEqual(expected: String, actual: String, message: String) {
    if expected == actual {
        print("Passed: \"\(message)\" test")
        print("\tActual: \(actual)")
    } else {
        print("Failed: \"\(message)\" test\n\tExpected: \n\t\t\(expected)\n\tActual:\n\t\t\(actual)")
    }
}

func testEqualArray(expected: [String], actual: [String], message: String) {
    if expected.sorted() == actual.sorted() {
        print("Passed: \"\(message)\" test")
        print("\tActual: \(actual)")
    } else {
        print("Failed: \"\(message)\" test\n\tExpected: \n\t\t\(expected.sorted())\n\tActual:\n\t\t\(actual.sorted())")
    }
}

func generateWords(input: String) -> [String] {
    let array = Array(input)
    let output = chop(array: array)
    return output.map { compress(string: $0) }
}

func baseCase(_ character: Character) -> [String] {
    if character.isNumber {
        return [String(character)]
    } else {
        return [String(character), "1"]
    }
}

func chop(array: [Character]) -> [String] {
    guard let head = array.first else { return [] }
    
    let tail = Array(array.dropFirst())
    
    if tail.isEmpty {
        return baseCase(head)
    }

    var mutations: [String] = []
    let tree = chop(array: tail)
    mutations.append(contentsOf: tree)
    
    var output: [String] = []

    for element in baseCase(head) {
        for mutant in mutations {
            var variation = String(element + mutant)
            // TODO: Memoize? Compress?
            output.append(variation)
        }
    }
    return output
}


func compress(string: String) -> String {
    var output = ""
    var counter = 0
    for  letter in string {
        if letter.isNumber {
            counter += Int(String(letter)) ?? 1
        } else {
            if counter != 0 {
                output.append(String(counter))
            }
            output.append(letter)
            counter = 0
        }
    }
    if counter != 0 {
        output.append(String(counter))
    }
    return output
}

// Test the expansion of the recursive algorithm
let testChop1 = chop(array: ["a"])
testEqualArray(expected: ["a", "1"], actual: testChop1, message: "a")

let testChop2 = chop(array: ["a", "b"])
testEqualArray(expected: ["ab", "a1", "1b", "11"], actual: testChop2, message: "ab")

let testChop3 = chop(array: ["a", "b", "c"])
testEqualArray(expected: ["abc", "ab1", "a1c", "1bc", "11c", "a11", "1b1", "111"], actual: testChop3, message: "abc")

// Test the compression of adjacent numbers
let testCompress1 = "111"
testEqual(expected: "3", actual: compress(string: testCompress1), message: testCompress1)

let testCompress2 = "a11"
testEqual(expected: "a2", actual: compress(string: testCompress2), message: testCompress2)

let testCompress3 = "11b"
testEqual(expected: "2b", actual: compress(string: testCompress3), message: testCompress3)

let testCompress4 = "1b1"
testEqual(expected: "1b1", actual: compress(string: testCompress4), message: testCompress4)

let testCompress5 = "abc"
testEqual(expected: "abc", actual: compress(string: testCompress5), message: testCompress5)

// These tests get a little weird if input has numbers, the compression will always add
// adjacent numbers as if they are 0-9 values, but the resulting value is the end
// result that spans multiple characters

let testCompress6 = "a1119"
testEqual(expected: "a12", actual: compress(string: testCompress6), message: testCompress6)

let testCompress7 = "a51"
testEqual(expected: "a6", actual: compress(string: testCompress7), message: testCompress7)

// Test the final algorithm
let test1 = "abc"
testEqualArray(expected: ["abc", "ab1", "a1c", "1bc", "2c", "a2", "1b1", "3"], actual: generateWords(input: test1), message: test1)

let test2 = "word"
testEqualArray(expected: ["word", "wor1", "wo1d", "wo2", "w1rd", "w1r1", "w2d", "w3", "1ord", "1or1", "1o1d", "1o2", "2rd", "2r1", "3d", "4"], actual: generateWords(input: test2), message: test2)

let test3 = "wor5"
testEqualArray(expected: ["wor5", "wo6", "w1r5", "w7", "1or5", "1o6", "2r5", "8"], actual: generateWords(input: test3), message: test3)

let test4 = "long-word"
testEqualArray(expected: ["1o1g-1o1d", "1o1g-1o2", "1o1g-1or1", "1o1g-1ord", "1o1g-2r1", "1o1g-2rd", "1o1g-3d", "1o1g-4", "1o1g-w1r1", "1o1g-w1rd", "1o1g-w2d", "1o1g-w3", "1o1g-wo1d", "1o1g-wo2", "1o1g-wor1", "1o1g-word", "1o1g1w1r1", "1o1g1w1rd", "1o1g1w2d", "1o1g1w3", "1o1g1wo1d", "1o1g1wo2", "1o1g1wor1", "1o1g1word", "1o1g2o1d", "1o1g2o2", "1o1g2or1", "1o1g2ord", "1o1g3r1", "1o1g3rd", "1o1g4d", "1o1g5", "1o2-1o1d", "1o2-1o2", "1o2-1or1", "1o2-1ord", "1o2-2r1", "1o2-2rd", "1o2-3d", "1o2-4", "1o2-w1r1", "1o2-w1rd", "1o2-w2d", "1o2-w3", "1o2-wo1d", "1o2-wo2", "1o2-wor1", "1o2-word", "1o3w1r1", "1o3w1rd", "1o3w2d", "1o3w3", "1o3wo1d", "1o3wo2", "1o3wor1", "1o3word", "1o4o1d", "1o4o2", "1o4or1", "1o4ord", "1o5r1", "1o5rd", "1o6d", "1o7", "1on1-1o1d", "1on1-1o2", "1on1-1or1", "1on1-1ord", "1on1-2r1", "1on1-2rd", "1on1-3d", "1on1-4", "1on1-w1r1", "1on1-w1rd", "1on1-w2d", "1on1-w3", "1on1-wo1d", "1on1-wo2", "1on1-wor1", "1on1-word", "1on2w1r1", "1on2w1rd", "1on2w2d", "1on2w3", "1on2wo1d", "1on2wo2", "1on2wor1", "1on2word", "1on3o1d", "1on3o2", "1on3or1", "1on3ord", "1on4r1", "1on4rd", "1on5d", "1on6", "1ong-1o1d", "1ong-1o2", "1ong-1or1", "1ong-1ord", "1ong-2r1", "1ong-2rd", "1ong-3d", "1ong-4", "1ong-w1r1", "1ong-w1rd", "1ong-w2d", "1ong-w3", "1ong-wo1d", "1ong-wo2", "1ong-wor1", "1ong-word", "1ong1w1r1", "1ong1w1rd", "1ong1w2d", "1ong1w3", "1ong1wo1d", "1ong1wo2", "1ong1wor1", "1ong1word", "1ong2o1d", "1ong2o2", "1ong2or1", "1ong2ord", "1ong3r1", "1ong3rd", "1ong4d", "1ong5", "2n1-1o1d", "2n1-1o2", "2n1-1or1", "2n1-1ord", "2n1-2r1", "2n1-2rd", "2n1-3d", "2n1-4", "2n1-w1r1", "2n1-w1rd", "2n1-w2d", "2n1-w3", "2n1-wo1d", "2n1-wo2", "2n1-wor1", "2n1-word", "2n2w1r1", "2n2w1rd", "2n2w2d", "2n2w3", "2n2wo1d", "2n2wo2", "2n2wor1", "2n2word", "2n3o1d", "2n3o2", "2n3or1", "2n3ord", "2n4r1", "2n4rd", "2n5d", "2n6", "2ng-1o1d", "2ng-1o2", "2ng-1or1", "2ng-1ord", "2ng-2r1", "2ng-2rd", "2ng-3d", "2ng-4", "2ng-w1r1", "2ng-w1rd", "2ng-w2d", "2ng-w3", "2ng-wo1d", "2ng-wo2", "2ng-wor1", "2ng-word", "2ng1w1r1", "2ng1w1rd", "2ng1w2d", "2ng1w3", "2ng1wo1d", "2ng1wo2", "2ng1wor1", "2ng1word", "2ng2o1d", "2ng2o2", "2ng2or1", "2ng2ord", "2ng3r1", "2ng3rd", "2ng4d", "2ng5", "3g-1o1d", "3g-1o2", "3g-1or1", "3g-1ord", "3g-2r1", "3g-2rd", "3g-3d", "3g-4", "3g-w1r1", "3g-w1rd", "3g-w2d", "3g-w3", "3g-wo1d", "3g-wo2", "3g-wor1", "3g-word", "3g1w1r1", "3g1w1rd", "3g1w2d", "3g1w3", "3g1wo1d", "3g1wo2", "3g1wor1", "3g1word", "3g2o1d", "3g2o2", "3g2or1", "3g2ord", "3g3r1", "3g3rd", "3g4d", "3g5", "4-1o1d", "4-1o2", "4-1or1", "4-1ord", "4-2r1", "4-2rd", "4-3d", "4-4", "4-w1r1", "4-w1rd", "4-w2d", "4-w3", "4-wo1d", "4-wo2", "4-wor1", "4-word", "5w1r1", "5w1rd", "5w2d", "5w3", "5wo1d", "5wo2", "5wor1", "5word", "6o1d", "6o2", "6or1", "6ord", "7r1", "7rd", "8d", "9", "l1n1-1o1d", "l1n1-1o2", "l1n1-1or1", "l1n1-1ord", "l1n1-2r1", "l1n1-2rd", "l1n1-3d", "l1n1-4", "l1n1-w1r1", "l1n1-w1rd", "l1n1-w2d", "l1n1-w3", "l1n1-wo1d", "l1n1-wo2", "l1n1-wor1", "l1n1-word", "l1n2w1r1", "l1n2w1rd", "l1n2w2d", "l1n2w3", "l1n2wo1d", "l1n2wo2", "l1n2wor1", "l1n2word", "l1n3o1d", "l1n3o2", "l1n3or1", "l1n3ord", "l1n4r1", "l1n4rd", "l1n5d", "l1n6", "l1ng-1o1d", "l1ng-1o2", "l1ng-1or1", "l1ng-1ord", "l1ng-2r1", "l1ng-2rd", "l1ng-3d", "l1ng-4", "l1ng-w1r1", "l1ng-w1rd", "l1ng-w2d", "l1ng-w3", "l1ng-wo1d", "l1ng-wo2", "l1ng-wor1", "l1ng-word", "l1ng1w1r1", "l1ng1w1rd", "l1ng1w2d", "l1ng1w3", "l1ng1wo1d", "l1ng1wo2", "l1ng1wor1", "l1ng1word", "l1ng2o1d", "l1ng2o2", "l1ng2or1", "l1ng2ord", "l1ng3r1", "l1ng3rd", "l1ng4d", "l1ng5", "l2g-1o1d", "l2g-1o2", "l2g-1or1", "l2g-1ord", "l2g-2r1", "l2g-2rd", "l2g-3d", "l2g-4", "l2g-w1r1", "l2g-w1rd", "l2g-w2d", "l2g-w3", "l2g-wo1d", "l2g-wo2", "l2g-wor1", "l2g-word", "l2g1w1r1", "l2g1w1rd", "l2g1w2d", "l2g1w3", "l2g1wo1d", "l2g1wo2", "l2g1wor1", "l2g1word", "l2g2o1d", "l2g2o2", "l2g2or1", "l2g2ord", "l2g3r1", "l2g3rd", "l2g4d", "l2g5", "l3-1o1d", "l3-1o2", "l3-1or1", "l3-1ord", "l3-2r1", "l3-2rd", "l3-3d", "l3-4", "l3-w1r1", "l3-w1rd", "l3-w2d", "l3-w3", "l3-wo1d", "l3-wo2", "l3-wor1", "l3-word", "l4w1r1", "l4w1rd", "l4w2d", "l4w3", "l4wo1d", "l4wo2", "l4wor1", "l4word", "l5o1d", "l5o2", "l5or1", "l5ord", "l6r1", "l6rd", "l7d", "l8", "lo1g-1o1d", "lo1g-1o2", "lo1g-1or1", "lo1g-1ord", "lo1g-2r1", "lo1g-2rd", "lo1g-3d", "lo1g-4", "lo1g-w1r1", "lo1g-w1rd", "lo1g-w2d", "lo1g-w3", "lo1g-wo1d", "lo1g-wo2", "lo1g-wor1", "lo1g-word", "lo1g1w1r1", "lo1g1w1rd", "lo1g1w2d", "lo1g1w3", "lo1g1wo1d", "lo1g1wo2", "lo1g1wor1", "lo1g1word", "lo1g2o1d", "lo1g2o2", "lo1g2or1", "lo1g2ord", "lo1g3r1", "lo1g3rd", "lo1g4d", "lo1g5", "lo2-1o1d", "lo2-1o2", "lo2-1or1", "lo2-1ord", "lo2-2r1", "lo2-2rd", "lo2-3d", "lo2-4", "lo2-w1r1", "lo2-w1rd", "lo2-w2d", "lo2-w3", "lo2-wo1d", "lo2-wo2", "lo2-wor1", "lo2-word", "lo3w1r1", "lo3w1rd", "lo3w2d", "lo3w3", "lo3wo1d", "lo3wo2", "lo3wor1", "lo3word", "lo4o1d", "lo4o2", "lo4or1", "lo4ord", "lo5r1", "lo5rd", "lo6d", "lo7", "lon1-1o1d", "lon1-1o2", "lon1-1or1", "lon1-1ord", "lon1-2r1", "lon1-2rd", "lon1-3d", "lon1-4", "lon1-w1r1", "lon1-w1rd", "lon1-w2d", "lon1-w3", "lon1-wo1d", "lon1-wo2", "lon1-wor1", "lon1-word", "lon2w1r1", "lon2w1rd", "lon2w2d", "lon2w3", "lon2wo1d", "lon2wo2", "lon2wor1", "lon2word", "lon3o1d", "lon3o2", "lon3or1", "lon3ord", "lon4r1", "lon4rd", "lon5d", "lon6", "long-1o1d", "long-1o2", "long-1or1", "long-1ord", "long-2r1", "long-2rd", "long-3d", "long-4", "long-w1r1", "long-w1rd", "long-w2d", "long-w3", "long-wo1d", "long-wo2", "long-wor1", "long-word", "long1w1r1", "long1w1rd", "long1w2d", "long1w3", "long1wo1d", "long1wo2", "long1wor1", "long1word", "long2o1d", "long2o2", "long2or1", "long2ord", "long3r1", "long3rd", "long4d", "long5"], actual: generateWords(input: test4), message: test4)

// Recursion fails for long words
let testMax1 = "a-very-long-wo"       // 14 characters completes
print("testMax1: \(testMax1) has \(generateWords(input: testMax1).count) words")

let testMax2 = "a-very-long-wor"
let crashXcode = generateWords(input: testMax2)
let length = crashXcode.description.count
print("crashXcodeOutput: \(testMax2) has \(crashXcode.count) words and \(length) character output")
// 15+ characters crashes Xcode (output word array is too long print)
// Running app on terminal works fine
print("testMax2: \(testMax2) has \(crashXcode) words")

// The amount of words we create will explode as the word length gets longer
// this currently is not solved with the current implementation of the algorithm
// the word "dictionary" grows exponentially by 2^x
for i in 0...18 {
    let word = String(repeating: "a", count: i)
    print("testCount\(i): \(word) has \(generateWords(input: word).count) words")
}

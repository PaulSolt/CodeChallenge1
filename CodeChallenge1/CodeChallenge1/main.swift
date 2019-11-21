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
        print("Failed: \"\(message)\" test\n\tExpected: \n\t\t\(expected)\n\tActual:\n\t\t\(actual))")
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
    return chop(array: array)
}

func chop(array: [Character]) -> [String] {
    guard let head = array.first else { return [] }
    
    let tail = Array(array.dropFirst()) // abc -> bc
    
    if tail.isEmpty {
        return [String(head), "1"]
    }

    var mutations: [String] = []
    let tree = chop(array: tail)  // [ bc, b1, 1c, 2] // 11
    mutations.append(contentsOf: tree)
    
    print("head: \(head)")
    print("M1: \(mutations)")
    
    var output: [String] = []
    print("parent: \(String(array))")
    for element in [String(head), "1"] {
        for mutant in mutations {
            let variation = String(element + mutant)
            print("variation: \(variation)")
            
            // TODO: compress
            output.append(variation)
        }
    }
    
    print("array: \(array)")
    print("head: \(head)")
    print("tail: \(tail)")
    print("Mutations: \(mutations)")
    print("output: \(output)")
    print()
    return output
}


func compress(string: String) -> String {
    var output = ""
    var counter = 0
    for  letter in string {
//        print("letter: \(letter)")
        if letter.isNumber {
            counter += 1
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
let test4 = generateWords(input: "abc")
testEqualArray(expected: ["abc", "ab1", "a1c", "1bc", "11c", "a11", "1b1", "111"], actual: test4, message: "abc")

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


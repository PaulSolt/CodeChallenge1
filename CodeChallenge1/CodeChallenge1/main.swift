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

func makeWordNumber(input: String) -> [String] {
    
    // 1. Generate an array of letters replaced
    
    // iterate through each letter and replace with 1
    
    // walk through the string array
    // track current index
    // convert the current letter to a 1
    
    // ab
    // 1b
    
    // TODO: bounds for zero length input
    // guard let
    
    // word[index]  // replace character in subrange
    var index = 0
    var output: [String] = [input] // input, "1"]
    
    //let array = Array(input) // "a" "b" -> join
    
    for i in 0..<input.count  {
        let range = NSRange(index...index) // +1
        var word = NSString(string: input) // ab
        
        print(word)
        var newWord = word.replacingCharacters(in: range, with: "1")
        
        output.append(String(newWord))
        
        // TODO: turn wor1 into [wo11, w1r1, 1or1]
        
        index += 1
    }
    
    
    
    // 2. Squash the adjacent numbers
    
    return output
    
}

let test1 = makeWordNumber(input: "a")
print(test1) // ["a", "1"]
assert(["a", "1"] == test1)

//let test2 = makeWordNumber(input: "ab")
//print(test2) // ["ab", "1b", "a1", "2"]

//assert(["ab", "1b", "a1", "2"] == test2)

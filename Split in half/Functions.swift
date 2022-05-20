//
//  Functions.swift
//  Split in half
//
//  Created by ab86008 on 2022-05-20.
//

import Foundation


func getCharacter (str: String, nbr: Int)  -> Character {
    //Returnerar bokstav nbr från sträng str. O-index
    
    return str[str.index(str.startIndex, offsetBy: nbr)]
    
}


func getFirstWord (str: String) -> String {

    var i = 0
    var char = getCharacter(str: str, nbr: i)
    
    while char != " " {
        i += 1
        char = getCharacter(str: str, nbr: i)
    }
    
    return String(str.dropLast(str.count - i))
}

func getLastWord (str: String) -> String {

    var i = str.count - 1
    var wordLength = 0
    var char = getCharacter(str: str, nbr: i)
    
    while char != " " {
        i -= 1
        wordLength += 1
        char = getCharacter(str: str, nbr: i)
    }
    
    return String(str.dropFirst(str.count - wordLength))
}

func removeFirstWord (str: String) -> String {

    var i = 0
    var char = getCharacter(str: str, nbr: i)
    
    while char != " " {
        i += 1
        char = getCharacter(str: str, nbr: i)
    }
    
    return String(str.dropFirst(i + 1))
}


func getLastWord () -> String {
    
    return "word"
}



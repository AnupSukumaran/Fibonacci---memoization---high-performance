//
//  ViewController.swift
//  Memoization
//
//  Created by Paul Hudson on 02/06/2020.
//  Copyright © 2020 Paul Hudson. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    //let memoizedFibonacci = memoization(fibonacci(_:))
    
    let memoizedFibonacci = recursiveMemoization { fibonacci, number in
        number < 2 ? number : fibonacci(number - 1) + fibonacci(number - 2)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        40
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = String(memoizedFibonacci(indexPath.row))
        return cell
    }
}


//var fibonacciCache: [Int: Int] = [:]
//
//func fibonacci(_ number: Int) -> Int {
//    if let val = fibonacciCache[number] {
//        return val
//    }
//
//    let newValue = number < 2 ? number : fibonacci(number - 1) + fibonacci(number - 2)
//    fibonacciCache[number] = newValue
//
//    return newValue
//}

//func fibonacci(_ number: Int) -> Int {
//    number < 2 ? number : fibonacci(number - 1) + fibonacci(number - 2)
//}


func memoization<Input: Hashable, Output>(_ function: @escaping (Input) -> Output) -> ((Input) -> Output) {
    
    var storage = [Input: Output]()
    
    let handler = { input in
        
        if let val = storage[input] {
            return val
        }
        
        let newVal = function(input)
        storage[input] = newVal
        return newVal
    }
    
    return handler
    
}

func recursiveMemoization<Input: Hashable, Output>(_ function: @escaping ((Input) -> Output, Input) -> Output) -> ((Input) -> Output) {
    
    var storage = [Input: Output]()
    var memo: ((Input) -> Output)!
    
    memo = { input in
        
        if let val = storage[input] {
            return val
        }
        
        let newVal = function(memo, input)
        storage[input] = newVal
        return newVal
    }
    
    return memo
    
}

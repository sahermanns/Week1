//: Playground - noun: a place where people can play

import UIKit

//CODING CHALLENGE: Write a function that reverses an array
var numbersArray = [1,2,3,4,5,6,7,8,9,10]
//var arrayReversed = reverse(array)
//println(arrayReversed)

func reverse(numbers:[Int]) -> [Int] {
  var arrayReversed = [Int]()
  
  for number in numbers {
    arrayReversed.insert(number, atIndex: 0)
  }
  return arrayReversed
}
reverse(numbersArray)


//CODING CHALLENGE: FIZZ BUZZ!! :
//Print the numbers 1..100
//For multiples of 3, print "Fizz" instead of the number
//For multiples of 5, print "Buzz" instead of the number
//For multiples of 3 and 5, print "FizzBuzz" instead of the number
//

var x = 0

for var x = 1; x <= 100; x++ {
  
    if x % 3 == 0 {
      println("Fizz")
    } else if x % 5 == 0{
     println("Buzz")
    } else if x % 3 == 0 && x % 5 == 0 {
      println("Fizz Buzz")
    }else {
      println(x)
  }
    }



//CODING CHALLENGE: Return the number of times that the string "hi" appears anywhere in the given string.

var song = "hi ho lo do hit him in the shit"

func removeHi (find: String) -> Int {
  
  
}


//CODING CHALLENGE: Given a string, return a version where all the "x" have been removed. Except an "x" at the very start or end should not be removed.

var hugsAndKisses = "xoxoxoxoxoxoxoxoxoxoxox"

//func removeX (kisses:String) -> String {
//  
//  
//}

//DATA STRUCTURE THURSDAY: Implement a queue.

class Queue {
  var animals = ["zebra", "lion", "donkey","giraffe"]

  func push (animal: String){
  animals.append(animal)
  }

  func pop() -> String {
  let animalToPop = animals[0]
  animals.removeAtIndex(0)
  return animalToPop  
  }
}

let newQueue = Queue()
newQueue.pop()
newQueue.push("monkey")






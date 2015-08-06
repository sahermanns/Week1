//: Playground - noun: a place where people can play

import UIKit

//CODING CHALLENGE: Write a function that reverses an array
var array = [1,2,3,4,5,6,7,8,9,10]
var arrayReversed = reverse(array)
println(arrayReversed)


//CODING CHALLENGE: FIZZ BUZZ!! :
//Print the numbers 1..100
//For multiples of 3, print "Fizz" instead of the number
//For multiples of 5, print "Buzz" instead of the number
//For multiples of 3 and 5, print "FizzBuzz" instead of the number
//

for var i = 1; i <= 100; i++ {
  println(i)
}

var fizzArray = [AnyObject]()


for (index, x) in enumerate (array) {
  if x % 3 == 0{
    insert("Fizz", atIndex: x)
  } else {
    }
  if x % 5 == 0 {
    insert("Buzz", atIndex: x)
  } else {
    }
  if x % 3 == 0 && x % 5 == 0 {
    insert("Fizz Buzz", atIndex: x)
  }else{
    
  }
    
  }
  
}
 


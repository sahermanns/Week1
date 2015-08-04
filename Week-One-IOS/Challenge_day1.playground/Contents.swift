//: Playground - noun: a place where people can play

import UIKit

//for var i = 1; i < 10; i = i + 1 {
//  println(i)
//}
//
//for var i = 10; i > 0; i = i - 1 {
//  println(i)
//}
//println(array.count)

var array = [1,2,3,4,5,6,7,8]
var reverseArray = (reverse(array))

array.insert(8, atIndex: 0)
array.insert(7, atIndex: 1)
array.insert(6, atIndex: 2)
array.insert(5, atIndex: 3)
array.insert(4, atIndex: 4)
array.insert(3, atIndex: 5)
array.insert(2, atIndex: 6)
array.insert(1, atIndex: 7)
println(array.count)
array.removeLast()
array.removeLast()
array.removeLast()
array.removeLast()
array.removeLast()
array.removeLast()
array.removeLast()
array.removeLast()

println(array)

var abcArray = ["a","b","c"]
var reverseAbcArray = (reverse(abcArray))
abcArray.insert("c", atIndex:0)
abcArray.removeLast()
abcArray.insert("b", atIndex: (0 + 1))
abcArray.removeLast()







//var stringLength = array.count
//
//
////for (index, x) in enumerate(array){
////  array[index] = array[index]+ array.count
////}
//
////
////
////
////println(array[0])
////
////println(array.count)
////
////
//var names = ["Sarah","John","Dan","Suzie"]
//println(names)
//println(reverse(names))
//println(names.count)
//println(names.last!)
//names.append("harry")
//names.append(names[0])
//println(names)
//
//var indexCount = names.count
//
//
//
//for (index, x) in enumerate(array){
//  println(index)
//}
//
//
//for (index, x) in enumerate(array){
//  println(array)
//}
//
//for (index, x) in enumerate(names){
//  println(index)
//}
//
//for (index, x) in enumerate(names){
//  println(names)
//}
//
//println(names.count)
//println(names[0])
//println(names[0+1])
//
//var emptyArray = [Int]()
//emptyArray += [5, 10, 22, 61]
////same as emptyArray.append(5)


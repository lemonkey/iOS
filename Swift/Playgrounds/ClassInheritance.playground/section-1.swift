// Class inheritance

import UIKit

class Foo
{
	let name: String
	let age: Int
	var modified: Bool
	
	init(name: String, age: Int)
	{
		self.name = name
		self.age = age
		self.modified = false
	}
}

let bar = Foo(name:"Foo", age:20)

bar.modified = true


class FooSub : Foo
{
	let other: String
	
	init(other: String)
	{
		self.other = other
		
		super.init(name: "FooSub", age: 10)
	}
}

let barSub = FooSub(other: "subclass of Foo")

println("barSub name: \(barSub.name), age: \(barSub.age), other: \(barSub.other)")

barSub.modified = true


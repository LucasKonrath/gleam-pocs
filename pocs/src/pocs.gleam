import gleam/io
import gleam/int
import gleam/string
import gleam/list
import gleam/result

pub type Person {
  Person(name: String, age: Int)
}

pub type Animal {
  Dog(name: String, breed: String)
  Cat(name: String, indoor: Bool)
  Bird(name: String, can_fly: Bool)
}

pub type Color {
  Red
  Green
  Blue
  Custom(red: Int, green: Int, blue: Int)
}

pub fn greet(name: String) -> String {
  "Hello, " <> name <> "!"
}

pub fn add(x: Int, y: Int) -> Int {
  x + y
}

pub fn multiply(x: Int, y: Int) -> Int {
  x * y
}

pub fn describe_animal(animal: Animal) -> String {
  case animal {
    Dog(name, breed) -> name <> " is a " <> breed <> " dog"
    Cat(name, True) -> name <> " is an indoor cat"
    Cat(name, False) -> name <> " is an outdoor cat"
    Bird(name, True) -> name <> " is a bird that can fly"
    Bird(name, False) -> name <> " is a flightless bird"
  }
}

pub fn color_to_hex(color: Color) -> String {
  case color {
    Red -> "#FF0000"
    Green -> "#00FF00"
    Blue -> "#0000FF"
    Custom(r, g, b) -> "#" <> int.to_base16(r) <> int.to_base16(g) <> int.to_base16(b)
  }
}

pub fn process_numbers(numbers: List(Int)) -> List(Int) {
  numbers
  |> list.map(fn(x) { x * 2 })
  |> list.filter(fn(x) { x > 10 })
}

pub fn sum_list(numbers: List(Int)) -> Int {
  list.fold(numbers, 0, fn(acc, x) { acc + x })
}

pub fn safe_divide(x: Int, y: Int) -> Result(Int, String) {
  case y {
    0 -> Error("Cannot divide by zero")
    _ -> Ok(x / y)
  }
}

pub fn handle_division_result(result: Result(Int, String)) -> String {
  case result {
    Ok(value) -> "Result: " <> int.to_string(value)
    Error(message) -> "Error: " <> message
  }
}

pub fn apply_twice(func: fn(Int) -> Int, value: Int) -> Int {
  value |> func |> func
}

pub fn compose(f: fn(b) -> c, g: fn(a) -> b) -> fn(a) -> c {
  fn(x) { f(g(x)) }
}

pub fn main() -> Nil {
  io.println("=== Gleam Language Examples ===\n")

  io.println(greet("Gleam"))
  io.println("2 + 3 = " <> int.to_string(add(2, 3)))
  io.println("4 * 5 = " <> int.to_string(multiply(4, 5)))
  io.println("")

  let person = Person("Alice", 30)
  case person {
    Person(name, age) -> io.println(name <> " is " <> int.to_string(age) <> " years old")
  }

  let animals = [
    Dog("Buddy", "Golden Retriever"),
    Cat("Whiskers", True),
    Bird("Tweety", True),
  ]

  list.each(animals, fn(animal) {
    io.println(describe_animal(animal))
  })


  io.println("Red: " <> color_to_hex(Red))
  io.println("Custom Purple: " <> color_to_hex(Custom(128, 0, 128)))
  io.println("")

  let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  let processed = process_numbers(numbers)
  io.println("Original: " <> string.inspect(numbers))
  io.println("Doubled and filtered (> 10): " <> string.inspect(processed))
  io.println("Sum of original: " <> int.to_string(sum_list(numbers)))
  io.println("")

  let division1 = safe_divide(10, 2)
  let division2 = safe_divide(10, 0)
  io.println(handle_division_result(division1))
  io.println(handle_division_result(division2))
  io.println("")


  let double = fn(x) { x * 2 }
  let result = apply_twice(double, 5)
  io.println("Apply double twice to 5: " <> int.to_string(result))

  let add_one = fn(x) { x + 1 }
  let add_one_then_double = compose(double, add_one)
  io.println("Add 1 then double 3: " <> int.to_string(add_one_then_double(3)))
  io.println("")

  let piped_result = 
    5
    |> add_one
    |> double
    |> int.to_string
  io.println("5 |> add_one |> double |> to_string = " <> piped_result)
}

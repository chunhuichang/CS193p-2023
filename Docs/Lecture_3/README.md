## Lecture 3 - MVVM

Conceptual overview of the architectural paradigm underlying the development of applications for iOS using SwiftUI (known as MVVM).  Explanation of a fundamental component of understanding the Swift programming language: its type system.  Start to apply both of these to Memorize.

[Video](https://www.youtube.com/watch?v=W1ymVx6dmvc)

### MVVM - Design paradigm
- Model
    - Separating `Logic and Data` from `UI`
    - The Truth
- View Model
    - Connecting the `Model` to the `UI`, called gatekeeper
- View
    - UI

![<MVVM>](MVVM.png)

### Swift Type System
- struct V.S. class
    - Both have
        - stored **var**s
        - computed **var**s
        - constant **let**s
        - **func**tions
        - **init**ializers
    - Difference        
        |                   struct                    |                class                |
        | :-----------------------------------------: | :---------------------------------: |
        |                 Value type                  |           Reference type            |
        |       Copied when passed or assigned        |     Passed around via pointers      |
        |                Copy on write                |   Automatically reference counted   |
        |           Functional programming            |     Object-oriented programming     |
        |               No inheritance                |        Inheritance (single)         |
        |    `Free` init initializes ALL **var**s     | `Free` init initializes NO **var**s |
        | Mutability is explicit (**var** vs **let**) |           Always mutable            |

- generics
    - Placeholder for a type
    - Array's declaration like 
        ```swift
        struct Array<Element> {
            ...
            func apped(_ element: Element) { ... }
        }
        ```
    - Type Parameter
        - like Array's `Element`

- protocol
    - A `stripped-down` struct/class, but no implementation (or storage)
    - PortableThing conforms to (aka `behaves like a`) Moveable
        ```swift
        protocol Moveable {
            var hasMoved: Bool { get }
            func move(by: Int)
        }
        struct PortableThing: Moveable {
            var hasMoved: Bool = false

            func move(by: Int) { ... }
        }
        ```
    - protocol inheritance
        ```swift
        protocol Vehicle: Moveable {
            var passengerCount: Int { get set }
        }
        class Car: Vehicle {
            var passengerCount: Int = 5
            var hasMoved: Bool = true
            func move(by: Int) {}
        }
        ```    
    - multiple protocols
        ```swift
        protocol Named {
            var name: String { get }
        }
        protocol Aged {
            var age: Int { get }
        }
        struct Person: Named, Aged {
            var name: String
            var age: Int
        }
        ```    
    - Constrains and gains
        - has to implement, but supply some properties and functions
        - like `Indetifiable`, `Hashable`, `Equatable`
            
- functions
    - Functions are types
    - Closures
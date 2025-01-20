## Lecture 3 - MVVM

Conceptual overview of the architectural paradigm underlying the development of applications for iOS using SwiftUI (known as MVVM).  Explanation of a fundamental component of understanding the Swift programming language: its type system.  Start to apply both of these to Memorize.

[Video](https://www.youtube.com/watch?v=W1ymVx6dmvc)


## Note
### MVVM - Design paradigm
- Separating `Logic and Data` from `UI`
    - Model
        - Logic and Data
        - A struct or an SQL database or any combination of such things
    - View
        - UI
        - Visual manifestation of the Model

- Connecting the `Model` to the `UI`
    - View Model
        - The Model might only be accessible via a `gatekeeper` class

- SwiftUI 
    - Takes care of making sure the UI gets `rebuilt` when a Model `change` affects the UI
    - Primary architecture for complex application

- Model
    - UI independent, include data and logic
    - The Truth, if you want the information you go back the Model

- View
    - Reflects the Model
        - Whatever's happening in the Model, you should see that on screen
    - Stateless
        - It's just always showing what's in the Model
        - @State in our View is not good, it's rare
    - Declared
        - Built using SwiftUI's declarative syntax
    - Reactive
        - Updates automatically when the Model changes

- ViewModel
    - Binds View to Model
    - Roles
        - Interpreter
            - Interprets data for the View
        - Gatekeeper
            - Control the flow between Model and View
        - Processes Intent
            - Receiving user actions from the View
            - Modifying the Model to reflect those actions

- Data Flow
    - Model to View
        - The data flows through the ViewModel to the View
        - Things happen in the Model and it's this ViewModel's job to notice those changes
        - The ViewModel then publishes to the whole world "something changed in the Model"
        - SwiftUI automatically rebuilds the affected parts of the UI
        - notice change -> publish that changes happen -> Swift automatically figures out and redraw them
    - View to Model
        - Calls intent function
            - When someone taps on something in the View they call a function in the ViewModel saying "the user has the following intent"
        - Modifies the Model
            - The ViewModel modifies the Model in whatever way to express whatever the user's intention isintent
        - calls intent function -> modifies the Model
            
- Keyword
    - ViewModel
        - ObservableObject
        - @Published
        - objectWillChange.send()
    - View
        - @ObservedObject
        - @Binding
        - .onReceive
        - @EnvironmentObject
        - .environmentObject()


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
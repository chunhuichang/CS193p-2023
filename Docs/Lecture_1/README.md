## Lecture 1 -  Getting Started with SwiftUI

Start working on the first application of the quarter, a card-matching game called Memorize.  This will be the foundation for the first few weeks of course material.

[Video](https://www.youtube.com/watch?v=n1qabtjZ_jg)

[Reading Assignment 1](https://cs193p.sites.stanford.edu/sites/g/files/sbiybj16636/files/media/file/r1_0.pdf)

## Note
### Impelment `View`
- struct type
- Conforming to `View` Protocol
    - Behaves like a View
    - Rectangular area on screen that draws something and can get events
- Object-Oriented Programming (OOP) vs. Functional Programming (FP)
    - OOP 
        - Data encapsulation
    - FP
        - Behavior encapsulation
- `var body: some View`
    - Computed property
        - Every time someone asks for the value of body, it runs this code. It's read only because it's calculated here, but it's still a var because there might be variables in here that are making it return a different thing every time you call it.
    - some View
        - `some` is a behaves like thing
        - The type of this variable has to be any struct in the world as long as it gehaves like a View.

### Creating instances of structs
- Like Image, Text
- Almost all structs have more than one way to implement them.

### named parameters
- Image(systemName: "globe")
    - Image is just a struct, behaves like a View. And here's its agrument, globe. System name. It's naming that parameter.

### parameter default
- You'll take the default value so you don't have to put it.
- VStack
    - init(alignment: VerticalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder content: () -> Content)
    - VStack { ... }
    - VStack() { ... }
    - VStack(alignment: .leading, spacing: 20) { ... }

### @ViewBuilder
- TupleView (bag of Lego)
    - Turn that list of Views into a TupleView

### View modifyer
- You send them to a View, it modifies the View in some way, and then it returns you a new modified View.
- Apply
    - `.imageScale(.large)` is an image that has had its scale modified to be large
    - `.foregroundColor(.orange)` its color changed to orange
    - `.padding` its padding around view
- Scope
    - Pass it off to the things inside
    - Provide a lot of flexibility to be able to put these things on the outside and have them only applied to the things on the inside that really don't care
### Shape
- struct type
- Conforming to `Shape` Protocol

### Stack
- VStack
    - Vertically from top to bottom
- HStack
    - Horizontally from leading to trailing
- ZStack
    - On top of each other, along the Z-axis (depth)

### Preview
- Color Scheme
    - Dark mode
    - Light mode
- Orientation
    - Landscape
    - Portrait
- Dynamic Type
    - Adjusts font sizes to simulate Accessibility settings

### New View
- Extract `CardView` as struct View
```swift
struct CardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.white)
            RoundedRectangle(cornerRadius: 12)
            Text("🤪")
                .font(.largeTitle)
        }
    }
}
```
- Bool type parameter `isFaceUp`
```swift
struct CardView: View {
    var isFaceUp: Bool = false
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.white)
                RoundedRectangle(cornerRadius: 12)
                Text("🤪")
                    .font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 12)
            }
        }
    }
}
```

## Demo
![Lecture 1 Demo](Lecture_1.png "Lecture 1")

import SwiftUI

public struct ContentView: View {
    public init() {}

    public var body: some View {
        #if DEBUG
        Text("Hello, Debug!")
            .padding()
        #else
        Text("Hello, Release!")
            .padding()
        #endif
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

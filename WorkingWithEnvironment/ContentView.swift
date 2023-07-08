//
//  ContentView.swift
//  WorkingWithEnvironment
//
//  Created by Kelvin KUCH on 03.07.2023.
//

import SwiftUI


/// The shape of the knob
struct KnobShape: Shape {
    var pointerSize: CGFloat = 0.10
    var pointerWidth: CGFloat = 0.10
    
    func path(in rect: CGRect) -> Path {
        let pointerHeight = rect.height * self.pointerSize
        let pointerWidth = rect.width * self.pointerWidth
        let circleRect = rect.insetBy(dx: pointerHeight, dy: pointerHeight)
        
        return Path { p in
            p.addEllipse(in: circleRect)
            p.addRect(CGRect(x: rect.midX - pointerWidth / 2.00, y: 0.00, width: pointerWidth, height: pointerHeight * 2.00))
        }
    }
}

struct Knob: View {
    @Binding var value: Double
    var pointerSize: CGFloat? = nil
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Environment(\.knobPointerSize) var envPointerSize
    @Environment(\.knobColor) var customKnobColor
    
    private var fillColor: Color {
        customKnobColor ?? (colorScheme == .dark ? .white : .black)
    }
    
    
    
    var body: some View {
        KnobShape(pointerSize: pointerSize ?? envPointerSize)
//            .fill(Color.primary)
//            .fill(colorScheme == .dark ? Color.white : Color.black)
            .fill(fillColor)
            .rotationEffect(Angle(degrees: value * 330.00))
            .onTapGesture {
                withAnimation(.default) {
                    self.value = self.value < 0.5 ? 1 : 0
                }
            }
    }
}

struct ContentView: View {
    @State private var value: Double = 0.10
    @State private var useDefaultColor = true
    @State private var hue: Double = 0.00
    @State private var knobSize: CGFloat = 0.1
    
    var body: some View {
        VStack {
            Text("KUCH Knob")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.brown)
            Knob(value: $value)
                .frame(width: 100.00, height: 100.00)
                .knobPointerSize(knobSize)
                .knobColor(useDefaultColor ? .brown : Color(hue: hue, saturation: 1.00, brightness: 1.00))
            
            HStack {
                Text("Value")
                Slider(value: $value, in: 0...1)
            }
            
            HStack {
                Text("Size")
                Slider(value: $knobSize, in: 0...0.40)
            }
            
            HStack {
                Text("Color")
                Slider(value: $hue, in: 0...1)
            }
            
            Toggle(isOn: $useDefaultColor) {
                Text("Default Color")
            }
            
            Button {
                withAnimation(.default) {
                    self.value = self.value == 0 ? 1 : 0
                }
            } label: {
                Text("Toggle")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.brown)
            }

        }
        
        
//        HStack {
//            VStack {
//                Text("Volume")
//                Knob(value: $value)
//                    .frame(width: 100.00, height: 100.00)
////                    .knobPointerSize(0.1)
//            }
//
//            VStack {
//                Text("Balance")
//                Knob(value: $value)
//                    .frame(width: 100.00, height: 100.00)
////                    .knobPointerSize(0.00)
//            }
//
//        }
//        .knobPointerSize(0.10)
////        .debug()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


fileprivate struct PointerSizeKey: EnvironmentKey {
    static let defaultValue: CGFloat = 0.1
}

fileprivate struct ColorKey: EnvironmentKey {
    static let defaultValue: Color? = nil
}

extension EnvironmentValues {
    var knobPointerSize: CGFloat {
        get {
            self[PointerSizeKey.self]
        }
        
        set {
            self[PointerSizeKey.self] = newValue
        }
    }
    
    
    var knobColor: Color? {
        get {
            self[ColorKey.self]
        }
        
        set {
            self[ColorKey.self] = newValue
        }
    }
    
}

extension View {
    func knobPointerSize(_ size: CGFloat) -> some View {
        self.environment(\.knobPointerSize, size)
    }
    
    func knobColor(_ color: Color?) -> some View {
        self.environment(\.knobColor, color)
    }
}

extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        
        return self
    }
}

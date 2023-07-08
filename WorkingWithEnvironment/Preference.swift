//
//  Preference.swift
//  WorkingWithEnvironment
//
//  Created by Kelvin KUCH on 06.07.2023.
//

import SwiftUI


struct MyNavigationTitleKey: PreferenceKey {
    static var defaultValue: String? = nil
    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = value ?? nextValue()
    }
}

extension View {
    func myNavigationTitle(_ title: String) -> some View {
        preference(key: MyNavigationTitleKey.self, value: title)
    }
}

struct MyNavigationView<T>: View where T: View {
    let content: T
    @State private var title: String? = nil
    
    var body: some View {
        VStack {
            Text(title ?? "")
                .font(.largeTitle)
            
            content.onPreferenceChange(MyNavigationTitleKey.self) { title in
                self.title = title
            }
        }
    }
}

struct TabItemKey: PreferenceKey {
    static let defaultValue: [String] = []
    static func reduce(value: inout [String], nextValue: () -> [String]) {
        value.append(contentsOf: nextValue())
    }
}

struct MyTabView: View {
    @State var title: [String] = []
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Array(title.enumerated()), id: \.offset) { item in
                    Text(item.element)
                }
            }
        }.onPreferenceChange(TabItemKey.self) {
            self.title = $0
        }
    }
}

struct Preference: View {
    var body: some View {
//        NavigationView {
//            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//                .navigationBarTitle("Root View")
//                .background(Color.gray)
//        }.debug()
        MyNavigationView(
            content: Text("Hello")
                .myNavigationTitle("ROOT View")
                .background(.brown)
        ).debug()
    }
}

struct Preference_Previews: PreviewProvider {
    static var previews: some View {
//        Preference()
        MyTabView()
    }
}


//extension View {
//    func debug() -> Self {
//        print(Mirror(reflecting: self).subjectType)
//        
//        return self
//    }
//}


//
//NavigationView<
//    ModifiedContent<
//        ModifiedContent<
//            Text, TransactionalPreferenceTransformModifier<NavigationTitleKey>>,
//            _PreferenceTransformModifier<ToolbarKey>
//    >
//>

//NavigationView<
//    ModifiedContent<
//        ModifiedContent<
//            ModifiedContent<Text, TransactionalPreferenceTransformModifier<NavigationTitleKey>>, _PreferenceTransformModifier<ToolbarKey>>, _BackgroundStyleModifier<Color>
//    >
//>

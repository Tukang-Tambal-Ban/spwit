//
//  SignInView.swift
//  spwit
//
//  Created by Muhammad Rifqi Syatria on 8/1/25.
//

import SwiftUI
import UIKit

class GroupDetailView: UIView {
    
    
}

struct MyUIKitViewPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> GroupDetailView {
        GroupDetailView()
    }
    func updateUIView(_ uiView: GroupDetailView, context: Context) { }
}

struct MyUIKitView_Previews: PreviewProvider {
    static var previews: some View {
        MyUIKitViewPreview()
            .frame(width: 300, height: 200)
            .previewLayout(.sizeThatFits)
    }
}

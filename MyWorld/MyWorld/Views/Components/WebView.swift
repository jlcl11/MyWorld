//
//  WebView.swift
//  MyWorld
//
//  Created by José Luis Corral on 23/5/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

#Preview {
    WebView(url: URL(string: "apple.com/es/")!)
}

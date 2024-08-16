//
//  WebView.swift
//  MyWorld
//
//  Created by José Luis Corral López on 14/8/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @ObservedObject var viewModel: WebViewModel
    let webView = WKWebView()

    func makeCoordinator() -> Coordinator {
        Coordinator(self.viewModel)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        private var viewModel: WebViewModel

        init(_ viewModel: WebViewModel) {
            self.viewModel = viewModel
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.viewModel.isLoading = false
            
            webView.evaluateJavaScript("document.body.innerHTML.trim().length == 0") { (result, error) in
                if let isEmpty = result as? Bool, isEmpty {
                    print("El contenido HTML está vacío")
                    self.viewModel.isContentEmpty = true
                } else {
                    print("El contenido HTML no está vacío")
                    self.viewModel.isContentEmpty = false
                }
            }
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            print("Error en la carga de la página: \(error.localizedDescription)")
            self.viewModel.isLoading = false
            self.viewModel.isContentEmpty = true
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            print("Error al intentar cargar la página: \(error.localizedDescription)")
            self.viewModel.isLoading = false
            self.viewModel.isContentEmpty = true
        }
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<WebView>) { }

    func makeUIView(context: Context) -> UIView {
        self.webView.navigationDelegate = context.coordinator
        
        if let url = URL(string: self.viewModel.url), UIApplication.shared.canOpenURL(url) {
            self.webView.load(URLRequest(url: url))
        } else {
            print("URL inválida")
            self.viewModel.isLoading = false
            self.viewModel.isContentEmpty = true
        }

        return self.webView
    }
}


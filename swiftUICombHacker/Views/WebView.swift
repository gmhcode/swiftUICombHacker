//
//  WebView.swift
//  swiftUICombHacker
//
//  Created by Greg Hughes on 10/29/20.
//

import Foundation
import SwiftUI
import WebKit

struct Webview: UIViewRepresentable {
    var url: String
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url) else {return WKWebView.pageNotFound()}

        let request = URLRequest(url:url)
        let wkWebview = WKWebView()
        wkWebview.load(request)
        return wkWebview
    }
    

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: self.url) else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
        
        let request = URLRequest(url: url)
        uiView.load(request)

    }
    
}

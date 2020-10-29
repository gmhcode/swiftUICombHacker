//
//  WKWebView+Extensions.swift
//  swiftUICombHacker
//
//  Created by Greg Hughes on 10/29/20.
//

import Foundation
import WebKit

extension WKWebView {
    static func pageNotFound() -> WKWebView{
        let wk = WKWebView()
        wk.loadHTMLString("<html><body><h1>Page not found!</hq></body></html>", baseURL: nil)
        return wk
    }
}

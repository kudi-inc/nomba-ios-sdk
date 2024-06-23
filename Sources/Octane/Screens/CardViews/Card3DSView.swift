//
//  SwiftUIView.swift
//  
//
//  Created by Bezaleel Ashefor on 23/06/2024.
//

import SwiftUI
import WebKit

struct Card3DSView: View {
    @Environment(\.presentationMode) var presentationMode
    var on3DSSuccessAction : () -> () = {}
    
    @State var urlToVisit = "https://knightbenax.dev"
    
    var body: some View {
        WebView(link: urlToVisit).ignoresSafeArea().frame(maxWidth: .infinity)
    }
    
    
}

struct WebView: UIViewRepresentable {
 
    let webView: WKWebView
    var link : String
    var on3DSSuccessAction : () -> () = {}
    
    init(link: String) {
        webView = WKWebView(frame: .zero)
        self.link = link
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        webView.load(URLRequest(url: URL(string: link)!))
    }
}

#Preview {
    Card3DSView()
}

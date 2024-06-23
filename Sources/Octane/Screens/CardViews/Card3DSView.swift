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
    @Binding var acsUrl : String
    @Binding var jwtToken : String
    @Binding var md : String
    @Binding var termUrl : String
    var callback : String = "https://checkout.nomba.com/callback/"
    var on3DSSuccessAction : () -> () = {}
    @State var isLoading = true
    
    var body: some View {
        ZStack{
            WebView(link: acsUrl, on3DSSuccessAction: on3DSSuccessAction, jwtToken: jwtToken, md: md, callbackUrl: callback, isLoading: $isLoading).ignoresSafeArea().frame(maxWidth: .infinity)
            if (isLoading){
                VStack{
                    VStack{
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color("Button Primary", bundle: .module)))
                              .scaleEffect(2.0, anchor: .center)
                        Text("Please wait").font(.custom(FontsManager.fontRegular, size: 14)).offset(y: 24)
                    }.offset(y: -80).padding(.top, 220)
                    Spacer()
                }.foregroundStyle(Color("Text Primary", bundle: .module))
            }
        }
    }
    
}

#Preview {
    Card3DSView(acsUrl: .constant("https://knightbenax.dev"), jwtToken: .constant(""), md: .constant(""), termUrl: .constant(""))
}

struct WebView: UIViewRepresentable {
 
    let webView: WKWebView
    var link : String
    var on3DSSuccessAction : () -> () = {}
    var jwtToken : String
    var md : String
    var callbackUrl : String
    var isLoading: Binding<Bool>
    
    init(link: String, on3DSSuccessAction : @escaping () -> (), jwtToken: String, md: String, callbackUrl : String, isLoading : Binding<Bool>) {
        webView = WKWebView(frame: .zero)
        self.link = link
        self.on3DSSuccessAction = on3DSSuccessAction
        self.jwtToken = jwtToken
        self.md = md
        self.callbackUrl = callbackUrl
        self.isLoading = isLoading
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        var urlRequest = URLRequest(url: URL(string: link)!)
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = "JWT=\(jwtToken)&MD=\(md)".data(using: .utf8)
        urlRequest.httpMethod = "POST"
        webView.load(urlRequest)
    }
    
    func makeCoordinator() -> WebViewCoordinator {
            WebViewCoordinator(self)
        }
        
        class WebViewCoordinator: NSObject, WKNavigationDelegate {
            var parent: WebView
            
            init(_ parent: WebView) {
                self.parent = parent
            }
            
            func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
                webView.evaluateJavaScript("(function toggleViewport(){let viewport = document.querySelector('meta[name=viewport]');if (!viewport){viewport=document.createElement('meta');viewport.name = 'viewport';document.getElementsByTagName('head')[0].appendChild(viewport);}viewport.setAttribute('content','width=device-width, initial-scale=1.0, user-scalable=yes');})();")
                webView.evaluateJavaScript("javascript:document.body.style.margin='8%';void 0")
                webView.evaluateJavaScript("(function(){ document.addEventListener('DOMContentLoaded', function() { var iframe = document.getElementsByTagName('iframe')[0]; var innerFrame = iframe.contentWindow.document; var element = innerFrame.getElementById('ExitLink');element.style.display = 'none';});})();")
                parent.isLoading.wrappedValue = false
            }
            
            func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
                if let urlStr = navigationAction.request.url?.absoluteString, urlStr.contains(parent.callbackUrl) {
                    parent.on3DSSuccessAction()
                }
                decisionHandler(.allow)
            }
            
        }
}



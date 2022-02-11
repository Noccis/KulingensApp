//
//  VideoView.swift
//  KulingensApp
//
//  Created by Toni Löf on 2022-01-21.
//

import SwiftUI
import WebKit

struct VideoView: UIViewRepresentable {
    
    let videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
       // guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else {return}
        if let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)"){
            uiView.scrollView.isScrollEnabled = false
            uiView.load(URLRequest(url: youtubeURL))
        }else{
            let youtubeURL = URL(string: "https://www.youtube.com/embed/")
            uiView.scrollView.isScrollEnabled = false
            uiView.load(URLRequest(url: youtubeURL!))
        }
//        uiView.scrollView.isScrollEnabled = false
//        uiView.load(URLRequest(url: youtubeURL))
    }
    
}

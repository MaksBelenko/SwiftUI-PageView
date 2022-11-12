//
//  PageView.swift
//  SwiftUI-PageView
//
//  Created by Maksim on 12/11/2022.
//

import SwiftUI
import UIKit

struct PageView<Content: View>: UIViewRepresentable {
    
    @Binding private var offset: CGFloat
    private var content: Content
    
    init(offset: Binding<CGFloat>, @ViewBuilder content: @escaping () -> Content) {
        self._offset = offset
        self.content = content()
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        
        let hostController = UIHostingController(rootView: content)
        hostController.view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            hostController.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostController.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostController.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostController.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            // No need for heightConstraint for vertical paging
            hostController.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ]
        
        scrollView.addSubview(hostController.view)
        scrollView.addConstraints(constraints)
        
        // Enable paging
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.delegate = context.coordinator
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        
        var parent: PageView
        
        init(_ parent: PageView) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offset = scrollView.contentOffset.x
            parent.offset = offset
        }
    }
    
    private func scrollToPage(page: Int, scrollView: UIScrollView) {
        DispatchQueue.main.async {
            var frame = scrollView.frame;
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0
            scrollView.scrollRectToVisible(frame, animated: true)
        }
    }
}

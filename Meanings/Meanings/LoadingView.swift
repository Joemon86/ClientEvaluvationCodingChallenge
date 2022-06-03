//
//  LoadingView.swift
//  Meanings
//
//  Created by 1964058 on 03/06/22.
//

import Foundation
import UIKit

fileprivate struct Constants {
       fileprivate static let loadingViewTag = 1234
   }

protocol Loadable {
    func showLoadingView()
    func hideLoadingView()
}

extension Loadable where Self : UIViewController {
    
        func showLoadingView() {
            let loadingView = LoadingView()
            view.addSubview(loadingView)
            
            loadingView.translatesAutoresizingMaskIntoConstraints = false
            loadingView.widthAnchor.constraint(equalToConstant: 100).isActive = true
            loadingView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            loadingView.animate()
            
            loadingView.tag = Constants.loadingViewTag
        }
        
        func hideLoadingView() {
            view.subviews.forEach { subview in
                if subview.tag == Constants.loadingViewTag {
                    subview.removeFromSuperview()
                }
            }
        }
}

final class LoadingView: UIView {
    private let activityIndicatorView = UIActivityIndicatorView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor.black.withAlphaComponent(0.7)
        layer.cornerRadius = 5
        
        activityIndicatorView.style = .large
        activityIndicatorView.color = .white
        
        if activityIndicatorView.superview == nil {
            addSubview(activityIndicatorView)
            
            activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            activityIndicatorView.startAnimating()
        }
    }
    
    public func animate() {
        activityIndicatorView.startAnimating()
    }
}

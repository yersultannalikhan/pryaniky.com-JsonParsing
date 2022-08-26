//
//  Anchor+Extension.swift
//  Tasky
//
//  Created by Yersultan Nalikhan on 16.08.2022.
//

import UIKit

extension UIApplication {
    var keyWindowInConnectedScenes: UIWindow? {
        return windows.first(where: { $0.isKeyWindow })
    }
}

extension UIView {
    
    var safeAreaBottom: CGFloat {
           if #available(iOS 11, *) {
              if let window = UIApplication.shared.keyWindowInConnectedScenes {
                  return window.safeAreaInsets.bottom
              }
           }
           return 0
      }

      var safeAreaTop: CGFloat {
           if #available(iOS 11, *) {
              if let window = UIApplication.shared.keyWindowInConnectedScenes {
                  return window.safeAreaInsets.top
              }
           }
           return 0
      }
    
    func anchor(top: NSLayoutYAxisAnchor?,
                   leading:NSLayoutXAxisAnchor?,
                   bottom: NSLayoutYAxisAnchor?,
                   trailing: NSLayoutXAxisAnchor?,
                   padding: UIEdgeInsets = .zero,
                   size: CGSize = .zero) {
           
           translatesAutoresizingMaskIntoConstraints = false
           
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
           
           if size.width != 0 {
               widthAnchor.constraint(equalToConstant: size.width).isActive = true
           }
           
           if size.height != 0 {
               heightAnchor.constraint(equalToConstant: size.height).isActive = true
           }
       }
    
    func anchorCenterX(centerX: NSLayoutXAxisAnchor?) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
    }
    
    func anchorCenterY(centerY: NSLayoutYAxisAnchor?) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
}

//
//  Extensions.swift
//  Payback_Project
//
//  Created on 10/06/2021.
//

import Foundation
import UIKit
import AVKit

extension AVAsset {

    func generateThumbnail(completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let imageGenerator = AVAssetImageGenerator(asset: self)
            let time = CMTime(seconds: 0.0, preferredTimescale: 600)
            let times = [NSValue(time: time)]
            imageGenerator.generateCGImagesAsynchronously(forTimes: times, completionHandler: { _, image, _, _, _ in
                if let image = image {
                    completion(UIImage(cgImage: image))
                } else {
                    completion(nil)
                }
            })
        }
    }
}

extension UIView {
    func addAnchors(top: UIView, leading: UIView, trailing: UIView, bottom: UIView) {
        NSLayoutConstraint.activate([self.topAnchor.constraint(equalTo: top.topAnchor),
                                     self.leadingAnchor.constraint(equalTo: leading.leadingAnchor),
                                     self.trailingAnchor.constraint(equalTo: trailing.trailingAnchor),
                                     self.bottomAnchor.constraint(equalTo: bottom.bottomAnchor)])
        
    }
    func addAnchors(top: UIView, leading: UIView, trailing: UIView) {
        NSLayoutConstraint.activate([self.topAnchor.constraint(equalTo: top.topAnchor),
                                     self.leadingAnchor.constraint(equalTo: leading.leadingAnchor),
                                     self.trailingAnchor.constraint(equalTo: trailing.trailingAnchor)])
        
    }
    
    func addGradientWithAppColor() {
        let layer = CAGradientLayer()
        layer.frame = self.frame
        layer.colors = [AppColors.tileColorBlue.cgColor, UIColor.white.cgColor,AppColors.tileColorBlue.cgColor]
        self.layer.insertSublayer(layer, at: 0)

    }
}

import UIKit

extension UIStackView {
    
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}

extension Date {
    func isOneDayAgo() -> Bool {
        let calendar = NSCalendar.current


        let components = calendar.dateComponents([.day], from: self, to: Date())

        if let days = components.day {
            print("returning if one day has passed")
            return days>=1
        }
        print("Couldn't find days")
        return false
    }
}

extension Notification.Name {
    static let feedFetched = Notification.Name("feed_fetched")
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

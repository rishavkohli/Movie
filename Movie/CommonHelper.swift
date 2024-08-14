//
//  CommonHelper.swift
//  Movie
//
//  Created by Rishav Kohli on 14/08/24.
//

import Foundation
import UIKit


extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            addSubview(subview)
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        if let image = ImageCacheManager.sharedInstance.getImage(imageUrl: url) {
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        } else {
            Task {
                if let data = await CommonHelper.downloadData(url: url) {
                    if let image = UIImage(data: data) {
                        ImageCacheManager.sharedInstance.storeImage(imageUrl: url, image: image)
                        DispatchQueue.main.async { [weak self] in
                            self?.image = image
                        }
                    }
                }
            }
        }
        
    }


}

class CommonHelper {
    static func makeViewController<T: UIViewController>(
        identifier: String
    ) -> T {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard
            let vc = storyboard.instantiateViewController(
                withIdentifier: identifier
            ) as? T
        else {
            fatalError()
        }

        return vc
    }

    static func downloadData(url: URL) async -> Data? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch let error {
            print(error)
        }
        return nil
    }
}

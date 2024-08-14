//
//  ImageCacheManager.swift
//  Movie
//
//  Created by Rishav Kohli on 14/08/24.
//

import Foundation
import UIKit

final class ImageCacheManager {
    static let sharedInstance = ImageCacheManager()
    private var imageCache = [URL : UIImage]()

    //to store image against url
    func storeImage(imageUrl: URL, image: UIImage) {
        self.imageCache[imageUrl] = image
    }

    // to retrieve image against url
    func getImage(imageUrl: URL) -> UIImage? {
        return self.imageCache[imageUrl]
    }
}

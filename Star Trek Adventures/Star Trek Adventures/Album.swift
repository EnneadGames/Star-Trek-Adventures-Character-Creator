//
//  Album.swift
//  Star Trek Adventures
//
//  Created by Mars Geldard on 10/11/18.
//  Copyright © 2018 Mars Geldard. All rights reserved.
//

import Photos

typealias CompletionHandler = ((Bool, Error?) -> Void)?

final class PhotosAlbum {
    
    static let shared = PhotosAlbum()
    
    private static let albumName = "Star Trek Characters"
    private var assetCollection: PHAssetCollection!
    
    private init() {}
    
    private func verifyAssetCollection(completionHandler: CompletionHandler = nil) {
        if let assetCollection = fetchAssetCollectionForAlbum() {
            self.assetCollection = assetCollection
            completionHandler?(true, nil)
            return
        }
        
        PHPhotoLibrary.shared().performChanges({
            PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: PhotosAlbum.albumName)
        }) { success, error in
            if success {
                self.assetCollection = self.fetchAssetCollectionForAlbum()
            }
            
            completionHandler?(success, error)
        }
    }
    
    private func fetchAssetCollectionForAlbum() -> PHAssetCollection? {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", PhotosAlbum.albumName)
        let collection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        
        if let firstObject = collection.firstObject {
            return firstObject
        }
        
        return nil
    }
    
    func saveImage(image: UIImage, completionHandler: CompletionHandler = nil) {
        if PHPhotoLibrary.authorizationStatus() != .authorized {
            PHPhotoLibrary.requestAuthorization() { status in
                if status == .authorized {
                    self.storeToAlbum(image, completionHandler: completionHandler)
                }
            }
        } else {
            storeToAlbum(image, completionHandler: completionHandler)
        }
    }
    
    func storeToAlbum(_ image: UIImage, completionHandler: CompletionHandler = nil) {
        verifyAssetCollection(completionHandler: { success, error in
            if let error = error {
                completionHandler?(false, error)
                return
            }
            
            if self.assetCollection != nil {
                PHPhotoLibrary.shared().performChanges({
                    let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
                    let assetPlaceholder = assetChangeRequest.placeholderForCreatedAsset
                    let albumChangeRequest = PHAssetCollectionChangeRequest(for: self.assetCollection)
                    albumChangeRequest?.addAssets([assetPlaceholder] as NSFastEnumeration)
                }, completionHandler: completionHandler)
            }
        })
    }
}

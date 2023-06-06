//
//  PhotosFileManager.swift
//  Snippets
//
//  Created by Bartosz Wojtkowiak on 06/06/2023.
//

import SwiftUI

class PhotosFileManager {
    static let instance = PhotosFileManager()
    let folderName = "downloaded_photos"
    
    private init() { }
    
    private func createFolderIfNeeded() {
        guard let url = getFolderPath() else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Error creating a folder. \(error)")
            }
        }
    }
    
    private func getFolderPath() -> URL? {
        return FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
    }
    
    private func getImagePath(key: String) -> URL? {
        guard let folder = getFolderPath() else {
            return nil
        }
        
        return folder.appendingPathComponent(key + ".jpg")
    }
    
    func add(key: String, value: UIImage) {
        guard
            let data = value.jpegData(compressionQuality: 0.5),
            let url = getImagePath(key: key) else { return }
        
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving to file manager. \(error)")
        }
    }
    
    func get(key: String) -> UIImage? {
        guard
            let url = getImagePath(key: key),
            FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        
        return UIImage(contentsOfFile: url.path)
    }
}


//
//  UIImageLoader.swift
//  Test2
//
//  Created by Hesham on 21/09/2022.
//

import Foundation
import UIKit

class UIImageLoader {
    static let loader = UIImageLoader()
    
    private let imageLoader = ImageLoader()
    private var uuidMap = [UIImageView: UUID]()
    
    private init() {}
    
    func load(_ url: URL, for imageView: UIImageView) {
        let token = imageLoader.loadImage(url) { result in
            defer { self.uuidMap.removeValue(forKey: imageView) }
            do {
                let image = try result.get()
                DispatchQueue.main.async {
                    imageView.image = image
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        if let token = token {
            uuidMap[imageView] = token
        }
    }
    
    func cancel(for imageView: UIImageView) {
        if let uuid = uuidMap[imageView] {
            imageLoader.cancelLoad(uuid)
            uuidMap.removeValue(forKey: imageView)
        }
    }
}

private class ImageLoader {
    private var loadedImages = [URL: UIImage]()
    private var runningRequests = [UUID: URLSessionDataTask]()
    
    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        if let image = loadedImages[url] {
            completion(.success(image))
            return nil
        }
        
        let uuid = UUID()
        let task = getImageDataTask(url: url, uuid: uuid, completion: completion)
        task.resume()
        
        runningRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
    
    
    private func getImageDataTask(url: URL, uuid: UUID, completion: @escaping (Result<UIImage, Error>) -> Void) -> URLSessionDataTask {
        return NetworkService.getDataTask(request: URLRequest(url: url)) { result in
            defer {self.runningRequests.removeValue(forKey: uuid) }
            switch result {
                
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completion(.failure(NetworkError.invalidResponse))
                    return
                }
                self.loadedImages[url] = image
                completion(.success(image))
            case .failure(let error):
                guard let networkError = error as? NetworkError, networkError == .cancelled else {
                    completion(.failure(error))
                    return
                }
            }
        }
    }
}



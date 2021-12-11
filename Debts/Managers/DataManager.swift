//
//  DataManager.swift
//  Debts
//
//  Created by Sergei Volkov on 11.12.2021.
//

import Foundation

struct DataManager {
    
    enum ErrorData: Error {
        case errorCreateContainer
        case errorDecodeData
    }
    
    private static var container: URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }

    static func saveImage(fileName: String, imageData: Data) -> Result<String, Error> {
        guard let documentsDirectory = container else { return .failure(ErrorData.errorCreateContainer) }
        let fileURL = documentsDirectory.appendingPathComponent(fileName)

        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
                return .failure(removeError)
            }

        }

        do {
            try imageData.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
            return .failure(error)
        }
        
        return .success(fileName)
    }
    
    static func loadImage(fileName: String) -> Result<Data, Error> {
        guard let documentsDirectory = container else { return .failure(ErrorData.errorCreateContainer) }
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = try? Data.init(contentsOf: fileURL) else { return .failure(ErrorData.errorDecodeData) }
        return .success(data)
    }
}


extension DataManager.ErrorData: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .errorCreateContainer:
            return NSLocalizedString("Error to create local domain url", comment: "error description")
        case .errorDecodeData:
            return NSLocalizedString("Error to decode data from file", comment: "error description")
        }
    }
}

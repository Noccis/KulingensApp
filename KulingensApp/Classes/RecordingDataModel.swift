//
//  RecordingDataModel.swift
//  KulingensApp
//
//  Created by Toni Löf on 2022-02-01.
//

import Foundation

struct Recording {
    let fileURL: URL
    let createdAt: Date
    
    var filename : String {
        return String(fileURL.absoluteString.suffix(24))
    }
}

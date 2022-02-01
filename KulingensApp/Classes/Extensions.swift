//
//  Extensions.swift
//  KulingensApp
//
//  Created by Toni Löf on 2022-02-01.
//

import Foundation

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}

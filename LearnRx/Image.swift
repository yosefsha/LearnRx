//
//  Image.swift
//  LearnRx
//
//  Created by Yosef Shachnovsky on 02/01/2020.
//  Copyright © 2020 Yosef Shachnovsky. All rights reserved.
//

import Foundation
#if os(iOS)
    import UIKit
    typealias Image = UIImage
#elseif os(macOS)
    import Cocoa
    typealias Image = NSImage
#endif

extension Image {
    func forceLazyImageDecompression() -> Image {
        #if os(iOS)
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        self.draw(at: CGPoint.zero)
        UIGraphicsEndImageContext()
        #endif
        return self
    }
}

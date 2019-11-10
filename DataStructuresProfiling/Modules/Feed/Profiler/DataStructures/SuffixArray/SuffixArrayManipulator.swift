//
//  SuffixArrayManipulator.swift
//  DataStructuresProfiling
//
//  Created by Georgy Khaydenko on 26/10/2019.
//  Copyright © 2019 Exey Panteleev. All rights reserved.
//

import Foundation


protocol SuffixArrayManipulator {
    var numberOfTrippplesToFind: Int { get set }
    func suffixArrayHasObjects() -> Bool
    func setupWithTripplesCount(_ count: Int) -> TimeInterval
    func changeEachSuffix() -> TimeInterval
    func reverseSuffixArray() -> TimeInterval
    func searchFor10Tripples() -> (TimeInterval, Int)
    func searchForTripples() -> (TimeInterval, Int)
}

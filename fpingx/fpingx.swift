//
//  fpingx.swift
//  fpingx
//
//  Created by Jie Zhang on 17/9/17.
//  Copyright © 2017 Jie Zhang. All rights reserved.
//

import Foundation

public struct FpingX {
    let host: String
    let xmt: Int
    let rcv: Int
    var loss: Int {
        return xmt > 0 ? (xmt - rcv) * 100 / xmt : 0
    }

    let avg: Int?
    let min: Int?
    let max: Int?

}

public class fpingx {
    public static func ping(hosts: [String], backoff: Float = 1.5, count: Int = 1, completion: (_ result: [FpingX]) -> Void) {

        let argv:[String?] = ["", "-c\(count)", "-B\(backoff)", "-q"] + hosts + [nil]

        typealias fpingHostPtr = UnsafeMutablePointer<HOST_ENTRY>?

        // Create [UnsafePointer<Int8>]:
        var cargs = argv.map { $0.flatMap { UnsafeMutablePointer<Int8>(strdup($0)) } }
        // Call C function:
        let d = fping(4, &cargs)!
        var node:fpingHostPtr = d.pointee

        var results: [FpingX] = []
        while (node != nil) {
            let h = node!.pointee
            let result = FpingX(host: String(cString: h.host), xmt: Int(h.num_sent), rcv: Int(h.num_recv), avg: h.num_recv > 0 ? Int(h.total_time / h.num_recv / 100) : nil, min: h.num_recv > 0 ? Int(h.min_reply / 100) : nil, max: h.num_recv > 0 ? Int(h.max_reply / 100) : nil)
            results.append(result)

            node = node?.pointee.ev_next
        }
        // Free the duplicated strings:
        for ptr in cargs { free(UnsafeMutablePointer(ptr)) }
        completion(results)
    }
}

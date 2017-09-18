//
//  fpingx.swift
//  fpingx
//
//  Created by Jie Zhang on 17/9/17.
//  Copyright © 2017 Jie Zhang. All rights reserved.
//

import Foundation

/// ping result
public struct FpingxResult {

    public let host: String

    /// number of sent
    public let xmt: Int

    /// number of received
    public let rcv: Int

    /// loss percentage (value from 0-100)
    public var loss: Int {
        return xmt > 0 ? (xmt - rcv) * 100 / xmt : 0
    }

    /// nil if rcv is 0
    public let avg: Int?

    /// nil if rcv is 0
    public let min: Int?

    /// nil if rcv is 0
    public let max: Int?

}

public class fpingx {

    /// Send ping with completion block.
    ///
    /// - Parameters:
    ///   - hosts: hosts
    ///   - backoff: default 1.5
    ///   - count: number of ping send per host
    ///   - completion: results dictionary, the key is host string, the value is FpingxResult struct

    public static func ping(hosts: [String], backoff: Float = 1.5, count: Int = 1, completion: @escaping (_ results: [String: FpingxResult]) -> Void) {

        let argv:[String?] = ["", "-c\(count)", "-B\(backoff)", "-q"] + hosts + [nil]
        var cargs = argv.map { $0.flatMap { UnsafeMutablePointer<Int8>(strdup($0)) } }

        DispatchQueue.global(qos: .background).async {
            let resultsArrarPtr = fping(Int32(argv.count), &cargs)!
            var hostPtr = resultsArrarPtr.pointee

            var results: [String: FpingxResult] = [:]
            while (hostPtr != nil) {
                let h = hostPtr!.pointee
                let host = String(cString: h.host)
                let result = FpingxResult(host: host, xmt: Int(h.num_sent), rcv: Int(h.num_recv), avg: h.num_recv > 0 ? Int(h.total_time / h.num_recv / 100) : nil, min: h.num_recv > 0 ? Int(h.min_reply / 100) : nil, max: h.num_recv > 0 ? Int(h.max_reply / 100) : nil)
                results[host] = result
                let freeNode = hostPtr
                hostPtr = hostPtr?.pointee.ev_next
                free(UnsafeMutableRawPointer(freeNode))
            }

            free(UnsafeMutablePointer(resultsArrarPtr))
            completion(results)
        }

        for ptr in cargs { free(UnsafeMutablePointer(ptr)) }
    }
}

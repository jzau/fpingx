# fpingx

![Language](https://img.shields.io/badge/language-Swift%205-green.svg)
[![CocoaPods](https://img.shields.io/cocoapods/v/fpingx.svg)]()
[![Carthage Compatible](https://img.shields.io/badge/Carthage-✓-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods](https://img.shields.io/cocoapods/p/fpingx.svg)]()


A wrapper of [fping](https://github.com/schweikert/fping) which is a high performance ping tool. More information about fping is available [here](https://fping.org/).

## Installation

### CocoaPods

add the following line to your Podfile:

``` ruby
pod "fpingx"
```

### Carthage

``` 
github "jzau/fpingx"
```


## Usage

``` swift
import fpingx

fpingx.ping(hosts: ["google.com", "baidu.com", "apple.com", "abc.c"], progress: { (progress) in
    print(progress)
}) { (result) in
    print(result)
}
```

The `progress` is a float number between 0-1.

The `result` is a dictionary which key is host string, value is `FpingxResult`.

Notice that FpingxResult is a struct defined as:

``` swift
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

```

## Author

[jzau](https://github.com/jzau) (Twitter: [@Jie](https://twitter.com/jzzzau))

## Credits of fping

Current maintainer: David Schweikert \<david@schweikert.ch\>

The original author: Roland Schemers (schemers@stanford.edu) Previous maintainer: RL "Bob" Morgan (morgan@stanford.edu) Initial IPv6 Support: Jeroen Massar (jeroen@unfix.org / jeroen@ipng.nl) Other contributors: see ChangeLog
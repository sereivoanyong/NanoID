//
//  Alphabet.swift
//
//  Created by Sereivoan Yong on 1/12/24.
//

extension Alphabet {

  public static let numerics = Self("0123456789")
  public static let lowercaseLetters = Self("abcdefghijklmnopqrstuvwxyz")
  public static let uppercaseLetters = Self("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
  public static let alphanumerics = Self(numerics.string, lowercaseLetters.string, uppercaseLetters.string)
  public static let urlAllowed = Self(alphanumerics.string, "_-")
}

public struct Alphabet {

  let string: String

  @usableFromInline
  let characters: [Character]

  init(_ string: String...) {
    let flatten = string.joined()
    self.string = flatten
    self.characters = [Character](flatten)
  }
}

extension Alphabet: RandomAccessCollection {

  public typealias Element = Character

  public typealias Index = [Character].Index

  public typealias SubSequence = [Character].SubSequence

  public typealias Indices = [Character].Indices

  public typealias Iterator = [Character].Iterator

  @inlinable
  public var startIndex: Index {
    return characters.startIndex
  }

  @inlinable
  public var endIndex: Index {
    return characters.endIndex
  }

  @inlinable
  public func index(after i: Index) -> Index {
    return characters.index(after: i)
  }

  @inlinable
  public subscript(position: Index) -> Character {
    return characters[position]
  }

  @inlinable
  public subscript(bounds: Range<Index>) -> SubSequence {
    return characters[bounds]
  }

  @inlinable
  public func makeIterator() -> Iterator {
    return characters.makeIterator()
  }
}

extension Alphabet: CustomStringConvertible {

  public var description: String {
    return string
  }
}

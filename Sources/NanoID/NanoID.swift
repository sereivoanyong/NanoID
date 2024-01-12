//
//  NanoID.swift
//
//  Created by Sereivoan Yong on 1/12/24.
//

public struct NanoID {

  let alphabet: Alphabet
  let count: Int
  let generator: RandomGenerator

  /// Initialize a new ID instance
  ///
  /// - Parameters:
  ///   - alphabet: the default alphabet to use
  ///   - count: the default count for new ids
  ///   - randomizer: the default randomizer to use
  public init(alphabet: Alphabet = .urlAllowed, count: Int = 21, generator: RandomGenerator = .secure()) {
    self.alphabet = alphabet
    self.count = count
    self.generator = generator
  }

  public func generate(alphabet: Alphabet? = nil, count: Int? = nil, generator: RandomGenerator? = nil) -> String {
    return String((generator ?? self.generator).characters(count: (count ?? self.count), in: (alphabet ?? self.alphabet)))
  }
}

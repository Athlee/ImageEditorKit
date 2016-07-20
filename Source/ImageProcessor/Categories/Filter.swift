//
//  Filter.swift
//  Athlee-ImageEditorKit
//
//  Created by mac on 18/07/16.
//  Copyright © 2016 Athlee. All rights reserved.
//

import CoreImage

enum FilterError: ErrorType {
  case FilterDoesNotExist(String)
}

protocol Filter: Scanable, Equatable, Hashable {
  var name: String { get }
}

extension Filter {
  var ignoredProperties: [String] {
    return ["name"]
  }
}

extension Filter {
  var hashValue: Int {
    return (try? filter())?.hashValue ?? Int.max
  }
}

extension Filter {
  func filter() throws -> CIFilter {
    if let filter = CIFilter(name: name) {
      return filter
    } else {
      throw FilterError.FilterDoesNotExist(name)
    }
  }
}

func ==<T : Filter>(lhs: T, rhs: T) -> Bool {
  guard let lhsFilter = try? lhs.filter() else { return false }
  guard let rhsFilter = try? rhs.filter() else { return false }
  
  return lhsFilter == rhsFilter
}
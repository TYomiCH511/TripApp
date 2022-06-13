//
//  Binding.swift
//  TripApp
//
//  Created by Artem on 13.06.22.
//

import Foundation


class Bindable<T> { //generic
  typealias Listener = (T) -> Void

  var value: T {
    didSet {
      listener?(value)
    }
  }
  private var listener: Listener?

  init(_ value: T) {
    self.value = value
  }

  func bind(_ listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
    
}

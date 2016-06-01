//
//  MyTableViewDelegateProxy.swift
//  RxDelegate
//
//  Created by Jian Zhang on 5/14/16.
//  Copyright © 2016 Jian Zhang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

enum HTTPServiceError: ErrorType {
  case InvalidURL
  case NoData
}

protocol HTTPServiceProtocol {
  func get(path: String, callback: (error: HTTPServiceError?, value: AnyObject?) -> ())
}

struct HTTPServiceGET: HTTPServiceProtocol {
  private let path: String
  
  init(path: String) {
    self.path = path
  }
  
  func get(path: String, callback: (error: HTTPServiceError?, value: AnyObject?) -> ()) {
    guard let url = NSURL(string: path) else {
      callback(error: HTTPServiceError.InvalidURL, value: nil)
      return
    }
    
    Alamofire.request(.GET, url).responseJSON { response -> Void in
      guard let value = response.result.value else {
        callback(error: HTTPServiceError.NoData, value: nil)
        return
      }
      callback(error: nil, value: value)
    }
  }
}

extension HTTPServiceGET: ObservableType {
  typealias E = AnyObject
  func asObservable() -> RxSwift.Observable<E> {
    return Observable.create { observer -> Disposable in
      self.get(self.path, callback: { error, value -> () in
        if let error = error {
          observer.onError(error)
        }
        
        if let value = value {
          observer.onNext(value)
          observer.onCompleted()
        }
        
      })
      return NopDisposable.instance
    }
  }
  
  func subscribe<O : ObserverType where O.E == E>(observer: O) -> Disposable {
    return asObservable().subscribe(observer)
  }
}

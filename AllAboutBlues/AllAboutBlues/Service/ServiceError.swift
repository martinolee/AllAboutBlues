//
//  ServiceError.swift
//  AllAboutBlues
//
//  Created by Soohan Lee on 2020/03/02.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

enum ServiceError: Error {
  case noData
  case clientError
  case invalidStatusCode
  case invalidFormat
}

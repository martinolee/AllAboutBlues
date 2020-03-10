//
//  UITableViewCellExtension.swift
//  AllAboutBlues
//
//  Created by Soohan Lee on 2020/03/03.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

protocol Identifiable {
  static var identifier: String { get }
}

extension Identifiable {
  static var identifier: String { String(describing: self) }
}

extension UITableViewCell: Identifiable { }

extension UITableViewHeaderFooterView: Identifiable { }

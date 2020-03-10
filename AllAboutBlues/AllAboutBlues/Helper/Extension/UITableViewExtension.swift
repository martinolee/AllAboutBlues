//
//  UITableViewExtension.swift
//  AllAboutBlues
//
//  Created by Soohan Lee on 2020/03/03.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

extension UITableView {
  func register<Cell>(
    cell: Cell.Type,
    forCellReuseIdentifier reuseIdentifier: String = Cell.identifier
  ) where Cell: UITableViewCell {
    register(cell, forCellReuseIdentifier: reuseIdentifier)
  }
  
  func dequeue<Cell>(_ reusableCell: Cell.Type) -> Cell where Cell: UITableViewCell {
    if let cell = dequeueReusableCell(withIdentifier: reusableCell.identifier) as? Cell {
      return cell
    } else {
      fatalError("Identifier required")
    }
  }
  
  func register<Header>(
    header: Header.Type,
    forHeaderFooterViewReuseIdentifier reuseIdentifier: String = Header.identifier
  ) where Header: UITableViewHeaderFooterView {
    register(header, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
  }
  
  func dequeue<Header>(_ reusableCell: Header.Type) -> Header where Header: UITableViewHeaderFooterView {
    if let header = dequeueReusableHeaderFooterView(withIdentifier: reusableCell.identifier) as? Header {
      return header
    } else {
      fatalError("Identifier required")
    }
  }
}

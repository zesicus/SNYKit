//
//  UITableView.swift
//  Alamofire
//
//  Created by Sunny on 2018/9/16.
//

import UIKit

extension UITableView {
    
    //滚动到顶部
    public func scrollToTop(animated: Bool) {
        self.setContentOffset(CGPoint(x: 0, y: 0), animated: animated)
    }
    
    //滚动到底部
    public func scrollToBot(animated: Bool) {
        let s = self.numberOfSections
        if (s < 1) {return}
        let r = self.numberOfRows(inSection: s - 1)
        if (r < 1) {return}
        let ip = IndexPath(row: r - 1, section: s - 1)
        self.scrollToRow(at: ip, at: .bottom, animated: animated)
    }
    
    //是否滑动到了底部
    public func isScrollToBot() -> Bool {
        let height = self.frame.size.height
        let contentOffsetY = self.contentOffset.y
        let bottomOffset = self.contentSize.height - contentOffsetY
        if bottomOffset <= height {
            return true
        } else {
            return false
        }
    }
    
}

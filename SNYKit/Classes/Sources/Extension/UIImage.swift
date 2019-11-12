//
//  UIImage.swift
//  NU
//
//  Created by Sunny on 2018/7/16.
//  Copyright © 2018 Nuggets. All rights reserved.
//

import UIKit

public extension UIImage {
    //压缩图片
    func compressImage(toByte maxLength: Int) -> UIImage {
        var compression: CGFloat = 1
        guard var data = self.jpegData(compressionQuality: compression),
            data.count > maxLength else { return self }
        
        // Compress by size
        var max: CGFloat = 1
        var min: CGFloat = 0
        for _ in 0..<6 {
            compression = (max + min) / 2
            data = self.jpegData(compressionQuality: compression)!
            if CGFloat(data.count) < CGFloat(maxLength) * 0.9 {
                min = compression
            } else if data.count > maxLength {
                max = compression
            } else {
                break
            }
        }
        var resultImage: UIImage = UIImage(data: data)!
        if data.count < maxLength { return resultImage }
        
        // Compress by size
        var lastDataLength: Int = 0
        while data.count > maxLength, data.count != lastDataLength {
            lastDataLength = data.count
            let ratio: CGFloat = CGFloat(maxLength) / CGFloat(data.count)
            let size: CGSize = CGSize(width: Int(resultImage.size.width * sqrt(ratio)),
                                      height: Int(resultImage.size.height * sqrt(ratio)))
            UIGraphicsBeginImageContext(size)
            resultImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            resultImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            data = resultImage.jpegData(compressionQuality: compression)!
        }
        return resultImage
    }
    
    //修复拍照照片旋转90度问题
    func fixOrientation() -> UIImage {
        if self.imageOrientation == .up {
            return self
        }
        
        var transform = CGAffineTransform.identity
        
        switch self.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: .pi)
            break
            
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: .pi / 2)
            break
            
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height)
            transform = transform.rotated(by: -.pi / 2)
            break
            
        default:
            break
        }
        
        switch self.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            break
            
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0);
            transform = transform.scaledBy(x: -1, y: 1)
            break
            
        default:
            break
        }
        
        let ctx = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0, space: self.cgImage!.colorSpace!, bitmapInfo: self.cgImage!.bitmapInfo.rawValue)
        ctx?.concatenate(transform)
        
        switch self.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx?.draw(self.cgImage!, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.height), height: CGFloat(size.width)))
            break
            
        default:
            ctx?.draw(self.cgImage!, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.width), height: CGFloat(size.height)))
            break
        }
        
        let cgimg: CGImage = (ctx?.makeImage())!
        let img = UIImage(cgImage: cgimg)
        
        return img
    }
    
    //改变图片颜色(经测试可能会产生很细的图片边框)
    
    func withColor(_ color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, _: false, _: scale)
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context?.clip(to: rect, mask: cgImage!)
        color.setFill()
        context?.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    //改变图片尺寸
    
    func withSize(_ size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(origin: .zero, size: size))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? self
    }
    
    // 添加水印
    // fontDirection 1 下方；2 左右方
    func addWaterMark(at corner: UIRectCorner, img: UIImage?, text: String? = nil, imgWidth: CGFloat = 35, fontSize: CGFloat = 15, edge: CGFloat = 15, fontDirection: Int = 2, fontAlpha: CGFloat = 0.7) -> UIImage? {
        var ratio: CGFloat = 1.0
        if self.size.width / self.size.height > 375 / 500 {
            ratio = self.size.width / SNY.screen.width
        } else {
            ratio = self.size.height / (SNY.screen.width * 500 / 375)
        }
        UIGraphicsBeginImageContext(self.size)
        self.draw(at: CGPoint.zero)
        switch corner {
        case .topLeft:
            if img != nil {
                let theHeight = img!.size.height * (imgWidth / img!.size.width) * ratio
                img!.draw(in: CGRect(x: edge * ratio, y: edge * ratio, width: imgWidth * ratio, height: theHeight))
            }
            if text != nil {
                if fontDirection == 1 {
                    if img != nil {
                        let theHeight = img!.size.height * (imgWidth / img!.size.width) * ratio
                        text!.draw(in: CGRect(x: edge * ratio, y: edge * ratio + theHeight + 8 * ratio, width: text!.getWidth(size: fontSize * ratio), height: fontSize * ratio), withAttributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(fontAlpha), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize * ratio)])
                    } else {
                        text!.draw(at: CGPoint(x: edge * ratio, y: edge * ratio), withAttributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(fontAlpha), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize * ratio)])
                    }
                } else if fontDirection == 2 {
                    if img != nil {
                        text!.draw(in: CGRect(x: imgWidth * ratio + 8 * ratio, y: edge * ratio, width: text!.getWidth(size: fontSize * ratio), height: fontSize * ratio), withAttributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(fontAlpha), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize * ratio)])
                    } else {
                        text!.draw(at: CGPoint(x: edge * ratio, y: edge * ratio), withAttributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(fontAlpha), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize * ratio)])
                    }
                }
            }
            break
        case .topRight:
            if img != nil {
                let theHeight = img!.size.height * (imgWidth / img!.size.width) * ratio
                img!.draw(in: CGRect(x: self.size.width - edge * ratio - imgWidth * ratio, y: edge * ratio, width: imgWidth * ratio, height: theHeight))
            }
            if text != nil {
                if fontDirection == 1 {
                    if img != nil {
                        let theHeight = img!.size.height * (imgWidth / img!.size.width) * ratio
                        text!.draw(at: CGPoint(x: self.size.width - edge * ratio - text!.getWidth(size: fontSize * ratio), y: edge * ratio + theHeight + 8 * ratio), withAttributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(fontAlpha), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize * ratio)])
                    } else {
                        text!.draw(at: CGPoint(x: self.size.width - edge * ratio - text!.getWidth(size: fontSize * ratio), y: edge * ratio), withAttributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(fontAlpha), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize * ratio)])
                    }
                } else if fontDirection == 2 {
                    if img != nil {
                        text!.draw(at: CGPoint(x: self.size.width - edge * ratio - imgWidth * ratio - 8 * ratio - text!.getWidth(size: fontSize * ratio), y: edge * ratio), withAttributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(fontAlpha), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize * ratio)])
                    } else {
                        text!.draw(at: CGPoint(x: self.size.width - edge * ratio - text!.getWidth(size: fontSize * ratio), y: edge * ratio), withAttributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(fontAlpha), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize * ratio)])
                    }
                }
            }
            break
        case .bottomLeft:
            if text != nil {
                if fontDirection == 1 {
                    text!.draw(at: CGPoint(x: edge * ratio, y: self.size.height - edge * ratio - fontSize * ratio), withAttributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(fontAlpha), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize * ratio)])
                } else if fontDirection == 2 {
                    text!.draw(at: CGPoint(x: edge * ratio + imgWidth * ratio + 8 * ratio, y: self.size.height - edge * ratio - fontSize * ratio), withAttributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(fontAlpha), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize * ratio)])
                }
                
            }
            if img != nil {
                let theHeight = img!.size.height * (imgWidth / img!.size.width) * ratio
                if text != nil {
                    if fontDirection == 1 {
                        img!.draw(in: CGRect(x: edge * ratio, y: self.size.height - edge * ratio - fontSize * ratio - 8 * ratio - theHeight, width: imgWidth * ratio, height: theHeight))
                    } else if fontDirection == 2 {
                        img!.draw(in: CGRect(x: edge * ratio, y: self.size.height - edge * ratio - theHeight, width: imgWidth * ratio, height: theHeight))
                    }
                } else {
                    img!.draw(in: CGRect(x: edge * ratio, y: self.size.height - edge * ratio - theHeight, width: imgWidth * ratio, height: theHeight))
                }
            }
            break
        case .bottomRight:
            if text != nil {
                if fontDirection == 1 {
                    text!.draw(at: CGPoint(x: self.size.width - edge * ratio - text!.getWidth(size: fontSize * ratio), y: self.size.height - edge * ratio - fontSize * ratio), withAttributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(fontAlpha), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize * ratio)])
                } else if fontDirection == 2 {
                    text!.draw(at: CGPoint(x: self.size.width - edge * ratio - imgWidth * ratio - 8 * ratio - text!.getWidth(size: fontSize * ratio), y: self.size.height - edge * ratio - fontSize * ratio), withAttributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(fontAlpha), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize * ratio)])
                }
            }
            if img != nil {
                let theHeight = img!.size.height * (imgWidth / img!.size.width) * ratio
                if text != nil {
                    if fontDirection == 1 {
                        img!.draw(in: CGRect(x: self.size.width - edge * ratio - imgWidth * ratio, y: self.size.height - edge * ratio - fontSize * ratio - 8 * ratio - theHeight, width: imgWidth * ratio, height: theHeight))
                    } else if fontDirection == 2 {
                        img!.draw(in: CGRect(x: self.size.width - edge * ratio - imgWidth * ratio, y: self.size.height - edge * ratio - fontSize * ratio - 8 * ratio - theHeight, width: imgWidth * ratio, height: theHeight))
                    }
                } else {
                    img!.draw(in: CGRect(x: self.size.width - edge * ratio - imgWidth * ratio, y: self.size.height - edge * ratio - fontSize * ratio, width: imgWidth * ratio, height: theHeight))
                }
            }
            break
        default:
            break
        }
        let newImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImg
    }
    
}

//
//  PlaygroundView.swift
//  Mice
//
//  Created by Vukašin Prvulović on 12/7/19.
//  Copyright © 2019 Vukašin Prvulović. All rights reserved.
//

import Foundation
import UIKit
import MiceDomain

class PlaygroundView: UIView {
    
    var fields: [(String,UIImageView)] = Array()
    
    let fieldsTags: [String]?
    
    init(frame: CGRect, fields: [String]) {
        fieldsTags = fields
        super.init(frame: frame)
        makePlayground()
    }
    
    override init(frame: CGRect) {
        fieldsTags = nil
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        makePlayground()
    }
    
    func isField(location: CGPoint) -> String? {
        let relativeLocation = CGPoint(x: location.x - frame.minX, y: location.y - frame.minY)
        for field in fields {
            if field.1.frame.contains(relativeLocation) {
                return field.0
            }
        }
        return nil
    }
    
    func drawGameState(fields: [String: Field]) {
        for field in self.fields {
            let gameField = fields[field.0]
            switch gameField?.fieldState {
            case .playerOne:
                field.1.image = #imageLiteral(resourceName: "ic_player_one")
            case .playerTwo:
                field.1.image = #imageLiteral(resourceName: "ic_player_two")
            default:
                field.1.image = nil
            }
        }
    }
    
    func removePlayerFromField(_ tag: String){
        for field in self.fields {
            if field.0 == tag {
                field.1.image = nil
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fieldsTags = nil
        super.init(coder: coder)
        self.backgroundColor = UIColor.clear
        makePlayground()
    }
    
    private func makePlayground() {
        
        var constraints: [NSLayoutConstraint] = Array()
        
        for i in 0..<24{
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(imageView)
            let ratioConstaint = imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1.0/1.0)
            let sizeConstaint = imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1)
            fields.append((fieldsTags![i],imageView))
            let centerXMultiplier: CGFloat
            let centerYMultiplier: CGFloat
            
            switch i {
            case 0:
                centerXMultiplier = CGFloat(0.2)
                centerYMultiplier = CGFloat(0.2)
            case 1:
                centerXMultiplier = CGFloat(1)
                centerYMultiplier = CGFloat(0.2)
            case 2:
                centerXMultiplier = CGFloat(1.8)
                centerYMultiplier = CGFloat(0.2)
            case 3:
                centerXMultiplier = CGFloat(0.4)
                centerYMultiplier = CGFloat(0.4)
            case 4:
                centerXMultiplier = CGFloat(1)
                centerYMultiplier = CGFloat(0.4)
            case 5:
                centerXMultiplier = CGFloat(1.6)
                centerYMultiplier = CGFloat(0.4)
            case 6:
                centerXMultiplier = CGFloat(0.6)
                centerYMultiplier = CGFloat(0.6)
            case 7:
                centerXMultiplier = CGFloat(1)
                centerYMultiplier = CGFloat(0.6)
            case 8:
                centerXMultiplier = CGFloat(1.4)
                centerYMultiplier = CGFloat(0.6)
            case 9:
                centerXMultiplier = CGFloat(0.2)
                centerYMultiplier = CGFloat(1)
            case 10:
                centerXMultiplier = CGFloat(0.4)
                centerYMultiplier = CGFloat(1)
            case 11:
                centerXMultiplier = CGFloat(0.6)
                centerYMultiplier = CGFloat(1)
            case 12:
                centerXMultiplier = CGFloat(1.4)
                centerYMultiplier = CGFloat(1)
            case 13:
                centerXMultiplier = CGFloat(1.6)
                centerYMultiplier = CGFloat(1)
            case 14:
                centerXMultiplier = CGFloat(1.8)
                centerYMultiplier = CGFloat(1)
            case 15:
                centerXMultiplier = CGFloat(0.6)
                centerYMultiplier = CGFloat(1.4)
            case 16:
                centerXMultiplier = CGFloat(1)
                centerYMultiplier = CGFloat(1.4)
            case 17:
                centerXMultiplier = CGFloat(1.4)
                centerYMultiplier = CGFloat(1.4)
            case 18:
                centerXMultiplier = CGFloat(0.4)
                centerYMultiplier = CGFloat(1.6)
            case 19:
                centerXMultiplier = CGFloat(1)
                centerYMultiplier = CGFloat(1.6)
            case 20:
                centerXMultiplier = CGFloat(1.6)
                centerYMultiplier = CGFloat(1.6)
            case 21:
                centerXMultiplier = CGFloat(0.2)
                centerYMultiplier = CGFloat(1.8)
            case 22:
                centerXMultiplier = CGFloat(1)
                centerYMultiplier = CGFloat(1.8)
            case 23:
                centerXMultiplier = CGFloat(1.8)
                centerYMultiplier = CGFloat(1.8)
            default:
                centerXMultiplier = CGFloat(1)
                centerYMultiplier = CGFloat(1)
            }
            
            constraints.append(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: centerXMultiplier, constant: 0))
            constraints.append(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: centerYMultiplier, constant: 0))
            
            constraints.append(ratioConstaint)
            constraints.append(sizeConstaint)
        }
        
        NSLayoutConstraint.activate(constraints)
    }
}

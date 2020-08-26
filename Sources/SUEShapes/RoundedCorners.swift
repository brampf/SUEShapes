/*
 
 Copyright (c) <2020>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
 */

import SwiftUI

public struct RoundedCorners : View {
    
    public enum Segment{
        case start
        case middle
        case end
    }
    
    public enum `Type` {
        case regular
        case regularOutline
        case dashed
        case dashedOutline
    }
    
    var hue : Double
    var part : Segment
    var type : Type = .regular
    var radius : CGFloat = 15
    var border : CGFloat = 4
    var padding : CGFloat?
    
    @ViewBuilder public var body : some View {
        
        switch part {
        case .start:
            RoundedCornersTop(radius: self.radius).fill(bodyColor).overlay(RoundedCornersTop(radius: self.radius).stroke(borderColor,style: borderStyle)).padding([.top,.horizontal], padding == nil ? border : padding)
        case .middle:
            Rectangle().fill(bodyColor).overlay(RoundedCornersCenter().stroke(borderColor,style: borderStyle)).padding(.horizontal, padding == nil ? border : padding)
        case .end:
            RoundedCornersBottom(radius: self.radius).fill(bodyColor).overlay(RoundedCornersBottom(radius: self.radius).stroke(borderColor,style: borderStyle)).padding([.bottom,.horizontal], padding == nil ? border : padding)

        }
        
    }
    
    var bodyColor : Color {
        
        switch type {
        case .regular:
            return Color(hue: self.hue, saturation: 1, brightness: 1, opacity: 0.5)
        case .dashed:
            return Color(hue: self.hue, saturation: 1, brightness: 1, opacity: 0.5)
        case .dashedOutline:
            return Color.clear
        case .regularOutline:
            return Color.clear
        }
    }
    
    var borderStyle : StrokeStyle {
        
        switch type {
        case .regular:
            return StrokeStyle(lineWidth: self.border)
        case .dashed:
            return StrokeStyle(lineWidth: self.border, dash: [10,5])
        case .dashedOutline:
            return StrokeStyle(lineWidth: self.border, dash: [10,5])
        case .regularOutline:
            return StrokeStyle(lineWidth: self.border)
        }
        
    }
    
    var borderColor : Color {
        
        Color(hue: self.hue, saturation: 1, brightness: 0.5)
    }
    
}

struct RoundedCornersTop : Shape {
    
    var radius : CGFloat = 0.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let w = rect.size.width
        let h = rect.size.height
        
        // Make sure we do not exceed the size of the rectangle
        let radius = min(min(self.radius, h/2), w/2)
        
        path.move(to: CGPoint(x: 0, y: h))
        path.addLine(to: CGPoint(x: 0, y: 0+radius))
        path.addArc(center: CGPoint(x: 0+radius, y: 0+radius), radius: radius,
                    startAngle: Angle(degrees: 180), endAngle: Angle(degrees: -90), clockwise: false)
        path.addLine(to: CGPoint(x: w-radius, y: 0))
        path.addArc(center: CGPoint(x: w-radius, y: 0+radius), radius: radius,
                    startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
        path.addLine(to: CGPoint(x: w, y: h))
        
        return path
    }
}

struct RoundedCornersCenter : Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let w = rect.size.width
        let h = rect.size.height
        
        path.move(to: CGPoint(x: 0, y: h))
        path.addLine(to: CGPoint(x: 0, y: 0))
        
        path.move(to: CGPoint(x: w, y: 0))
        path.addLine(to: CGPoint(x: w, y: h))
        
        return path
    }
}

struct RoundedCornersBottom : Shape {
    
    var radius : CGFloat = 0.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let w = rect.size.width
        let h = rect.size.height
        
        // Make sure we do not exceed the size of the rectangle
        let radius = min(min(self.radius, h/2), w/2)
        
        path.move(to: CGPoint(x: w, y: 0))
        path.addLine(to: CGPoint(x: w, y: h-radius))
        path.addArc(center: CGPoint(x: w-radius, y: h-radius), radius: radius,
                    startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        path.addLine(to: CGPoint(x: 0+radius, y: h))
        path.addArc(center: CGPoint(x: 0+radius, y: h-radius), radius: radius,
                    startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        path.addLine(to: CGPoint(x: 0, y: 0))
        
        return path
    }
}

#if DEBUG
struct SelectionView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        HStack {
            VStack(spacing: 0) {
                RoundedCorners(hue: 0.2, part: .start)
                RoundedCorners(hue: 0.2, part: .middle)
                RoundedCorners(hue: 0.2, part: .middle)
                RoundedCorners(hue: 0.2, part: .middle)
                RoundedCorners(hue: 0.2, part: .middle)
                RoundedCorners(hue: 0.2, part: .end)
                Spacer()
            }
            VStack(spacing: 0) {
                RoundedCorners(hue: 0.4, part: .start, type: .dashed)
                RoundedCorners(hue: 0.4, part: .middle, type: .dashed)
                RoundedCorners(hue: 0.4, part: .middle, type: .dashed)
                RoundedCorners(hue: 0.4, part: .end, type: .dashed)
                Spacer()
            }
            VStack(spacing: 0) {
                RoundedCorners(hue: 0.6, part: .start, type: .regularOutline)
                RoundedCorners(hue: 0.6, part: .middle, type: .regularOutline)
                RoundedCorners(hue: 0.6, part: .middle, type: .regularOutline)
                RoundedCorners(hue: 0.6, part: .middle, type: .regularOutline)
                RoundedCorners(hue: 0.6, part: .middle, type: .regularOutline)
                RoundedCorners(hue: 0.6, part: .middle, type: .regularOutline)
                RoundedCorners(hue: 0.6, part: .end, type: .regularOutline)
                Spacer()
            }
            VStack(spacing: 0) {
                RoundedCorners(hue: 0.8, part: .start, type: .dashedOutline)
                RoundedCorners(hue: 0.8, part: .middle, type: .dashedOutline)
                RoundedCorners(hue: 0.8, part: .end, type: .dashedOutline)
                Spacer()
            }
            
            
        }.padding().preferredColorScheme(.light)
    }
}
#endif

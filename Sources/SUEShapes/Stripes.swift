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

public struct Stripes : Shape {
    
    var distance : CGFloat = 20
    var offset : CGFloat = 0
    
    var width : CGFloat = 7
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let w = rect.size.width
        let h = rect.size.height
    
        let stripes = w+h+width
        
        var xswitch = false
        var corrx : CGFloat = 0
        var yswitch = false
        var corry : CGFloat = 0
        
        var start = CGPoint(x: offset, y:-width)
        var end = CGPoint(x: -width, y: offset)
        for _ in stride(from: 0, to: stripes, by: distance) {
            
            // draw line
            path.move(to: start)
            path.addLine(to: end)
            
            // move start position
            if (start.x+distance <= w){
                // we have not hit the upper bound yet
                start = CGPoint(x: start.x+distance, y: -width)
            } else if !xswitch {
                // correct the distance once we hit the corner
                corrx = distance - (w+width - start.x+width)
                xswitch = true // switch direction
                start = CGPoint(x: w+width, y: corrx)
            } else {
                // continue on the other axis
                start = CGPoint(x: w+width, y: start.y+distance)
            }
            
            // move end position
            if (end.y+distance <= h){
                // we have not hit the upper bound yet
                end = CGPoint(x: -width, y: end.y+distance)
            } else if !yswitch {
                // correct the distance once we hit the corner
                corry = distance - (h+width-end.y+width)
                yswitch = true
                end = CGPoint(x: corry, y: h+width)
            } else {
                // continue on the other axis
                end = CGPoint(x: end.x+distance, y: h+width)
            }
        }
        
        return path
    }
    
}

#if DEBUG
struct StripeView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        Stripes().stroke(Color.black, lineWidth: 10).background(Color.yellow)
            .previewLayout(.fixed(width: 300, height: 100))
        
    }

}

struct StripeView2_Previews: PreviewProvider {
    
    static var previews: some View {
        
        Stripes().stroke(Color.black, lineWidth: 10).background(Color.yellow)
            .previewLayout(.fixed(width: 200, height: 300))
        
    }
    
}

struct StripeView3_Previews: PreviewProvider {
    
    static var previews: some View {
        
        Group{
            Stripes(distance: 10, offset: 5).stroke(Color.red, lineWidth: 5).background(Color.yellow)
                .previewLayout(.fixed(width: 300, height: 200))
            Stripes(distance: 10, offset: 5).stroke(Color.red, lineWidth: 5).background(Color.yellow)
                .previewLayout(.fixed(width: 200, height: 300))
        }
        
    }
    
}

struct StripeView4_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ZStack{
            Stripes(distance: 20, offset: 0).stroke(Color.red, lineWidth: 5)
            Stripes(distance: 20, offset: 5).stroke(Color.blue, lineWidth: 5)
            Stripes(distance: 20, offset: 10).stroke(Color.green, lineWidth: 5)
        }
            .previewLayout(.fixed(width: 300, height: 300))
        
    }
    
}

struct StripeView5_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ZStack{
            Stripes(distance: 60, offset: 0).stroke(Color.red, lineWidth: 15)
            Stripes(distance: 60, offset: 20).stroke(Color.blue, lineWidth: 15)
            Stripes(distance: 60, offset: 40).stroke(Color.green, lineWidth: 15)
        }.rotationEffect(.degrees(90))
        .previewLayout(.fixed(width: 300, height: 300))
        
    }
    
}
#endif

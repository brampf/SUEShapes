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

public struct HorizontalLine : Shape {
    
    var radius : CGFloat = 0.0
    var lineWidth : CGFloat = 0.0
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let w = rect.size.width
        
        path.move(to: CGPoint(x: 0, y: 0))
        
        path.addLine(to: CGPoint(x: w, y: 0))

        return path
    }
}

public struct VerticalLine : Shape {
    
    var radius : CGFloat = 0.0
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()

        let h = rect.size.height
        
        path.move(to: CGPoint(x: 0, y: 0))
        
        path.addLine(to: CGPoint(x: 0, y: h))
        
        return path
    }
}

#if DEBUG
struct Lines_Previews: PreviewProvider {
    
    static var previews: some View {
        
        Group{
                HorizontalLine().stroke(lineWidth: 5).padding()
                VerticalLine().stroke(lineWidth: 5).padding()
        }.preferredColorScheme(.light)
            
        }
}
#endif

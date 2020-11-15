//
// Copyright (c) 2020 Related Code - http://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

//-------------------------------------------------------------------------------------------------------------------------------------------------
extension UIView {

	//---------------------------------------------------------------------------------------------------------------------------------------------
	@IBInspectable
	var cornerRadius: CGFloat {

		get {
			return layer.cornerRadius
		}
		set {
			layer.cornerRadius = newValue
			layer.masksToBounds = newValue > 0
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	@IBInspectable
	var borderWidth: CGFloat {

		get {
			return layer.borderWidth
		}
		set {
			layer.borderWidth = newValue
		}
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	@IBInspectable
	var borderColor: UIColor? {

		get {
			let color = UIColor.init(cgColor: layer.borderColor!)
			return color
		}
		set {
			layer.borderColor = newValue?.cgColor
		}
	}

    func fadeTransition(_ duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
                                                            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }

    func keepCenterAndApplyAnchorPoint(_ point: CGPoint) {

        guard layer.anchorPoint != point else { return }

        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)

        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)

        var c = layer.position
        c.x -= oldPoint.x
        c.x += newPoint.x

        c.y -= oldPoint.y
        c.y += newPoint.y

        layer.position = c
        layer.anchorPoint = point
    }
}

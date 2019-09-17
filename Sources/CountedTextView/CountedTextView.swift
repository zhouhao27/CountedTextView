import SwiftUI

@available(iOS 13, *)
public struct CountedTextView: UIViewRepresentable {
  
  public typealias UIViewType = UICountedTextView
    
  @Binding private var text: String
  private var placeHolder: String
  private var maxAllowedCharacters: Int
  
  public init(text: Binding<String>, placeHolder: String = "", maxAllowedCharacters: Int = 250) {
    self._text = text
    self.placeHolder = placeHolder
    self.maxAllowedCharacters = maxAllowedCharacters
  }
  
  public func makeUIView(context: UIViewRepresentableContext<CountedTextView>) -> UICountedTextView {
    let view = UICountedTextView(frame: CGRect.zero)
    view.borderColor = UIColor.gray
    view.borderWidth = 1
    view.radius = 5
    view.placeHolder = self.placeHolder
    view.maxCharactersAllowed = self.maxAllowedCharacters
    view.onTextChanged = {
      text in
      self.text = text
    }
    return view
  }
    
  public func updateUIView(_ uiView: UICountedTextView, context: UIViewRepresentableContext<CountedTextView>) {    
    if text.count > maxAllowedCharacters {
      let index = text.index(text.startIndex, offsetBy: min(maxAllowedCharacters, text.count))
      uiView.text = String(text[..<index])
    } else {
      uiView.text = text
    }
  }
}

#if DEBUG
struct CountedTextView_Previews : PreviewProvider {
  
  static var previews: some View {
    CountedTextView(text: .constant(""))
  }
}
#endif

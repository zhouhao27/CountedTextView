import SwiftUI

@available(iOS 13, *)
public struct CountedTextView: UIViewRepresentable {
  
  public typealias UIViewType = UICountedTextView
    
  @Binding private var text: String
  private var placeHolder: String
  
  public init(text: Binding<String>, placeHolder: String = "" ) {
    self._text = text
    self.placeHolder = placeHolder
  }
  
  public func makeUIView(context: UIViewRepresentableContext<CountedTextView>) -> UICountedTextView {
    let view = UICountedTextView(frame: CGRect.zero)
    view.borderColor = UIColor.gray
    view.borderWidth = 1
    view.radius = 5
    view.placeHolder = self.placeHolder    
    view.onTextChanged = {
      text in
      self.text = text
    }
    return view
  }
    
  public func updateUIView(_ uiView: UICountedTextView, context: UIViewRepresentableContext<CountedTextView>) {
    uiView.text = text
  }
}

#if DEBUG
struct CountedTextView_Previews : PreviewProvider {
  
  static var previews: some View {
    CountedTextView(text: .constant(""))
  }
}
#endif

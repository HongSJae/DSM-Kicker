import SwiftUI
import AVKit

class SoundSetting: ObservableObject {
    static let instance = SoundSetting()
    
    var player: AVAudioPlayer?

    func playSound() {
        guard let url = Bundle.main.url(forResource: "Kick", withExtension: ".wav") else { return }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("에러가 발생하였습니다.", error)
        }
    }
}

struct KeyEventHandling: NSViewRepresentable {
    class KeyView: NSView {
        private  var press = true
        override var acceptsFirstResponder: Bool { true }
        override func keyDown(with event: NSEvent) {
            print(event.keyCode)
            print(event.charactersIgnoringModifiers ?? "")
            if event.keyCode == 49 { // Spacebar의 키 코드는 49입니다.
                SoundSetting.instance.playSound()
            }
//            if press {
//                if event.keyCode == 33 {
//                    SoundSetting.instance.playSound()
//                    press.toggle()
//                }
//            } else {
//                if event.keyCode == 30 {
//                    SoundSetting.instance.playSound()
//                    press.toggle()
//                }
//            }
        }
    }

    func makeNSView(context: Context) -> NSView {
        let view = KeyView()
        DispatchQueue.main.async { // wait till next event cycle
            view.window?.makeFirstResponder(view)
        }
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {
    }
}

struct ContentView: View {
    var body: some View {
        Text("Kick")
            .font(.system(size: 50))
            .fontWeight(.bold)
            .fontWidth(.standard)
            .padding(20)
            .background(Color.purple)
            .cornerRadius(16)
            .background(KeyEventHandling())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

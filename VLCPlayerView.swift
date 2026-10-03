import SwiftUI
import UIKit
import VLCKit
struct VLCPlayerView:UIViewRepresentable{
 let url:URL
 func makeCoordinator()->Coordinator{Coordinator()}
 func makeUIView(context:Context)->UIView{let v=UIView();v.backgroundColor=.black;context.coordinator.player.drawable=v;context.coordinator.player.media=VLCMedia(url:url);context.coordinator.player.play();return v}
 func updateUIView(_ v:UIView,context:Context){if context.coordinator.url != url{context.coordinator.player.stop();context.coordinator.url=url;context.coordinator.player.drawable=v;context.coordinator.player.media=VLCMedia(url:url);context.coordinator.player.play()}}
 static func dismantleUIView(_ v:UIView,coordinator:Coordinator){coordinator.player.stop();coordinator.player.drawable=nil}
 final class Coordinator{let player=VLCMediaPlayer();var url:URL?}
}

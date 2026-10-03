import Foundation

enum ViewerGrid: Int, CaseIterable, Identifiable {
    case one = 1, four = 4, nine = 9, sixteen = 16
    var id: Int { rawValue }
    var columns: Int { switch self { case .one: 1; case .four: 2; case .nine: 3; case .sixteen: 4 } }
    var title: String { "\(columns)×\(columns)" }
}
enum StreamProfile: String, CaseIterable, Identifiable { case main, sub; var id:String{rawValue} }
final class DVRConfigStore: ObservableObject {
 @Published var host:String {didSet{save()}}
 @Published var rtspPort:String {didSet{save()}}
 @Published var webPort:String {didSet{save()}}
 @Published var username:String {didSet{save()}}
 @Published var password:String {didSet{save()}}
 @Published var rtspTemplate:String {didSet{save()}}
 @Published var playbackPath:String {didSet{save()}}
 private let d=UserDefaults.standard
 init(){host=d.string(forKey:"host") ?? "";rtspPort=d.string(forKey:"rtspPort") ?? "8554";webPort=d.string(forKey:"webPort") ?? "8081";username=d.string(forKey:"username") ?? "admin";password=d.string(forKey:"password") ?? "";rtspTemplate=d.string(forKey:"rtspTemplate") ?? "rtsp://{username}:{password}@{host}:{port}/";playbackPath=d.string(forKey:"playbackPath") ?? "/playback.html"}
 func save(){d.set(host,forKey:"host");d.set(rtspPort,forKey:"rtspPort");d.set(webPort,forKey:"webPort");d.set(username,forKey:"username");d.set(password,forKey:"password");d.set(rtspTemplate,forKey:"rtspTemplate");d.set(playbackPath,forKey:"playbackPath")}
 func rtspURL(channel:Int,profile:StreamProfile)->URL?{var s=rtspTemplate;let m=["{host}":host,"{port}":rtspPort,"{channel}":String(channel),"{username}":username,"{password}":password,"{stream}":profile == .main ? "main":"sub"];for(k,v) in m{s=s.replacingOccurrences(of:k,with:v)};return URL(string:s)}
 func webURL()->URL?{guard !host.isEmpty else{return nil};return URL(string:"http://\(host):\(webPort)\(playbackPath.hasPrefix("/") ? playbackPath : "/"+playbackPath)")}
}

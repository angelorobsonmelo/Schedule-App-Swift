import Foundation

public class RemoteUtils {
    
    public static let BASE_URL = "http://ocorrencia.stant.com.br/api/"
    
    public static func buildUrl(_ path: String) -> String {
        return BASE_URL + path
    }        
}

import Foundation

// Variável global para alternar entre modo produção e desenvolvimento
let isProduction = true // Altere para false para modo desenvolvimento

// Função utilitária para obter o nome correto do arquivo de áudio
func audioFileName(_ name: String) -> String {
    if isProduction {
        // Insere "-new" antes da extensão, se existir
        if let dotIndex = name.lastIndex(of: ".") {
            let base = name[..<dotIndex]
            let ext = name[dotIndex...]
            return "\(base)-new\(ext)"
        } else {
            return name + "-new"
        }
    } else {
        return name
    }
}

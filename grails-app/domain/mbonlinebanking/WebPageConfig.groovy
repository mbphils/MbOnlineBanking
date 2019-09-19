package mbonlinebanking

class WebPageConfig {
    String pageDescription
    String encryptBaseUrl
    
    static constraints = {
        pageDescription nullable:true
        encryptBaseUrl nullable:true
        
    }
}

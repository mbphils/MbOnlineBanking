package mbonlinebanking

class WebConfig {

    String paramCode
	String paramType
	String paramValue
	String caption

    static constraints = {
    	paramCode maxSize:10, unique:true
    	paramType maxSize:10
    	paramValue maxSize: 100
        caption nullable:true
    }

    static mapping = {
	id sqlType:'int', generator:'increment'
    }
}

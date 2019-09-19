class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller:"webPortalManagement", action:"login")
        "500"(view:'/error')
	}
}

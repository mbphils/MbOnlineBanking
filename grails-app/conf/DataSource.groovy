dataSource {
    pooled = true
    jmxExport = true
    driverClassName = "org.postgresql.Driver"
    username = "postgres"
    password = "postgres"
}
hibernate {
    cache.use_second_level_cache = true
    cache.us//    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory' // Hibernate 3
    cache.region.factory_class = 'org.hibernate.cache.ehcache.EhCacheRegionFactory' // Hibernate 4
    singleSession = true // configure OSIV singleSession mode
    flush.mode = 'manual' // OSIV session flush mode outside of transactional context
}

// environment specific settings
environments {
    development {
        dataSource {
            //dbCreate = "create-drop"
            dbCreate = "update" // one of 'create', 'create-drop', 'update', 'validate', ''
            //url = "jdbc:h2:mem:devDb;MVCC=TRUE;LOCK_TIMEOUT=10000;DB_CLOSE_ON_EXIT=FALSE"

           //url = "jdbc:postgresql://localhost:5432/dtaFRP" 
           //url = "jdbc:postgresql://localhost:5432/mabuhayPASSBOOK"
           //url = "jdbc:postgresql://192.168.0.4:5432/newdemoicbs" // test server
           //url = "jdbc:postgresql://172.21.10.30:5432/icbs"
           
           url = "jdbc:postgresql://localhost:5432/webPortal"
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            //dbCreate = "create-drop"
            //url = "jdbc:h2:mem:testDb;MVCC=TRUE;LOCK_TIMEOUT=10000;DB_CLOSE_ON_EXIT=FALSE"
            
           //url = "jdbc:postgresql://localhost:5432/dtaFRP" 
           //url = "jdbc:postgresql://localhost:5432/mabuhayPASSBOOK"
           //url = "jdbc:postgresql://192.168.0.4:5432/newdemoicbs" // test server
           //url = "jdbc:postgresql://172.21.10.30:5432/icbs"
           
           url = "jdbc:postgresql://localhost:5432/webPortal"
        }
    }
    
    production {
        dataSource {
           dbCreate = "update"
            //dbCreate = "create-drop"
            

           //url = "jdbc:postgresql://localhost:5432/dtaFRP" 
           //url = "jdbc:postgresql://localhost:5432/mabuhayPASSBOOK"
           //url = "jdbc:postgresql://192.168.0.4:5432/newdemoicbs" // test server
           //url = "jdbc:postgresql://172.21.10.30:5432/icbs"
           
           url = "jdbc:postgresql://localhost:5432/webPortal"
        }
    }
}

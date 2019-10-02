package mbonlinebanking

import groovy.sql.Sql
import java.io.*; // ito giezel need 
import java.net.*;
import java.util.*; // ito giezel need
import java.util.concurrent.ConcurrentHashMap;
import org.*
import grails.converters.JSON
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.json.JSONObject
import org.springframework.web.context.request.RequestContextHolder
import javax.servlet.http.HttpSession
import java.text.DateFormat; // ito giezel need
import java.text.SimpleDateFormat; // ito giezel need
import java.util.Calendar; // ito giezel need
import java.util.Date; // ito giezel need
import java.util.Formatter.DateTime // ito giezel need
import java.util.Iterator; 
import org.apache.commons.lang.RandomStringUtils
import org.apache.commons.codec.binary.Base64;

class WebPortalManagementController {
    
    private static final DateFormat giezelDateFormater = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // ito giezel need
    private static final DateFormat onlineBankingRefDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss:SSS");
    private HttpURLConnection  myURLConnection;
    def dataSource 
    static allowedMethods = [save: "POST", update: ["PUT","POST"], delete: "DELETE", saveCharge: "PUT"]
    String resultValue = null

    def index() {
        //redirect(action: 'login')
        println("index: ")
        println("params : "+params)
        redirect(action: 'multiSender')
    }
   
    def registration(){
        println("params: "+params)
        if(params.isAcceptByUser){
            
        }else{
            redirect(action: 'login')
        }
    }
    def addAccount(){
        println("========== ADD ACCOUNT ============")
        println("Params: "+params)
        def paramID = params.id
        if(paramID){
            // first decode
            byte[] decodedBytes = Base64.decodeBase64(paramID.toString());
            println("first decodedBytes " + new String(decodedBytes));
            paramID = new String(decodedBytes)
            // second decode
            byte[] decodedBytes2 = Base64.decodeBase64(paramID.toString());
            println("second decodedBytes " + new String(decodedBytes2));
            paramID = new String(decodedBytes2)
            println("normal value decoded: "+paramID)
            def splitTrueValueClientID = paramID.split("@##%")
            println("splitTrueValueClientID[0]: "+splitTrueValueClientID[0])
            println("splitTrueValueClientID[1]: "+splitTrueValueClientID[1])
            def clientIDx = splitTrueValueClientID[1]
            //============================================
            String defaultProcessMethod = "inqGetClientInformation"
                println("=========== SHOW CLIENT INFORMATION ===============")
                println("Client ID: "+clientIDx)
                println("Action: "+defaultProcessMethod)
                println("===========================================")

                def json = request.JSON

                params.put("clientID",clientIDx)
                
                def responseFromICBS = poratalProcessParameters(defaultProcessMethod,params)
                println("responseFromICBS: "+responseFromICBS)
                StringTokenizer st = new StringTokenizer(responseFromICBS, "{}:\"");
                while(st.hasMoreTokens()) {
                    //println("st: "+st.nextToken())
                    resultValue = st.nextToken();
                    println("resultValue: "+resultValue)
                }
                //resultValue = resultValue.def sssInformation = theReturnValue.split("@@#")
                def informationResultValue = resultValue.split("@@<>");
                def reponseWebPortal = []

                println("responsetexx: "+resultValue)

                String resultFailedSuccess = informationResultValue[0].toString()
                if(resultFailedSuccess == "success"){

                    def addAccountMaps = [:]

                    addAccountMaps.put('displayName',informationResultValue[2].toString())
                    addAccountMaps.put('encryptCustomerId',"XXXX-XXXX"+informationResultValue[1].substring(8,informationResultValue[1].length()))
                    addAccountMaps.put('homeAddress',informationResultValue[4].toString())
                    addAccountMaps.put('emailAddress',informationResultValue[5].toString())
                    addAccountMaps.put('mobileNumber',informationResultValue[6].toString())
                    [addAccountMaps:addAccountMaps]

                }else{

                }

                //render reponseWebPortal as grails.converters.JSON
            //============================================
        }else{
            println("There was a problem with the request")
            return
        }
    }
    def agreement(){ 
    }
    def home(){
        println("params:"+params)
    }
    def accountOverview(){
         println(" ============ View Link Accounts =========")
         println("params: "+params)
        def paramID = params.id
        if(paramID){
            String defaultProcessMethod = "viewLinkedAccounts"
            // first decode
            byte[] decodedBytes = Base64.decodeBase64(paramID.toString());
            println("first decodedBytes " + new String(decodedBytes));
            paramID = new String(decodedBytes)
            // second decode
            byte[] decodedBytes2 = Base64.decodeBase64(paramID.toString());
            println("second decodedBytes " + new String(decodedBytes2));
            paramID = new String(decodedBytes2)
            println("normal value decoded: "+paramID)
            def splitTrueValueClientID = paramID.split("@##%")
            println("splitTrueValueClientID[0]: "+splitTrueValueClientID[0])
            println("splitTrueValueClientID[1]: "+splitTrueValueClientID[1])
            def clientIDx = splitTrueValueClientID[1]
            // ========= START OF CODE ==============
            params.put("customerId",clientIDx)

            def responseFromICBS = poratalProcessParameters(defaultProcessMethod,params)

            StringTokenizer st = new StringTokenizer(responseFromICBS, "{}:\"");
            while(st.hasMoreTokens()) {
                resultValue = st.nextToken();
            }

            def informationResultValue = resultValue.split("@@<>");
            def reponseWebPortal = []

            println("responsetexx: "+resultValue)

            String resultFailedSuccess = informationResultValue[0].toString()
            def jmcounterXcounter = 0
            def jmArrayHandler = []
            def jmdataHandler = []
            def clientdisplayName = informationResultValue[2].toString()
            def clientCustomerId = "XXXX-XXXX"+informationResultValue[3].substring(8,informationResultValue[3].length())
            if(resultFailedSuccess == "success"){
                // record recordReponseFromICBS is a string record from icbs online linked account table
                def recordReponseFromICBS = informationResultValue[1].toString()

                println("recordReponseFromICBS: "+recordReponseFromICBS)
                // this string contains delimiters so that we have to split it 
                // each row in the string will be splitted with character '@@<#"'
                def splitRowsFromString = recordReponseFromICBS.toString().split("@@<#")
                // after splitting the string will be in array form element size is base on how many '@@<#' characters
                // that the tokenizer will be found
                for(x in splitRowsFromString){
                   // this loop will get the data from the splitted string
                   def arrayGetterFromSplit = x.toString().split("##")
                   // linked Account Maps is used to mapped the data when it is in the web page.
                   def linkedAccountMaps = [:]
                   
                   linkedAccountMaps.put('id',arrayGetterFromSplit[0])
                   linkedAccountMaps.put('acctNo',"XXXX-XXXX"+arrayGetterFromSplit[1].substring(10,arrayGetterFromSplit[1].length()))
                   linkedAccountMaps.put('acctType',arrayGetterFromSplit[2])
                   linkedAccountMaps.put('status',arrayGetterFromSplit[3])
                   linkedAccountMaps.put('remarks',arrayGetterFromSplit[4])
                   
                   jmdataHandler[jmcounterXcounter] = linkedAccountMaps
                   println("jmdataHandler: "+linkedAccountMaps)
                   jmcounterXcounter = jmcounterXcounter + 1
                }
                println("jmdataHandler: "+jmdataHandler)
                [jmdataHandler:jmdataHandler,clientdisplayName:clientdisplayName,clientCustomerId:clientCustomerId]
                
            }else{
                [jmdataHandler:jmdataHandler,clientdisplayName:clientdisplayName,clientCustomerId:clientCustomerId]
            }
            //============================================
        }else{
            println("There was a problem with the request")
            return
        }
    }
    def transferFunds(){
        println("========== transferFunds ===========")
        println("params: "+params)
       
        def paramID = params.id
        if(paramID){
            String defaultProcessMethod = "getTransferFundAcounnts"
            // first decode
            byte[] decodedBytes = Base64.decodeBase64(paramID.toString());
            println("first decodedBytes " + new String(decodedBytes));
            paramID = new String(decodedBytes)
            // second decode
            byte[] decodedBytes2 = Base64.decodeBase64(paramID.toString());
            println("second decodedBytes " + new String(decodedBytes2));
            paramID = new String(decodedBytes2)
            println("normal value decoded: "+paramID)
            def splitTrueValueClientID = paramID.split("@##%")
            println("splitTrueValueClientID[0]: "+splitTrueValueClientID[0])
            println("splitTrueValueClientID[1]: "+splitTrueValueClientID[1])
            def clientIDx = splitTrueValueClientID[1]
            // ========= START OF CODE ==============
            params.put("customerId",clientIDx)

            def responseFromICBS = poratalProcessParameters(defaultProcessMethod,params)

            StringTokenizer st = new StringTokenizer(responseFromICBS, "{}:\"");
            while(st.hasMoreTokens()) {
                resultValue = st.nextToken();
            }

            def informationResultValue = resultValue.split("@@<>");
            def reponseWebPortal = []

            println("responsetexx: "+resultValue)

            String resultFailedSuccess = informationResultValue[0].toString()
            def jmcounterXcounter = 0
            def jmArrayHandler = []
            def jmdataHandler = []
            def clientdisplayName = informationResultValue[2].toString()
            def clientCustomerId = "XXXX-XXXX"+informationResultValue[3].substring(8,informationResultValue[3].length())
            if(resultFailedSuccess == "success"){
                // record recordReponseFromICBS is a string record from icbs online linked account table
                def recordReponseFromICBS = informationResultValue[1].toString()

                println("recordReponseFromICBS: "+recordReponseFromICBS)
                // this string contains delimiters so that we have to split it 
                // each row in the string will be splitted with character '@@<#"'
                def splitRowsFromString = recordReponseFromICBS.toString().split("@@<#")
                // after splitting the string will be in array form element size is base on how many '@@<#' characters
                // that the tokenizer will be found
                for(x in splitRowsFromString){
                   // this loop will get the data from the splitted string
                   def arrayGetterFromSplit = x.toString().split("##")
                   // linked Account Maps is used to mapped the data when it is in the web page.
                   def linkedAccountMaps = [:]
                   
                   linkedAccountMaps.put('id',arrayGetterFromSplit[0])
                   linkedAccountMaps.put('acctNo',"XXXX-XXXX"+arrayGetterFromSplit[1].substring(10,arrayGetterFromSplit[1].length()))
                   linkedAccountMaps.put('acctType',arrayGetterFromSplit[2])
                   
                   linkedAccountMaps.put('status',arrayGetterFromSplit[3])
                   linkedAccountMaps.put('description',arrayGetterFromSplit[2]+' : ' + "XXXX-XXXX"+arrayGetterFromSplit[1].substring(10,arrayGetterFromSplit[1].length()))
                   linkedAccountMaps.put('availableBalance',arrayGetterFromSplit[5])
                   jmdataHandler[jmcounterXcounter] = linkedAccountMaps
                   println("jmdataHandler: "+linkedAccountMaps)
                   jmcounterXcounter = jmcounterXcounter + 1
                }
                println("jmdataHandler: "+jmdataHandler)
                [jmdataHandler:jmdataHandler,clientdisplayName:clientdisplayName,clientCustomerId:clientCustomerId]
                
            }else{
                [jmdataHandler:jmdataHandler,clientdisplayName:clientdisplayName,clientCustomerId:clientCustomerId]
            }
        }    
    }
    def validateTransferFunds(){
        println("========== transferFunds ===========")
        def json = request.JSON
        println("funlnk: "+json.funlnk)
        println("deacnum: "+json.deacnum)
        println("trnsframt: "+json.trnsframt)
        
        params.put("funlnk",json.funlnk)
        params.put("deacnum",json.deacnum)
        params.put("trnsframt",json.trnsframt)
        
        String defaultProcessMethod = "validateTransferFundDetails" 
        def responseFromICBS = poratalProcessParameters(defaultProcessMethod,params)
        
        StringTokenizer st = new StringTokenizer(responseFromICBS, "{}:\"");
        while(st.hasMoreTokens()) {
            resultValue = st.nextToken();
        }

        def informationResultValue = resultValue.split("@@<>");
        def reponseWebPortal = []
       
        println("responsetexx: "+resultValue)

        String resultFailedSuccess = informationResultValue[0].toString()
        if(resultFailedSuccess == "success"){
            // encode clientId for security purposes

            session.emailAddresss = informationResultValue[2]
            resultValue = informationResultValue[1]
            reponseWebPortal << [reponseCode:resultFailedSuccess, responsetexx:resultValue,reponseResult:resultFailedSuccess]
        }else{
            resultValue = informationResultValue[1]
            reponseWebPortal << [reponseCode:resultFailedSuccess, responsetexx:resultValue,reponseResult:resultFailedSuccess]
        }
        
        render reponseWebPortal as grails.converters.JSON
        
    }
    def saveTransferFundsTxn(){
        println("=============== SAVE FUND TRASFER TXN saveTransferFundsTxn =================")
        println("params: "+params)
        if(params.valdidx.toString() == "validated"){
            
            params.put("fundingAccountid",params.fundingAcct.id)
            String defaultProcessMethod = "saveTransferFundDetails" 
            def responseFromICBS = poratalProcessParameters(defaultProcessMethod,params)

            StringTokenizer st = new StringTokenizer(responseFromICBS, "{}:\"");
            while(st.hasMoreTokens()) {
                resultValue = st.nextToken();
            }

            def informationResultValue = resultValue.split("@@<>");
            def reponseWebPortal = []

            println("responsetexx: "+resultValue)

            String resultFailedSuccess = informationResultValue[0].toString()
            if(resultFailedSuccess == "success"){

                // encode clientId for security purposes
                String combineEncapsulate = "webXsecurityMicroBankersPhilippinesIncorporationWebBankingOnline@##%"+informationResultValue[1].toString()
                //firstEncode
                byte[] encodedBytes = Base64.encodeBase64(combineEncapsulate.getBytes());
                //secondEncode
                resultValue = new String(encodedBytes)
                println("first encode: "+resultValue)
                byte[] encodedBytes2 = Base64.encodeBase64(resultValue.getBytes());
                resultValue = new String(encodedBytes2)
                
                
                println("second encode: "+resultValue)
                redirect(action: 'accountOverview',controller: 'webPortalManagement',id:resultValue)
            }else{
                
            }
        }
            
        
    }
    def paybills(){
        
    }
    def showRegistration(){
        
    }
    def viewAccount(){
        
    }
    def submitUserRegistration(){
        // ======== REST API 
        
        String defaultProcessMethod = "submitUserRegistry"
        println("=========== REGISTRY PARAMS ===============")
        println("params: "+params)
        println("Action: "+defaultProcessMethod)
        println("===========================================")

        def json = request.JSON
        println("json: "+json.customerID)
        
        params.put("customerId",json.customerID)
        params.put("firstname",json.firstName)
        params.put("middleName",json.middleName)
        params.put("lastName",json.lastName)
        params.put("mobile",json.mobile)
        params.put("address",json.address)
        params.put("email",json.emailAddress)
        params.put("username",json.username)
        params.put("txtpassword",json.txtpassword.encodeAsMD5())
        
        
        def responseFromICBS = poratalProcessParameters(defaultProcessMethod,params)
        
        StringTokenizer st = new StringTokenizer(responseFromICBS, "{}:\"");
        while(st.hasMoreTokens()) {
            resultValue = st.nextToken();
        }

        def informationResultValue = resultValue.split("@@<>");
        def reponseWebPortal = []
       
        println("responsetexx: "+resultValue)

        String resultFailedSuccess = informationResultValue[0].toString()
        if(resultFailedSuccess == "sucess"){
            // encode clientId for security purposes
            resultValue = informationResultValue[1]
            reponseWebPortal << [reponseCode:'xxxx', responsetexx:resultValue,reponseResult:resultFailedSuccess]
        }else{
            resultValue = informationResultValue[1]
            reponseWebPortal << [reponseCode:'xxxx', responsetexx:resultValue,reponseResult:resultFailedSuccess]
        }
        
        render reponseWebPortal as grails.converters.JSON
        
        
    }
    
    def poratalProcessParameters(String processMethod,params){
        println("==================== PROCESS PARAMETERS ===================")
        println("params: "+params)
        URL url = null;
        String action = "";
        action = "Echo";
        String jmXSecurityCode = "";
        String jmXConnectionUrl = "";
        
        try {
            if("Echo".equals(action)){
                System.out.println("AAA");
                jmXConnectionUrl = WebConfig.findByParamCode("GEN.1001").paramValue.toString()
                jmXSecurityCode = WebConfig.findByParamCode("GEN.1003").paramValue.toString()
                
                println("jmXConnectionUrl: "+jmXConnectionUrl)
                println("jmXSecurityCode: "+jmXSecurityCode)
                url = new URL(jmXConnectionUrl);
            }
            // required item to validate request
            println("processMethod: "+processMethod)
            params.put("requestAction",processMethod)
            params.put("accessTokenOBS",jmXSecurityCode)
            
            StringBuilder postData = new StringBuilder();
            
            for (Map.Entry<String,Object> param : params.entrySet()) {
                if (postData.length() != 0) postData.append('&');
                postData.append(URLEncoder.encode(param.getKey(), "UTF-8"));
                postData.append('=');
                postData.append(URLEncoder.encode(String.valueOf(param.getValue()), "UTF-8"));
            }
            
            byte[] postDataBytes = postData.toString().getBytes("UTF-8");
            HttpURLConnection conn = (HttpURLConnection)url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
            conn.setRequestProperty("Content-Length", String.valueOf(postDataBytes.length));
            
            conn.setDoOutput(true);
            conn.getOutputStream().write(postDataBytes);
            Reader insx = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));

            String output="";
            
            for (int c; (c = insx.read()) >= 0; output = output+(char)c);
            System.out.println("output :" + "<<"+output+">>");

            insx.close();

            output = output.replaceAll("\\n", "");
            output = output.replaceAll("\\r", ""); 
            output = output.replace("\\u0000", ""); 

            return output;
           
            
        } 
        catch (MalformedURLException e) { 
            //System.out.println(e);
            // new URL() failed
            
            // ...
        }  
    }
    
    
    def validateExistingUsername(){
        String defaultProcessMethod = "validateExistingUsername"
        println("=========== REGISTRY PARAMS ===============")
        println("params: "+params)
        println("Action: "+defaultProcessMethod)
        println("===========================================")
        

        def json = request.JSON
        params.put("username",json.username)
        
        def responseFromICBS = poratalProcessParameters(defaultProcessMethod,params)
    
        StringTokenizer st = new StringTokenizer(responseFromICBS, "{}:\"");
        while(st.hasMoreTokens()) {
            resultValue = st.nextToken();
        }
        
        def informationResultValue = resultValue.split("@@<>");
        def reponseWebPortal = []
       
        println("responsetexx: "+resultValue)

        String resultFailedSuccess = informationResultValue[0].toString()
        println("resultFailedSuccess: "+resultFailedSuccess)
        println("informationResultValue[1]: "+informationResultValue[1])
        if(resultFailedSuccess == "success"){
            // encode clientId for security purposes
           
            resultValue = informationResultValue[1]
            reponseWebPortal << [reponseCode:'xxxx', responsetexx:resultValue,reponseResult:resultFailedSuccess]
        }else{
            resultValue = informationResultValue[1]
            reponseWebPortal << [reponseCode:'xxxx', responsetexx:resultValue,reponseResult:resultFailedSuccess]
        }
        
        render reponseWebPortal as grails.converters.JSON
    }
    def validateExistingCustomerId(){
        String defaultProcessMethod = "validateExistingCustomerId"
        println("=========== REGISTRY PARAMS ===============")
        println("params: "+params)
        println("Action: "+defaultProcessMethod)
        println("===========================================")
        

        def json = request.JSON
        params.put("customerid",json.customerid)
        
        def responseFromICBS = poratalProcessParameters(defaultProcessMethod,params)
    
        StringTokenizer st = new StringTokenizer(responseFromICBS, "{}:\"");
        while(st.hasMoreTokens()) {
            resultValue = st.nextToken();
        }
        
        def informationResultValue = resultValue.split("@@<>");
        def reponseWebPortal = []
       
        println("responsetexx: "+resultValue)

        String resultFailedSuccess = informationResultValue[0].toString()
        println("resultFailedSuccess: "+resultFailedSuccess)
        println("informationResultValue[1]: "+informationResultValue[1])
        if(resultFailedSuccess == "success"){
            // encode clientId for security purposes
           
            resultValue = informationResultValue[1]
            reponseWebPortal << [reponseCode:'xxxx', responsetexx:resultValue,reponseResult:resultFailedSuccess]
        }else{
            resultValue = informationResultValue[1]
            reponseWebPortal << [reponseCode:'xxxx', responsetexx:resultValue,reponseResult:resultFailedSuccess]
        }
        
        render reponseWebPortal as grails.converters.JSON
    }
    def login(){
        def urlRedirectInstance = '/MbOnlineBanking/webPortalManagement/userClientPage/'
        [urlRedirectInstance:urlRedirectInstance]
    }
    def validateLoginCredentials(){
        String defaultProcessMethod = "validateUserLoginCredentials"
        println("=========== LOGIN PARAMS ===============")
        println("params: "+params)
        println("Action: "+defaultProcessMethod)
        println("===========================================")
        

        def json = request.JSON

        params.put("username",json.username)
        params.put("txtpassword",json.txtpassword.encodeAsMD5())
        
        
        def responseFromICBS = poratalProcessParameters(defaultProcessMethod,params)
        println("responseFromICBS: "+responseFromICBS)
        StringTokenizer st = new StringTokenizer(responseFromICBS, "{}:\"");
        while(st.hasMoreTokens()) {
            //println("st: "+st.nextToken())
            resultValue = st.nextToken();
            println("resultValue: "+resultValue)
        }
        //resultValue = resultValue.def sssInformation = theReturnValue.split("@@#")
        def informationResultValue = resultValue.split("@@<>");
        def reponseWebPortal = []
       
        println("responsetexx: "+resultValue)

        String resultFailedSuccess = informationResultValue[0].toString()
        if(resultFailedSuccess == "sucess"){
            
            // resultValue is the main variable
            resultValue = refreshUserSession(informationResultValue[1].toString())
            session.usersession = informationResultValue[1].toString()
            session.user = resultValue
            //session.session_timeout = WebConfig.findByParamCode('GEN.1004').paramValue
            reponseWebPortal << [reponseCode:'xxxx', responsetexx:resultValue,reponseResult:resultFailedSuccess]
            //redirect(controller: "WebPortalManagement", action: "userClientPage",id: resultValue)  
        }else{
            resultValue = informationResultValue[1]
            reponseWebPortal << [reponseCode:'xxxx', responsetexx:resultValue,reponseResult:resultFailedSuccess]
        }
        
        render reponseWebPortal as grails.converters.JSON
        
    }
    def forcelogout(){
        if(session.usersession) {
            println("session.usersession: "+session.usersession)
            def json = request.JSON
            String defaultProcessMethod = "forceLogoutUser"
            params.put("customerid",session.usersession)

            def responseFromICBS = poratalProcessParameters(defaultProcessMethod,params)

            StringTokenizer st = new StringTokenizer(responseFromICBS, "{}:\"");
            while(st.hasMoreTokens()) {
                resultValue = st.nextToken();
            }

            def informationResultValue = resultValue.split("@@<>");
            def reponseWebPortal = []

            println("responsetexx: "+resultValue)

            String resultFailedSuccess = informationResultValue[0].toString()
            println("resultFailedSuccess: "+resultFailedSuccess)
            println("informationResultValue[1]: "+informationResultValue[1])
            if(resultFailedSuccess == "success"){
                // encode clientId for security purposes
                println("sucess force logout")
                resultValue = resultFailedSuccess
                session.usersession = null
                session.user = null
                reponseWebPortal << [reponseCode:'xxxx', responsetexx:resultValue,reponseResult:resultFailedSuccess]
            }

            render reponseWebPortal as grails.converters.JSON
        } 
        
        
    }
    def userClientPage(){
        println("============== USER CLIENT PAGE ===========")
        println("params: "+params)
        def paramID = params.id
        def customerInformation = [:]
        if(paramID){
            // first decode
            byte[] decodedBytes = Base64.decodeBase64(paramID.toString());
            println("first decodedBytes " + new String(decodedBytes));
            paramID = new String(decodedBytes)
            // second decode
            byte[] decodedBytes2 = Base64.decodeBase64(paramID.toString());
            println("second decodedBytes " + new String(decodedBytes2));
            paramID = new String(decodedBytes2)
            println("normal value decoded: "+paramID)
            def splitTrueValueClientID = paramID.split("@##%")
            println("splitTrueValueClientID[0]: "+splitTrueValueClientID[0])
            println("splitTrueValueClientID[1]: "+splitTrueValueClientID[1])
            def clientIDx = splitTrueValueClientID[1]
            
            // referesh session
            resultValue = refreshUserSession(clientIDx.toString())
            session.usersession = clientIDx.toString()
            session.user = resultValue
            //============================================
            String defaultProcessMethod = "inqGetClientInformation"
                println("=========== SHOW CLIENT INFORMATION ===============")
                println("Client ID: "+clientIDx)
                println("Action: "+defaultProcessMethod)
                println("===========================================")

                def json = request.JSON

                params.put("clientID",clientIDx)
                
                def responseFromICBS = poratalProcessParameters(defaultProcessMethod,params)
                println("responseFromICBS: "+responseFromICBS)
                StringTokenizer st = new StringTokenizer(responseFromICBS, "{}:\"");
                while(st.hasMoreTokens()) {
                    //println("st: "+st.nextToken())
                    resultValue = st.nextToken();
                    println("resultValue: "+resultValue)
                }
                //resultValue = resultValue.def sssInformation = theReturnValue.split("@@#")
                def informationResultValue = resultValue.split("@@<>");
                
                //============================= FETCH DEPOSIT INFORMATION OF CUSTOMER ========================
               
                def depositsHandler = []
                def counter = 0 
                def depositLoopResultSet = informationResultValue[7].toString().split("@@<#")

                for(xDep in depositLoopResultSet){
                    println("xDep: "+xDep)
                    println("xDep1: ")
                    // listing of deposit accounts
                    def arrayGetterFromSplit = xDep.toString().split("##")
                    // linked Account Maps is used to mapped the data when it is in the web page.
                    def depositInformation = [:]
                    depositInformation.put('id',arrayGetterFromSplit[0])
                    depositInformation.put('acctNo',arrayGetterFromSplit[1])
                    depositInformation.put('branch',arrayGetterFromSplit[2])
                    depositInformation.put('product',arrayGetterFromSplit[3])
                    depositInformation.put('type',arrayGetterFromSplit[4])
                    depositInformation.put('status',arrayGetterFromSplit[5])
                    depositsHandler[counter] = depositInformation
                    counter = counter + 1;
                }
                //============================= END FETCH DEPOSIT INFORMATION OF CUSTOMER ========================
                def reponseWebPortal = []

                println("responsetexx: "+resultValue)

                String resultFailedSuccess = informationResultValue[0].toString()
                if(resultFailedSuccess == "success"){
                    
                    def emailAddress = informationResultValue[5].toString()
                    session.emailAddresss = emailAddress

                    
                    customerInformation.put('displayName',informationResultValue[2].toString())
                    customerInformation.put('encryptCustomerId',"XXXX-XXXX"+informationResultValue[1].substring(8,informationResultValue[1].length()))
                    customerInformation.put('homeAddress',informationResultValue[4].toString())
                    customerInformation.put('mobileNumber',informationResultValue[6].toString())
                    customerInformation.put('emailAddress',informationResultValue[5].toString())
                    
                    [customerInformation:customerInformation,depositsHandler:depositsHandler]

                }else{

                }

                //render reponseWebPortal as grails.converters.JSON
            //============================================
        }else{
            println("There was a problem with the request")
            return
        }
    }
    
    def getLinkedAccount(){
        println("========== getLinkedAccount ===========")
        println("params: "+params)
        def paramID = params.acctId
        if(paramID){
            String defaultProcessMethod = "saveLinkedAccountFrmWeb"
            // first decode
            byte[] decodedBytes = Base64.decodeBase64(paramID.toString());
            println("first decodedBytes " + new String(decodedBytes));
            paramID = new String(decodedBytes)
            // second decode
            byte[] decodedBytes2 = Base64.decodeBase64(paramID.toString());
            println("second decodedBytes " + new String(decodedBytes2));
            paramID = new String(decodedBytes2)
            println("normal value decoded: "+paramID)
            def splitTrueValueClientID = paramID.split("@##%")
            println("splitTrueValueClientID[0]: "+splitTrueValueClientID[0])
            println("splitTrueValueClientID[1]: "+splitTrueValueClientID[1])
            
            def clientIDx = splitTrueValueClientID[1]
            // ========= START OF CODE ==============
            params.put("customerId",clientIDx)
            params.put("depositType",params.accountType.id)

            def responseFromICBS = poratalProcessParameters(defaultProcessMethod,params)

            StringTokenizer st = new StringTokenizer(responseFromICBS, "{}:\"");
            while(st.hasMoreTokens()) {
                resultValue = st.nextToken();
            }

            def informationResultValue = resultValue.split("@@<>");
            def reponseWebPortal = []

            println("responsetexx: "+resultValue)

            String resultFailedSuccess = informationResultValue[0].toString()
            if(resultFailedSuccess == "success"){
                // encode clientId for security purposes
                 redirect(controller: "WebPortalManagement", action: "accountOverview",id: params.acctId) 
            }else{
                redirect(controller: "WebPortalManagement", action: "accountOverview",id: params.acctId)
            }
            //============================================
        }else{
            println("There was a problem with the request")
            return
        }
        
    }
    
    //View Account TXN
    // fetch all transactions of account
    def viewAccountTxn(){
       println("========== View Account Transactions ===========")
        println("params: "+params)
        
        def xHashCode = params.ctmitd
        def paramID = params.ctmitd
        def paramsLnk = params.lnkitd
        if(paramID){
            String defaultProcessMethod = "getAccountTransactions"
            // first decode
            byte[] decodedBytes = Base64.decodeBase64(paramID.toString());
            println("first decodedBytes " + new String(decodedBytes));
            paramID = new String(decodedBytes)
            // second decode
            byte[] decodedBytes2 = Base64.decodeBase64(paramID.toString());
            println("second decodedBytes " + new String(decodedBytes2));
            paramID = new String(decodedBytes2)
            println("normal value decoded: "+paramID)
            def splitTrueValueClientID = paramID.split("@##%")
            println("splitTrueValueClientID[0]: "+splitTrueValueClientID[0])
            println("splitTrueValueClientID[1]: "+splitTrueValueClientID[1])
            def clientIDx = splitTrueValueClientID[1]
            // referesh session
            resultValue = refreshUserSession(clientIDx.toString())
            session.usersession = clientIDx.toString()
            session.user = resultValue
            // ========= START OF CODE ==============
            params.put("customerId",clientIDx)
            params.put("linkId",paramsLnk)
            def responseFromICBS = poratalProcessParameters(defaultProcessMethod,params)
            
            StringTokenizer st = new StringTokenizer(responseFromICBS, "{}:\"");
            while(st.hasMoreTokens()) {
                resultValue = st.nextToken();
            }
            println("responsetexx: "+resultValue)
            def informationResultValue = resultValue.split("@@<>");
            def reponseWebPortal = []

            

            String resultFailedSuccess = informationResultValue[0].toString()
            def jmcounterXcounter = 0
            def jmArrayHandler = []
            def jmdataHandler = []
            
            def clientdisplayName = informationResultValue[2].toString()
            def clientCustomerId = "XXXX-XXXX"+informationResultValue[3].substring(8,informationResultValue[3].length())
            def acctdepositType = informationResultValue[4] 
            def acctdepositStatus = informationResultValue[5]
            def acctdepositLedger = informationResultValue[7]
            def acctdepositAvailable = informationResultValue[8]
            def acctdepositHoldBalance = informationResultValue[9]
            def acctdepositUnclearedBalance = informationResultValue[10]
            
            println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+informationResultValue[6])
            def acctdepositAcctNo = "XXXX-XXXX"+informationResultValue[6].substring(10,informationResultValue[6].length())
            // create object for acctInformation Values
            def acctInformationValues = [:]
                acctInformationValues.put('clientdisplayName',clientdisplayName)
                acctInformationValues.put('clientCustomerId',clientCustomerId)
                acctInformationValues.put('acctdepositType',acctdepositType)
                acctInformationValues.put('acctdepositStatus',acctdepositStatus)
                acctInformationValues.put('acctdepositLedger',acctdepositLedger)
                acctInformationValues.put('acctdepositAvailable',acctdepositAvailable)
                acctInformationValues.put('acctdepositHoldBalance',acctdepositHoldBalance)
                acctInformationValues.put('acctdepositUnclearedBalance',acctdepositUnclearedBalance)
                acctInformationValues.put('acctdepositAcctNo',acctdepositAcctNo)
            if(resultFailedSuccess == "success"){
                // record recordReponseFromICBS is a string record from icbs online linked account table
                def recordReponseFromICBS = informationResultValue[1].toString()

                println("recordReponseFromICBS: "+recordReponseFromICBS)
                // this string contains delimiters so that we have to split it 
                // each row in the string will be splitted with character '@@<#"'
                def splitRowsFromString = recordReponseFromICBS.toString().split("@@<#")
                // after splitting the string will be in array form element size is base on how many '@@<#' characters
                // that the tokenizer will be found
                for(x in splitRowsFromString){
                   // this loop will get the data from the splitted string
                   def arrayGetterFromSplit = x.toString().split("##")
                   // linked Account Maps is used to mapped the data when it is in the web page.
                   def txnAcctListing = [:]
                  def xxxxxDAte = arrayGetterFromSplit[0]? new Date().parse("yyyy-MM-dd", arrayGetterFromSplit[0]) : null
                   txnAcctListing.put('txnDate',xxxxxDAte)
                   txnAcctListing.put('branch',arrayGetterFromSplit[1])
                   txnAcctListing.put('txnDescription',arrayGetterFromSplit[2])
                   txnAcctListing.put('currency',arrayGetterFromSplit[3])
                   if(arrayGetterFromSplit[4] == "null"){
                       arrayGetterFromSplit[4] = 0.00D
                   }
                   if(arrayGetterFromSplit[5] == "null"){
                       arrayGetterFromSplit[5] = 0.00D
                   }
                   txnAcctListing.put('debitAmt',arrayGetterFromSplit[4])
                   txnAcctListing.put('creditAmt',arrayGetterFromSplit[5])
                   txnAcctListing.put('balance',arrayGetterFromSplit[6])
                   
                   jmdataHandler[jmcounterXcounter] = txnAcctListing
                   println("jmdataHandler: "+txnAcctListing)
                   jmcounterXcounter = jmcounterXcounter + 1
                }
                def xParms = xHashCode
                println("jmdataHandler: "+jmdataHandler)//clientdisplayName/clientCustomerId/acctdepositType/acctdepositStatus/acctdepositAcctNo
                [xParms:xParms,jmdataHandler:jmdataHandler,acctInformationValues:acctInformationValues]
                
            }else{
                
                [jmdataHandler:jmdataHandler,acctInformationValues:acctInformationValues]
            }
            //============================================
        }    
    }
    
    // Error Page Redirect
    def rdrLandingPage(){
        
    }
    
    def getActionFromExpressO(){
        println("=========== ICBS REQUEST LOCK / UNLOCK PARAMETERS ============")
        println("params: "+params)
        def requestResult = ""
        
        def webConfigUpdateLockStatus = WebConfig.findByParamCode("GEN.1002")
        if(params.lockValue == "lock"){
            webConfigUpdateLockStatus.paramValue = 'TRUE'
        }else{
            webConfigUpdateLockStatus.paramValue = 'FALSE'
        }
        webConfigUpdateLockStatus.save(flush: true,failOnError: true)
        
        def jsonObject = new JSONObject()
        jsonObject = jsonObject.put('response', "success")
        render jsonObject
        return jsonObject
    }
    def sendEmail() {
        println("===================== SEND EMAIL ===================")
        def json = request.JSON
        println 'sendEmail()'
        println params
        println("session.emailAddresss: "+session.emailAddresss)
        def emailAdd = json.address.toString()
        println("emailAdd: "+emailAdd)
        if(emailAdd == "" || emailAdd == null || emailAdd == "null"){
            println("pasok dito")
            emailAdd = session.emailAddresss
        }
        println("emailAdd: "+emailAdd)
        def emailSubjectContent = "MBP ONLINE BANKING CODE VERIFICATION"
        
        def regCode = passcodeMaker()
        
        def jsrequestAction = json.reqAction
        def emailMsgContent = ""
        if(jsrequestAction == "registration"){
            emailMsgContent = "<h3>Hello There! Your Registration Code is <strong style='color: #00b3b3'>"+regCode+"</strong> use this code to complete your registration process.</h3>"
        }else if(jsrequestAction == "linkAccount"){
            emailMsgContent = "<h3>Hello There! Your Link Account Verification Code is <strong style='color: #00b3b3'>"+regCode+"</strong> use this code to complete your Account Linking process.</h3>"
        }else{
            // posible txn
            emailMsgContent = "<h3>Hello There! Your Fund Transfer Verification Code is <strong style='color: #00b3b3'>"+regCode+"</strong> use this code to complete your Fund Transfer process.</h3>"
        }
        
        
        sendMail {
            to emailAdd
            subject emailSubjectContent
            html emailMsgContent
        }
        println("=========== VERIFIFY ACCOUNT SECTION =============")
        println("Email Sent to : "+emailAdd)
        println("Code : "+regCode)
        println("==================================================")
        def reponseWebPortal = []
        reponseWebPortal << [reponseCode:'xxxx', responsetexx:regCode]
        render reponseWebPortal as grails.converters.JSON
        
    }
    def passcodeMaker(){
        
        String genNewPassword = "";
        int len = 13;
         
        // A strong password has Cap_chars, Lower_chars, 
        // numeric value and symbols. So we are using all of 
        // them to generate our password 
        String Capital_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"; 
        String Small_chars = "abcdefghijklmnopqrstuvwxyz"; 
        String numbers = "0123456789"; 
        String values =  numbers + Capital_chars + numbers

        // Using random method 
        Random rndm_method = new Random(); 
        String password = ""

        for (int i = 0; i < len; i++){
            // Use of charAt() method : to get character value 
            // Use of nextInt() as it is scanning the value as int 
           password =  password + values.charAt(rndm_method.nextInt(values.length())); 
        } 
        genNewPassword = password;
        println("genNewPassword: "+genNewPassword)
        println("genNewPassword.length(): "+genNewPassword.length())
        genNewPassword = genNewPassword.substring(3,genNewPassword.length());
        return genNewPassword; 
	
    } 
    //logoutPage
    def logoutPage(){
        
    }
    //login validation
    def rdrValStat(){
        
    }
    def validateLinkAccount(){
        String defaultProcessMethod = "validateExistingLinkAccount"
        
        println("=========== REGISTRY PARAMS ===============")
        println("params: "+params)
        println("Action: "+defaultProcessMethod)
        println("===========================================")
        
        def json = request.JSON
        params.put("acctNo",json.acctNo)
        params.put("acctType",json.acctType)
        params.put("customerId",session.usersession)
        
        def responseFromICBS = poratalProcessParameters(defaultProcessMethod,params)
    
        StringTokenizer st = new StringTokenizer(responseFromICBS, "{}:\"");
        while(st.hasMoreTokens()) {
            resultValue = st.nextToken();
        }
        
        def informationResultValue = resultValue.split("@@<>");
        def reponseWebPortal = []
       
        println("responsetexx: "+resultValue)

        String resultFailedSuccess = informationResultValue[0].toString()
        println("resultFailedSuccess: "+resultFailedSuccess)
        println("informationResultValue[1]: "+informationResultValue[1])
        
        if(resultFailedSuccess == "success"){
            // encode clientId for security purposes
           
            resultValue = informationResultValue[1]
            reponseWebPortal << [reponseCode:'xxxx', responsetexx:resultValue,reponseResult:resultFailedSuccess]
        }else{
            resultValue = informationResultValue[1]
            reponseWebPortal << [reponseCode:'xxxx', responsetexx:resultValue,reponseResult:resultFailedSuccess]
        }
        
        render reponseWebPortal as grails.converters.JSON
    }
    def multiSender(){
        
    }
    def multisysTester(){
        URL url = null;
        String action = "";
        action = "Echo";
        String jmXSecurityCode = "";
        String jmXConnectionUrl = "";
        
        try {
            if("Echo".equals(action)){
                System.out.println("AAA");
                jmXConnectionUrl = 'http://localhost:8040/icbs/ATMInterfaceListener/receiveMultisysRequest'
                url = new URL(jmXConnectionUrl);
            }
            // required item to validate request
            String xref = params?.referenceNo
            params.put("referenceNo",xref)
            
            StringBuilder postData = new StringBuilder();
            
            for (Map.Entry<String,Object> param : params.entrySet()) {
                if (postData.length() != 0) postData.append('&');
                postData.append(URLEncoder.encode(param.getKey(), "UTF-8"));
                postData.append('=');
                postData.append(URLEncoder.encode(String.valueOf(param.getValue()), "UTF-8"));
            }
            
            byte[] postDataBytes = postData.toString().getBytes("UTF-8");
            HttpURLConnection conn = (HttpURLConnection)url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
            conn.setRequestProperty("Content-Length", String.valueOf(postDataBytes.length));
            
            conn.setDoOutput(true);
            conn.getOutputStream().write(postDataBytes);
            Reader insx = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));

            String output="";
            
            for (int c; (c = insx.read()) >= 0; output = output+(char)c);
            System.out.println("output :" + "<<"+output+">>");

            insx.close();

            output = output.replaceAll("\\n", "");
            output = output.replaceAll("\\r", ""); 
            output = output.replace("\\u0000", ""); 

            return output;
           
            
        } 
        catch (MalformedURLException e) { 
            //System.out.println(e);
            // new URL() failed
            
            // ...
        }  
    }
    def viewDeposit(){
        println("pumasok")
    }
    
    def refreshUserSession(String clientId){
        println("====================== refreshUserSession =========================")
        Date dateOne = new Date();
        String refDetails1One = ""+onlineBankingRefDate.format(dateOne).toString();
        refDetails1One = refDetails1One.replaceAll(" ", "").toLowerCase()
        println("refDetails: "+refDetails1One)
        
        refDetails1One = refDetails1One.replaceAll("-", "").toLowerCase()
        def regCode = passcodeMaker()
        def timeDetailss = refDetails1One.split(":");
        refDetails1One = timeDetailss[1] +''+timeDetailss[2]+''+timeDetailss[3]+''+timeDetailss[0]
        def timexs = timeDetailss[1] +''+timeDetailss[2]+''+timeDetailss[3]
        println("refDetails1One: "+refDetails1One)
        //refDetails = refDetails.replaceAll(":", "").toLowerCase()
        // encode clientId for security purposes
        //String combineEncapsulate = refDetails+"webXsecurity"+timexs+"MicroBankersPhilippines"+timexs+"WebBankingOnline@##%"+clientId.toString()
        String combineEncapsulate = regCode+timexs+""+timeDetailss[3]+"@##%"+clientId.toString()+"@##%"+regCode
        //firstEncode
        byte[] encodedBytes = Base64.encodeBase64(combineEncapsulate.getBytes());
        //secondEncode
        resultValue = new String(encodedBytes)

        byte[] encodedBytes2 = Base64.encodeBase64(resultValue.getBytes());
        resultValue = new String(encodedBytes2)

        println("NEW USERSESSION ENCODE: "+resultValue)
        return resultValue
    }
    
    
    
}


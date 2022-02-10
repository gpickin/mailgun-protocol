component extends="cbmailservices.models.AbstractProtocol" {

    property name="mailgun" inject="provider:Mailgun@mailguncfc";

    /**
    * Initialize the Mailgun protocol
    *
    * @properties A map of configuration properties for the protocol
    */
    public MailgunProtocol function init( struct properties = {} ) {
        variables.name = "Mailgun";
        super.init( argumentCollection = arguments );
        return this;
    }

    /**
    * Send a message via the Mailgun API
    *
    * @payload The payload to deliver
    */
    public function send( required cbmailservices.models.Mail payload ) {
        var rtnStruct   =   {error=true, errorArray=[]};
        var mail        =   payload.getMemento();
        var type        =   structKeyExists( mail, "type" ) ? mail.type : "plain";

        var text        =   "";
        var html        =   "";
        var tags        =   "";

        if( mail.type == "plain" ){
            text        =   mail.body;
        } else {
            html        =   mail.body;
        }

        if( structKeyExists( mail, "additionalInfo" ) && isStruct( mail.additionalInfo ) && structKeyExists( mail.additionalInfo, "categories" ) ){
            if ( ! isArray( mail.additionalInfo.categories ) ) {
                mail.additionalInfo.categories = listToArray( mail.additionalInfo.categories );
            }
            tags = mail.additionalInfo.categories;
        }
        
        var h_options = {};
        if(mail.keyExists('replyto')) h_options['Reply-To'] = mail.replyto;
        
        var sendResult = mailgun.sendMessage( 
            from        =   mail.from, 
            to          =   mail.to, 
            //cc          =   mail.cc,
            //bcc         =   mail.bcc,
            subject     =   mail.subject,
            text        =   text, 
            html        =   html, 
            //any attachment, 
            //any inline, 
            o = { 
                "tag"       =   tags,
                "tracking"  =   "yes",
                "tracking-clicks" = "yes",
                "tracking-opens"  = "yes"
            },
            h = h_options
            //struct v = { }, 
            //any recipient_variables 
        );
        
        // if ( left( cfhttp.status_code, 1 ) != "2" && left( cfhttp.status_code, 1 ) != "3"  ) {
        //     rtnStruct.errorArray = deserializeJSON( cfhttp.filecontent ).errors;
        // }
        // else {
        //     rtnStruct.error = false;
        // }

        return rtnStruct;
    }

}

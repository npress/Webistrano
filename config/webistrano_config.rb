# 
#  Example Webistarno configuration
#  
#  copy this file to config/webistrano.rb and edit
#
WebistranoConfig = {

  # secret password for session HMAC
  :session_secret => 'LET us go then, you and I,	
When the evening is spread out against the sky	
Like a patient etherised upon a table;	
Let us go, through certain half-deserted streets,	
The muttering retreats	      
Of restless nights in one-night cheap hotels	
And sawdust restaurants with oyster-shells:	
Streets that follow like a tedious argument	
Of insidious intent	
To lead you to an overwhelming question 	       
Oh, do not ask, What is it?	
Let us go and make our visit.',

  # Uncomment to use CAS authentication
  # :authentication_method => :cas,
  
  # SMTP settings for outgoing email
  :smtp_delivery_method => :sendmail,
  
  :smtp_settings => {
    :address  => "localhost",
    :port  => 25, 
    #:domain  => "exchange.zerolag.com",
    #:user_name  => "nema.press@sleepygiant.com",
    #:password  => "press@SGE",
    #:authentication  => :login
  },
  
  # Sender address for Webistrano emails
  :webistrano_sender_address => "sys_admins@sleepygiant.com",
  
  # Sender and recipient for Webistrano exceptions
  :exception_recipients => "sys_admins@sleepygiant.com",
  :exception_sender_address => "sys_admins@sleepygiant.com"

}

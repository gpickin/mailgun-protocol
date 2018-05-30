# Mailgun Protocol


## A [`cbmailservices`](https://github.com/ColdBox/cbox-mailservices) protocol for sending email via Mailgun

> In `cbmailservices` parlance, a `protocol` is a method of sending an email.  Protocols can be switched out based on environment settings making it easy to log a mail to a file in development, send it to an in-memory store for asserting against in tests, and sending to real services in production.

### Configuration

You can configure Mailgun as your protocol inside your `mailsettings` in your `config/ColdBox.cfc`.  It is recommended you store your API key outside version control in either server ENV settings or Java properties.  This approach also lets you easily swap out dev and production keys based on the environment.

```
mailsettings = {
	protocol = {
		class = "mailgunprotocol.models.protocols.mailgunProtocol",
		properties = {
		}
	}
};
```

#### Dependency 

Relies on the [`MailGunCFC Module`](https://www.forgebox.io/view/mailguncfc) by Matthew Clemente.

To use the wrapper as a ColdBox Module you will need to pass the configuration settings in from your config/Coldbox.cfc. This is done within the moduleSettings struct:

```moduleSettings = {
  mailguncfc = {
    secretApiKey  = 'key-xxx',
    publicApiKey  = 'pubkey-xxx',
    domain        = 'yourdomain.com'
  }
};
```

You can then leverage the CFC via the injection DSL: mailgun@mailguncfc:

``` 
property name="mailgun" inject="mailgun@mailguncfc";
```


### Emails

To send an email, set the `type` to `plain` or 'html':
```
var mail = mailService.newMail(
    to = user.getEmail(),
    subject = "Welcome to my site!",
    type = "html"
);
```

The body of the email is what will be sent. 
You can send plain text:

```
mail.setBody( "My plain text email here.  I can still use @placeholders@, of course." );
```

or you can send html

```
mail.setBody( "<p>My html email here.  I can still use @placeholders@, of course.</p>" );
```

### Categories

You can attach a list or array of tags for your email by setting them on the `additionalInfo.categories` field of the mail.
```
mail.setAdditionalInfoItem( "categories", "marketing" );
mail.setAdditionalInfoItem( "categories", "lists,of,categories" );
mail.setAdditionalInfoItem( "categories", [ "or", "as", "an", "array" ] );
```

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

### Plain Emails

To send a plain text email, set the `type` to `plain`:
```
var mail = mailService.newMail(
    to = user.getEmail(),
    subject = "Welcome to my site!",
    type = "template"
);
```

The body of the email is what will be sent.
```
mail.setBody( "My plain text email here.  I can still use @placeholders@, of course." );
```

### Categories

You can attach a list or array of tags for your email by setting them on the `additionalInfo.categories` field of the mail.
```
mail.setAdditionalInfoItem( "categories", "marketing" );
mail.setAdditionalInfoItem( "categories", "lists,of,categories" );
mail.setAdditionalInfoItem( "categories", [ "or", "as", "an", "array" ] );
```

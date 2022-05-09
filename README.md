# Mailgun Protocol


## A [`cbmailservices`](https://github.com/ColdBox/cbox-mailservices) protocol for sending email via Mailgun

> In `cbmailservices` parlance, a `protocol` is a method of sending an email.  Protocols can be switched out based on environment settings making it easy to log a mail to a file in development, send it to an in-memory store for asserting against in tests, and sending to real services in production.

### Configuration

You can configure Mailgun as your protocol inside the `moduleSettings` for `cbmailServices` located in your `config/ColdBox.cfc`.

```
moduleSettings = {
	cbmailServices = {
		defaultProtocol = "mailgun",
		mailers = {
			mailgun = {
				class = "mailgunprotocol.models.protocols.mailgunProtocol"
			}
		}
	}
};
```

#### Dependency

Relies on the [`MailGunCFC Module`](https://www.forgebox.io/view/mailguncfc) by Matthew Clemente.

To use the wrapper as a ColdBox Module you will need to pass the configuration settings in from your config/Coldbox.cfc. It is recommended you store your API key outside version control in either server ENV settings or Java properties.  This approach also lets you easily swap out dev and production keys based on the environment. This is done within the moduleSettings struct:

```
moduleSettings = {
	mailguncfc = {
		secretApiKey  = 'abc',
		publicApiKey  = 'pubkey-xxx',
		domain        = 'example.com'
	}
};
```

See the [cbMailService](https://coldbox-mailservices.ortusbooks.com/essentials/sending-mail) documentation for details on how to use the service to send email via Mailgun.

### Categories

You can attach a list or array of tags for your email by setting them on the `additionalInfo.categories` field of the mail.
```
mail.setAdditionalInfoItem( "categories", "marketing" );
mail.setAdditionalInfoItem( "categories", "lists,of,categories" );
mail.setAdditionalInfoItem( "categories", [ "or", "as", "an", "array" ] );
```

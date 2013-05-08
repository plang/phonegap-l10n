##phonegap-l10n##

*Tiny l10n localization library for Phonegap/Cordova applications. Can be used for localizing your application in a declarative way, or programmatically.*

###How to use it:###

Somewhere in your `onDeviceReady()` callback, initialize the library:

```javascript
Localization.initialize
(
    // Dictionnary
    { 
        fr: {
            oui: "Oui",
            non: "Non"
        },

        en: {
            oui: "Yes",
            non: "No"
        }

    },
    // Fallback language
    "fr"
);
```

In your HTML code, localize your strings declaratively, by assigning
a class "l10n-<dictionnary key>" to your elements:

```html
<span class="l10n-oui"></span>
```

You can also access the dictionnary programmatically:

```javascript
alert(Localization.for("oui"))
```

Language is determined by phonegap, by reading the language configured on the 
phone. In case the language is not available in the dictionnary, or if there is
any problem determining the language, the fallback language is used.
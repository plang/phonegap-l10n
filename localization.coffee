#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# phonegap-l10n
#
# Tiny l10n localization library for Phonegap/Cordova applications. Can be used for
# localizing your application in a declarative way, or programmatically.
#
# Written in Coffeescript, but also available in Javascript.
#
# Author: Philippe Lang [philippe.lang@attiksystem.ch]
# Version 1.0, 8th may 2013
# Dependencies: jquery
#-----------------------------------------------------------------------------------
# How to use it:
#
# Somewhere in your onDeviceReady() callback, initialize the library:
#
# Localization.initialize
# (
#     // Dictionnary
#     { 
#         fr: {
#             oui: "Oui",
#             non: "Non"
#         },

#         en: {
#             oui: "Yes",
#             non: "No"
#         }

#     },
#     // Fallback language
#     "fr"
# );
#
# In your HTML code, localize your strings declaratively, by assigning
# a class "l10n-<dictionnary key>" to your elements:
#
# <span class="l10n-oui"></span>
#
# You can also access the dictionnary programmatically:
#
# alert(Localization.for("oui"))
#
# Language is determined by phonegap, by reading the language configured on the 
# phone. In case the language is not available in the dictionnary, or if there is
# any problem determining the language, the fallback language is used.
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
class Localization

	#-------------------------------------------------------------------------------
	# Initialize
	#-------------------------------------------------------------------------------
	@initialize: (dictionnary, fallback_language) ->

		# Dictionnary is defined in the HTML file as an multilevel associative array.
		Localization.dictionnary = dictionnary

		# Fallback language is stored for further use.
		Localization.fallback_language = fallback_language

		# Calling Phonegap Localization API.
		navigator.globalization.getPreferredLanguage(
			Localization.get_preferred_language_callback, 
			Localization.get_preferred_language_error_callback
		)

	#-------------------------------------------------------------------------------
	# get_preferred_language_callback
	#-------------------------------------------------------------------------------
	@get_preferred_language_callback: (language) -> 

		# Phonegap was able to read the language configured on the phone, so we
		# store it for further use.
		Localization.language = language.value
		console.log("Phone language is " + Localization.language)

		# If language is supported, that's fine, ...
		if Localization.language of Localization.dictionnary
			console.log("It is supported.")
		#... otherwise we use the fallback language.
		else
			Localization.language = Localization.fallback_language
			console.log("It is unsupported, so we chose " + Localization.language + " instead.")

		# We apply the translations to the current HTML file.
		Localization.apply_to_current_html()

	#-------------------------------------------------------------------------------
	# get_preferred_language_error_callback
	#-------------------------------------------------------------------------------
	@get_preferred_language_error_callback: () -> 

		# Phonegap was not able to read the language configured on the phone, so we
		# use the fallback language.
		Localization.language = Localization.fallback_language
		console.log("There was a error determining the language, so we chose "  + Localization.language + ".")

		# We apply the translations to the current HTML file.
		Localization.apply_to_current_html()

	#-------------------------------------------------------------------------------
	# apply_to_current_html
	#-------------------------------------------------------------------------------
	@apply_to_current_html: () ->

		# Changing the content of all html elements with class "l10n-<key>" for
		# current language. Useful for doing localization in a declarative way.
		console.log("Localizing HTML file.")
		$(".l10n-" + key).html(value) for key, value of Localization.dictionnary[Localization.language]

	#-------------------------------------------------------------------------------
	# for
	#-------------------------------------------------------------------------------
	@for: (key) ->

		# Returns localized value for key passed as a parameter. Useful for doing
		# localization programmatically.
		return Localization.dictionnary[Localization.language][key]

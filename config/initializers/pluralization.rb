# This file and config/locales/plurals.rb are used to add custom pluralization support for Arabic
# as the custom paths (two, few, many) are not supported by default.
require 'i18n/backend/pluralization'

I18n::Backend::Simple.include I18n::Backend::Pluralization

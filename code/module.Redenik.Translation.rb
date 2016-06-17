module Redenik::Translation
	def load_locale(localename)
		_check_locale
	end

	def current_locale
		_check_locale
		@current_locale
	end

	private

	def _check_locale
		@current_locale = "ru-RU" if @current_locale.nil?
	end
end
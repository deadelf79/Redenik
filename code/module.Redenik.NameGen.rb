# encoding utf-8

module Redenik::NameGen
	class << self
		attr :vowels, :consonants, :couples, :result
		VOWELS_RU = ["а","у","е","и","э"]
		CONSONANTS_RU = ["б","в","г","д","ж","з","к","л","м","н","п","р","с","т","ч","ш"]
	  	BANNED_CONSONANT_COUPLES_RU = ["бв","бг","бд","бж","бп","бч",
	                              "вб","вг","гб","гк","гп","гс","гт","гч","гш",
	                              "дб","дк","дп","дс","дт","дч","дш",
	                              "жб","жг","жз","жк","жп","жс","жт","жч","жш",
	                              "зб","зд","зж","зк","зп","зс","зт","зч","зш",
	                              "кб","кг","кд","кж","км","кп","кч","кш",
	                              "лж","лз","лм","лн","лп","лр","лс","лч","лш",
	                              "нб","нв","нж","нз","пб","пж","пз","пг","пд",
	                              "рб","рг","рд","рз","рл","рм","рн","рп","рт",
	                              "сб","сг","сд","сж","сз","сч","сш",
	                              "тб","тд","тж","тз","тл","тм",
	                              "чб","чг","чд","чж","чз","чл","чс","чш",
	                              "шб","шг","шд","шж","шз","шл","шс","шч"]
		def self.prepare
			@vowels = VOWELS_RU
			@consonants = CONSONANTS_RU
			@couples = []
			@con_couples = []
			@result = ""
			@consonants.each{|bp|
				@vowels.each {|ap|
					@couples+=[bp+ap]
				}
				@consonants.each{|bbp|
					@con_couples+=[bp+bbp] if not bp==bbp
				}
			}
			_clear_banned_couples
		end

		def self.make_name(min,max)
			(count=4)
			@result = ""
			for index in 0...count
				if index < count-1
					if rand(10)==0
						@result += @con_couples.sample
						@result += @vowels.sample
					else
						@result += @couples.sample
					end
				else
					@result += @consonants.sample
				end
			end
			@result[0]=@result[0].upcase
			@result
		end

		def self.make_info(type)

		end

		private

		def _clear_banned_couples
			@con_couples -= BANNED_CONSONANT_COUPLES_RU
		end
	end
end

class String
	alias old_upcase upcase
	def upcase
		if self.ascii_only?
			old_upcase
		else
			newstring=self.clone
			newcase=[]
			('А'..'Я').each{ |item|
				newcase+= [ item ]
			}
			index=0
			('а'..'я').each{ |item|
				newstring.gsub!(item) {newcase[ index ]}
				index+=1
			}
			self.gsub!('ё') { 'Ё' }
			return newstring
		end
	end
 
	alias old_upcase! upcase!
	def upcase!
		if self.ascii_only?
			old_upcase!
		else
			newcase=[]
			('А'..'Я').each{ |item|
				newcase+= [ item ]
			}
			index=0
			('а'..'я').each{ |item|
				self.gsub!(item) {newcase[ index ]}
				index+=1
			}
			self.gsub!('ё') { 'Ё' }
			return self
		end
	end
 
	# Заменяет прописные буквы строчными
	alias old_downcase downcase
	def downcase
		if self.ascii_only?
			old_downcase
		else
			newstring=self.clone
			newcase=[]
			('а'..'я').each{ |item|
				newcase+= [ item ]
			}
			index=0
			('А'..'Я').each{ |item|
				newstring.gsub!(item) {newcase[ index ]}
				index+=1
			}
			self.gsub!('Ё') { 'ё' }
			return newstring
		end
	end
 
	alias old_downcase! downcase!
	def downcase!
		if self.ascii_only?
			old_downcase!
		else
			newcase=[]
			('а'..'я').each{ |item|
				newcase+= [ item ]
			}
			index=0
			('А'..'Я').each{ |item|
				self.gsub!(item) {newcase[ index ]}
				index+=1
			}
			self.gsub!('Ё') { 'ё' }
			return self
		end
	end
end
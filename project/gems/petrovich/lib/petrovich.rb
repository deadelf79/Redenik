# encoding: utf-8
require 'petrovich/unicode'
require 'petrovich/rules'
require 'petrovich/extension'

# Склонение падежей русских имён фамилий и отчеств. Вы задаёте начальное имя в именительном падеже,
# а получаете в нужном вам.
#
# Использование
#
#   # Склонение в дательном падеже
#   rn = Petrovich.new
#   puts rn.firstname('Иван', :dative)       # => Ивану
#   puts rn.middlename('Сергеевич', :dative) # => Сергеевичу
#   puts rn.lastname('Воронов', :dative)     # => Воронову
#
#
# Если известен пол, то его можно передать в конструктор. Это повышает точность склонений
#
#   rn = Petrovich.new('male')
#
# Если пол не известен, его можно определить по отчеству, при помощи метода +detect_gender+
#
#   gender = Petrovich.detect_gender('Сергеевич')
#   rn = Petrovich.new(gender)
#
# Возможные падежи
#
# * +:nominative+ - именительный
# * +:genitive+ - родительный
# * +:dative+ - дательный
# * +:accusative+ - винительный
# * +:instrumental+ - творительный
# * +:prepositional+ - предложный
#
class Petrovich
  CASES = [:nominative, :genitive, :dative, :accusative, :instrumental, :prepositional]

  NOMINATIVE      = :nominative    # именительный
  GENITIVE        = :genitive      # родительный
  DATIVE          = :dative        # дательный
  ACCUSATIVE      = :accusative    # винительный
  INSTRUMENTAL    = :instrumental  # творительный
  PREPOSITIONAL   = :prepositional # предложный

  def initialize(gender = nil)
    @gender = gender.to_s
  end

  def lastname(name, gcase, scase = :nominative)
    Rules.new(@gender).lastname(name, gcase, scase)
  end

  def firstname(name, gcase, scase = :nominative)
    Rules.new(@gender).firstname(name, gcase, scase)
  end

  def middlename(name, gcase, scase = :nominative)
    Rules.new(@gender).middlename(name, gcase, scase)
  end

  alias :patronymic :middlename

  def gender
    @gender
  end

  class << self
    include Petrovich::Unicode

    # Определение пола по отчеству
    #
    #   detect_gender('Алексеевич') # => male
    #
    # Если пол не был определён, метод возвращает значение +androgynous+
    #
    #   detect_gender('блаблабла') # => androgynous
    #
    def detect_gender(midname)
      case downcase(midname[-2, 2])
        when /ич|ыч/
          'male'
        when 'на'
          'female'
        else
          'androgynous'
      end
    end
  end
end

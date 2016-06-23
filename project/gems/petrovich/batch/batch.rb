# encoding: utf-8
class Petrovich
  module Unicode
    RU_UPPER = [
      "\u0410", "\u0411", "\u0412", "\u0413", "\u0414", "\u0415", "\u0416", "\u0417",
      "\u0418", "\u0419", "\u041A", "\u041B", "\u041C", "\u041D", "\u041E", "\u041F",
      "\u0420", "\u0421", "\u0422", "\u0423", "\u0424", "\u0425", "\u0426", "\u0427",
      "\u0428", "\u0429", "\u042A", "\u042B", "\u042C", "\u042D", "\u042E", "\u042F",
      "\u0401" # Ё
    ].join

    RU_LOWER = [
      "\u0430", "\u0431", "\u0432", "\u0433", "\u0434", "\u0435", "\u0436", "\u0437",
      "\u0438", "\u0439", "\u043A", "\u043B", "\u043C", "\u043D", "\u043E", "\u043F",
      "\u0440", "\u0441", "\u0442", "\u0443", "\u0444", "\u0445", "\u0446", "\u0447",
      "\u0448", "\u0449", "\u044A", "\u044B", "\u044C", "\u044D", "\u044E", "\u044F",
      "\u0451" # Ё
    ].join

    def downcase(entry)
      entry.to_s.tr(RU_UPPER, RU_LOWER)
    end

    def upcase(entry)
      entry.to_s.tr(RU_LOWER, RU_UPPER)
    end
  end
end


# encoding: utf-8

class Petrovich
  # Загрузка правил происходит один раз
  RULES = { "lastname" => {
    "exceptions" => [
      {
        "gender"=>"androgynous",
        "test"=>["бонч", "абдул", "белиц", "гасан", "дюссар", "дюмон", "книппер", "корвин", "ван", "шолом", "тер", "призван", "мелик", "вар", "фон"],
        "mods"=>[".", ".", ".", ".", "."],
        "tags"=>["first_word"]
      },
      {
        "gender" => "androgynous",
        "test"=>["дюма", "тома", "дега", "люка", "ферма", "гамарра", "петипа", "шандра", "скаля", "каруана"],
        "mods"=>[".", ".", ".", ".", "."]
      },
      {
        "gender"=>"androgynous",
        "test"=>["гусь", "ремень", "камень", "онук", "богода", "нечипас", "долгопалец", "маненок", "рева", "кива"],
        "mods"=>[".", ".", ".", ".", "."]
      },
      {
        "gender"=>"androgynous",
        "test"=>["вий", "сой", "цой", "хой"],
        "mods"=>["-я", "-ю", "-я", "-ем", "-е"]
      },
      {
        "gender"=>"androgynous",
        "test"=>["я"],
        "mods"=>[".", ".", ".", ".", "."]
      }
    ],
    "suffixes"=>[
      {
        "gender"=>"female",
        "test"=>["б", "в", "г", "д", "ж", "з", "й", "к", "л", "м", "н", "п", "р", "с", "т", "ф", "х", "ц", "ч", "ш", "щ", "ъ", "ь"],
        "mods"=>[".", ".", ".", ".", "."]
      },
      {
        "gender"=>"androgynous",
        "test"=>["гава", "орота"],
        "mods"=>[".", ".", ".", ".", "."]
      },
      {
        "gender"=>"female",
        "test"=>["ска", "цка"],
        "mods"=>["-ой", "-ой", "-ую", "-ой", "-ой"]
      },
      {
        "gender"=>"female",
        "test"=>["цкая", "ская", "ная", "ая"],
        "mods"=>["--ой", "--ой", "--ую", "--ой", "--ой"]
      },
      {
        "gender"=>"female",
        "test"=>["яя"],
        "mods"=>["--ей", "--ей", "--юю", "--ей", "--ей"]
      },
      {
        "gender"=>"female",
        "test"=>["на"],
        "mods"=>["-ой", "-ой", "-у", "-ой", "-ой"]
      },
      {
        "gender"=>"male",
        "test"=>["иной"],
        "mods"=>["-я", "-ю", "-я", "-ем", "-е"]
      },
      {
        "gender"=>"male",
        "test"=>["уй"],
        "mods"=>["-я", "-ю", "-я", "-ем", "-е"]
      },
      {
        "gender"=>"androgynous",
        "test"=>["ца"],
        "mods"=>["-ы", "-е", "-у", "-ей", "-е"]
      },
      {
        "gender"=>"male",
        "test"=>["рих"],
        "mods"=>["а", "у", "а", "ом", "е"]
      },
      {
        "gender"=>"androgynous",
        "test"=>["ия"],
        "mods"=>[".", ".", ".", ".", "."]
      },
      {
        "gender"=>"androgynous",
        "test"=>["иа", "аа", "оа", "уа", "ыа", "еа", "юа", "эа"],
        "mods"=>[".", ".", ".", ".", "."]
      },
      {
        "gender"=>"male",
        "test"=>["их", "ых"],
        "mods"=>[".", ".", ".", ".", "."]
      },
      {
        "gender"=>"androgynous",
        "test"=>["о", "е", "э", "и", "ы", "у", "ю"],
        "mods"=>[".", ".", ".", ".", "."]
      },
      {
        "gender"=>"female",
        "test"=>["ова", "ева"],
        "mods"=>["-ой", "-ой", "-у", "-ой", "-ой"]
      },
      {
        "gender"=>"androgynous",
        "test"=>["га", "ка", "ха", "ча", "ща", "жа", "ша"],
        "mods"=>["-и", "-е", "-у", "-ой", "-е"]
      },
      {
        "gender"=>"androgynous",
        "test"=>["а"],
        "mods"=>["-ы", "-е", "-у", "-ой", "-е"]
      },
      {
        "gender"=>"male",
        "test"=>["ь"],
        "mods"=>["-я", "-ю", "-я", "-ем", "-е"]
      },
      {
        "gender"=>"androgynous",
        "test"=>["ия"],
        "mods"=>["-и", "-и", "-ю", "-ей", "-и"]
      },
      {
        "gender"=>"androgynous",
        "test"=>["я"],
        "mods"=>["-и", "-е", "-ю", "-ей", "-е"]
      },
      {
        "gender"=>"male",
        "test"=>["ей"],
        "mods"=>["-я", "-ю", "-я", "-ем", "-е"]
      },
      {
        "gender"=>"male",
        "test"=>["ян", "ан", "йн"],
        "mods"=>["а", "у", "а", "ом", "е"]
      },
      {
        "gender"=>"male",
        "test"=>["ынец", "обец"],
        "mods"=>["--ца", "--цу", "--ца", "--цем", "--це"]
      },
      {
        "gender"=>"male",
        "test"=>["онец", "овец"],
        "mods"=>["--ца", "--цу", "--ца", "--цом", "--це"]
      },
      {
        "gender"=>"male",
        "test"=>["ай"],
        "mods"=>["-я", "-ю", "-я", "-ем", "-е"]
      },
      {
        "gender"=>"male",
        "test"=>["кой"],
        "mods"=>["-го", "-му", "-го", "--им", "-м"]
      },
      {
        "gender"=>"male",
        "test"=>["гой"],
        "mods"=>["-го", "-му", "-го", "--им", "-м"]
      },
      {
        "gender"=>"male", "test"=>["ой"],
        "mods"=>["-го", "-му", "-го", "--ым", "-м"]
      },
      {
        "gender"=>"male",
        "test"=>["ах", "ив"],
        "mods"=>["а", "у", "а", "ом", "е"]
      },
      {
        "gender"=>"male",
        "test"=>["ший", "щий", "жий", "ний"],
        "mods"=>["--его", "--ему", "--его", "-м", "--ем"]
      },
      {
        "gender"=>"male",
        "test"=>["ый"],
        "mods"=>["--ого", "--ому", "--ого", "-м", "--ом"]
      },
      {
        "gender"=>"male",
        "test"=>["кий"],
        "mods"=>["--ого", "--ому", "--ого", "-м", "--ом"]
      },
      {
        "gender"=>"male",
        "test"=>["ий"],
        "mods"=>["-я", "-ю", "-я", "-ем", "-и"]
      },
      {
        "gender"=>"male",
        "test"=>["ок"],
        "mods"=>["--ка", "--ку", "--ка", "--ком", "--ке"]
      },
      {
        "gender"=>"male",
        "test"=>["ец"],
        "mods"=>["--ца", "--цу", "--ца", "--цом", "--це"]
      },
      {
        "gender"=>"male",
        "test"=>["ц", "ч", "ш", "щ"],
        "mods"=>["а", "у", "а", "ем", "е"]
      },
      {
        "gender"=>"male",
        "test"=>["ен", "нн", "он", "ун"],
        "mods"=>["а", "у", "а", "ом", "е"]
      },
      {
        "gender"=>"male",
        "test"=>["в", "н"],
        "mods"=>["а", "у", "а", "ым", "е"]
      },
      {
        "gender"=>"male",
        "test"=>["б", "г", "д", "ж", "з", "к", "л", "м", "п", "р", "с", "т", "ф", "х"],
        "mods"=>["а", "у", "а", "ом", "е"]
      }
    ]}, "firstname" => { "exceptions" => [
      {
        "gender"=>"male",
        "test"=>["лев"],
        "mods"=>["--ьва", "--ьву", "--ьва", "--ьвом", "--ьве"]
      },
      {
        "gender"=>"male",
        "test"=>["пётр"],
        "mods"=>["---етра", "---етру", "---етра", "---етром", "---етре"]
      },
      {
        "gender"=>"male",
        "test"=>["павел"],
        "mods"=>["--ла", "--лу", "--ла", "--лом", "--ле"]
      },
      {
        "gender"=>"male",
        "test"=>["яша"],
        "mods"=>["-и", "-е", "-у", "-ей", "-е"]
      },
      {
        "gender"=>"male",
        "test"=>["шота"],
        "mods"=>[".", ".", ".", ".", "."]
      },
      {
        "gender"=>"female",
        "test"=>["рашель", "нинель", "николь", "габриэль", "даниэль"],
        "mods"=>[".", ".", ".", ".", "."]
      }
    ], "suffixes" => [
      {
        "gender"=>"androgynous",
        "test"=>["е", "ё", "и", "о", "у", "ы", "э", "ю"],
        "mods"=>[".", ".", ".", ".", "."]
      },
      {
        "gender"=>"female",
        "test"=>["б", "в", "г", "д", "ж", "з", "й", "к", "л", "м", "н", "п", "р", "с", "т", "ф", "х", "ц", "ч", "ш", "щ", "ъ"],
        "mods"=>[".", ".", ".", ".", "."]
      },
      {
        "gender"=>"female",
        "test"=>["ь"],
        "mods"=>["-и", "-и", ".", "ю", "-и"]
      },
      {
        "gender"=>"male",
        "test"=>["ь"],
        "mods"=>["-я", "-ю", "-я", "-ем", "-е"]
      },
      {
        "gender"=>"androgynous",
        "test"=>["га", "ка", "ха", "ча", "ща", "жа"],
        "mods"=>["-и", "-е", "-у", "-ой", "-е"]
      },
      {
        "gender"=>"female",
        "test"=>["ша"],
        "mods"=>["-и", "-е", "-у", "-ей", "-е"]
      },
      {
        "gender"=>"androgynous",
        "test"=>["а"],
        "mods"=>["-ы", "-е", "-у", "-ой", "-е"]
      },
      {
        "gender"=>"female",
        "test"=>["ия"],
        "mods"=>["-и", "-и", "-ю", "-ей", "-и"]
      },
      {
        "gender"=>"female",
        "test"=>["а"],
        "mods"=>["-ы", "-е", "-у", "-ой", "-е"]
      },
      {
        "gender"=>"female",
        "test"=>["я"],
        "mods"=>["-и", "-е", "-ю", "-ей", "-е"]
      },
      {
        "gender"=>"male",
        "test"=>["ия"],
        "mods"=>["-и", "-и", "-ю", "-ей", "-и"]
      },
      {
        "gender"=>"male",
        "test"=>["я"],
        "mods"=>["-и", "-е", "-ю", "-ей", "-е"]
      },
      {
        "gender"=>"male",
        "test"=>["ей"],
        "mods"=>["-я", "-ю", "-я", "-ем", "-е"]
      },
      {
        "gender"=>"male",
        "test"=>["ий"],
        "mods"=>["-я", "-ю", "-я", "-ем", "-и"]
      },
      {
        "gender"=>"male",
        "test"=>["й"],
        "mods"=>["-я", "-ю", "-я", "-ем", "-е"]
      },
      {
        "gender"=>"male",
        "test"=>["б", "в", "г", "д", "ж", "з", "к", "л", "м", "н", "п", "р", "с", "т", "ф", "х", "ц", "ч"],
        "mods"=>["а", "у", "а", "ом", "е"]
      },
      {
        "gender"=>"androgynous",
        "test"=>["ния", "рия", "вия"],
        "mods"=>["-и", "-и", "-ю", "-ем", "-ем"]
      }
    ]}, "middlename"=> { "suffixes"=> [
      {
        "gender"=>"male",
        "test"=>["ич"],
        "mods"=>["а", "у", "а", "ем", "е"]
      },
      {
        "gender"=>"female",
        "test"=>["на"],
        "mods"=>["-ы", "-е", "-у", "-ой", "-е"]
      }
    ]
  }}

  class UnknownCaseException < Exception;;end
  class UnknownRuleException < Exception;;end
  class CantApplyRuleException < Exception;;end

  # Набор методов для нахождения и применения правил к имени, фамилии и отчеству.
  class Rules
    include Petrovich::Unicode

    attr_reader :gender

    Matchers = [
      proc {| x, y, i | y[ 0 ].size <=> x[ 0 ].size },
      proc {| x, y, i | x[ 1 ][ 'gender' ] != i.gender &&  1 ||
                        y[ 1 ][ 'gender' ] != i.gender && -1 || 0 },
      proc {| x, y, i | y[ 1 ][ 'test' ][ 0 ].size <=>
                        x[ 1 ][ 'test' ][ 0 ].size },
      proc {| x, y, i | x[ 1 ][ 'test' ][ 0 ] <=> y[ 1 ][ 'test' ][ 0 ] } ]

    def initialize(gender = nil)
      @gender = gender
    end

    # Определяет методы +lastname_<i>case</i>+, +firstname_<i>case</i>+ и +middlename_<i>case</i>+
    # для получения имени, фамилии и отчества в нужном падеже.
    #
    # Использование:
    #
    #   # Дательный падеж
    #   lastname_dative('Комаров') # => Комарову
    #
    #   # Винительный падеж
    #   lastname_accusative('Комаров') # => Комарова
    #
    [:lastname, :firstname, :middlename].each do |method_name|
      define_method(method_name) do |name, gcase, scase|
        inflect(name, gcase, scase, Petrovich::RULES[method_name.to_s])
      end
    end

  protected
    # Известно несколько типов признаков, которые влияют на процесс поиска.
    #
    # Признак +first_word+ указывает, что данное слово является первым словом
    # в составном слове. Например, в двойной русской фамилии Иванов-Сидоров.
    #
    def match?(name, gcase, scase, rule, match_whole_word, tags)
      return false unless tags_allow? tags, rule['tags']
      return false if rule['gender'] == 'male' && female? ||
                      rule['gender'] == 'female' && !female?

      rule['test'].each do |chars|
        begin
          chars = apply(chars, rule, scase, gcase) if scase != NOMINATIVE
        rescue CantApplyRuleException
          next
        end

        test = match_whole_word ? name : name.slice([name.size - chars.size, 0].max .. -1)
        return chars if test == chars
      end

      false
    end

    def male?
      @gender == 'male'
    end

    def female?
      @gender == 'female'
    end

    def inflect(name, gcase, scase, rules)
      i = 0

      parts = name.split('-')

      parts.map! do |part|
        first_word = (i += 1) == 1 && parts.size > 1
        find_and_apply(part, gcase, scase, rules, first_word: first_word)
      end

      parts.join('-')
    end

    # Применить правило
    def apply(name, rule, gcase, scase)
      mod = modificator_from(scase, rule) + modificator_for(gcase, rule)
      skip = 0
      mod.each_char do |char|
        case char
          when '.'
          when '-'
            raise CantApplyRuleException if name.empty?
            name = name.slice(0, name.size - 1)
          else
            name += char
        end
      end

      name
    end

    # Найти правило и применить к имени с учетом склонения
    def find_and_apply(name, gcase, scase, rules, features = {})
      rule = find_for(name, gcase, scase, rules, features)
      apply(name, rule, gcase, scase)
    rescue UnknownRuleException, CantApplyRuleException
      # Если не найдено правило для имени, или случилась ошибка применения
      # правила, возвращаем неизмененное имя.
      name
    end

    # Найти подходящее правило в исключениях или суффиксах
    def find_for(name, gcase, scase, rules, features = {})
      tags = extract_tags(features)

      # Сначала пытаемся найти исключения
      if rules.has_key?('exceptions')
        p = find(name, gcase, scase, rules['exceptions'], true, tags)
        return p if p
      end

      # Не получилось, ищем в суффиксах. Если не получилось найти и в них,
      # возвращаем неизмененное имя.
      find(name, gcase, scase, rules['suffixes'], false, tags) ||
      raise( UnknownRuleException, "Cannot find rule for #{name}" )
    end

    # Найти подходящее правило в конкретном списке правил
    def find(name, gcase, scase, rules, match_whole_word, tags)
      name = downcase(name)
      first =
      rules.map do| rule |
        score = match?(name, gcase, scase, rule, match_whole_word, tags)
        score && [ score, rule ] || nil
      end.compact.sort do| x, y |
        Matchers.reduce( 0 ) do| c, m |
          c = m.call( x, y, self )
          break c if c != 0
        end
      end.first

      first && first[ 1 ]
    end

    # Получить модификатор из указанного правиля для указанного склонения
    def modificator_for(gcase, rule)
      case gcase.to_sym
        when NOMINATIVE
          '.'
        when GENITIVE
          rule['mods'][0]
        when DATIVE
          rule['mods'][1]
        when ACCUSATIVE
          rule['mods'][2]
        when INSTRUMENTAL
          rule['mods'][3]
        when PREPOSITIONAL
          rule['mods'][4]
        else
          raise UnknownCaseException, "Unknown grammatic case: #{gcase}"
      end
    end

    # Получить модификатор из указанного правила для преобразования
    # из указанного склонения
    def modificator_from(scase, rule)
      return '.' if scase.to_sym == NOMINATIVE

      # TODO т.к. именительный падеж не может быть восстановлен
      # в некоторых случаях верно, используется первый попавшийся вариант
      # видимо нужно менять формат таблицы, или развязывать варианты,
      # находящиеся в поле test
      base = rule['test'][0].unpack('U*')
      mod = modificator_for(scase, rule).unpack('U*')
      mod.map do | char |
        case char
        when 46 # '.'
          46
        when 45 # '-'
          base.pop
        else
          45
        end
      end.reverse.pack('U*')
    end

    # Преобразование +{a: true, b: false, c: true}+ в +%w(a c)+.
    def extract_tags(features = {})
      features.keys.select { |k| features[k] == true }.map(&:to_s)
    end

    # Правило не подходит только в том случае, если оно содержит больше
    # тегов, чем требуется для данного слова.
    #
    def tags_allow?(tags, rule_tags)
      rule_tags ||= []
      (rule_tags - tags).empty?
    end
  end
end


# encoding: utf-8

class Petrovich
  # Этот модуль разработан для возможности его подмешивания в класс Ruby.
  # Его можно подмешать в любой класс, например, в модель ActiveRecord.
  #
  # При помощи вызова метода +petrovich+ вы указываете, какие аттрибуты или методы класса
  # будут возвращать фамилию, имя и отчество.
  #
  # Опции:
  #
  # [:+firstname+]
  #   Указывает метод, возвращающий имя
  #
  # [:+middlename+]
  #   Указывает метод, возвращающий отчество
  #
  # [:+lastname+]
  #   Указывает метод, возвращающий фамилию
  #
  # [:+gender+]
  #   Указывает метод, возвращающий пол. Если пол не был указан, используется автоматическое определение
  #   пола на основе отчества. Если отчество также не было указано, пытаемся определить правильное склонение
  #   на основе файла правил.
  #
  # Пример использования
  #
  #   class User
  #     include Petrovich::Extension
  #
  #     petrovich :firstname  => :my_firstname,
  #               :middlename => :my_middlename,
  #               :lastname   => :my_lastname,
  #               :gender     => :my_gender
  #
  #     def my_firstname
  #       'Пётр'
  #     end
  #
  #     def my_middlename
  #       'Александрович'
  #     end
  #
  #     def my_lastname
  #       'Ларин'
  #     end
  #
  #     def my_gender
  #       :male # :male, :female или :androgynous
  #     end
  #
  #   end
  #
  # Вы получите следующие методы
  #
  #   user = User.new
  #   user.my_lastname_dative   # => Ларину
  #   user.my_firstname_dative  # => Петру
  #   user.my_middlename_dative # => Александровичу
  #
  # Вышеперечисленные методы доступны и внутри класса User.
  #
  module Extension
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def petrovich_configuration
        @petrovich_configuration ||= {
          :lastname   => nil,
          :firstname  => nil,
          :middlename => nil,
          :gender     => nil
        }
      end

      def petrovich(options)
        self.petrovich_configuration.update(options)
      end

      def inherited(subclass)
        subclass.petrovich_configuration.update(self.petrovich_configuration)
        super
      end
    end

    def petrovich_create_getter(method_name, attribute, gcase)
      options    = self.class.petrovich_configuration
      reflection = options.key(attribute.to_sym) or
        raise "No reflection for attribute '#{attribute}'!"

      self.class.send(:define_method, method_name) do
        # detect by gender attr if defined
        gender = options[:gender] && send(options[:gender])
        # detect by middlename attr if defined
        gender ||= begin
          middlename = options[:middlename] && send(options[:middlename])
          middlename && Petrovich.detect_gender(middlename)
        end

        rn = Petrovich.new gender
        rn.send reflection, send(attribute), gcase
      end
    end

    def method_missing(method_name, *args, &block)
      if match = method_name.to_s.match(petrovich_method_regex)
        attribute = match[1]
        gcase     = match[2]

        petrovich_create_getter(method_name, attribute, gcase)

        if respond_to_without_petrovich?(method_name)
          send method_name
        else
          super
        end
      else
        super
      end
    end

    alias :respond_to_without_petrovich? :respond_to?

    def respond_to?(method_name, include_private = false)
      if match = method_name.to_s.match(petrovich_method_regex)
        true
      else
        super
      end
    end

    def petrovich_method_regex
      %r{(.+)_(#{Petrovich::CASES.join('|')})$}
    end

    protected :petrovich_method_regex
  end
end

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

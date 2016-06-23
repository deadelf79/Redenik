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

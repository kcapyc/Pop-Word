# подсчитать количество совпадений слов в файле и сохранить в новый файл

require 'active_support/core_ext/string/multibyte'

if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

f = File.open 'file.txt', 'r:windows-1251' # или UTF-8

@hh = {}

def add_to_hash word
  if !word.empty?
    word = word.mb_chars.downcase.to_s

    cnt = @hh[word].to_i
    cnt += 1 # если нет значения
    @hh[word] = cnt
  end
end

f.each_line do |line|
  arr = line.split(/\s|\n|\.|,/)
  arr.each { |word| add_to_hash(word) }
end

f.close
f2 = File.new 'popword.txt', 'w:windows-1251'

@hh.sort_by{|k,v| v}.reverse.each do |k, v|
  f2.write "#{v}: #{k} \n"
end

f2.close

#!/usr/bin/env ruby

# file: kjdotxml.rb

require 'rexle'
require 'abbrev'
require 'novowels'


BOOKS = [
  "Genesis",                                        
  "Exodus",                                         
  "Leviticus",                                      
  "Numbers",                                        
  "Deuteronomy",                                    
  "Joshua",                                         
  "Judges",                                         
  "Ruth",                                           
  "1 Samuel",                                       
  "2 Samuel",                                       
  "1 Kings",                                        
  "2 Kings",                                        
  "1 Chronicles",                                   
  "2 Chronicles",                                   
  "Ezra",
  "Nehemiah",
  "Esther",
  "Job",
  "Psalms",
  "Proverbs",
  "Ecclesiastes",
  "Song of Solomon",
  "Isaiah",
  "Jeremiah",
  "Lamentations",
  "Ezekiel",
  "Daniel",
  "Hosea",
  "Joel",
  "Amos",
  "Obadiah",
  "Jonah",
  "Micah",
  "Nahum",
  "Habakkuk",
  "Zephaniah",
  "Haggai",
  "Zechariah",
  "Malachi",
  "Matthew",
  "Mark",
  "Luke",
  "John",
  "Acts",
  "Romans",
  "1 Corinthians",
  "2 Corinthians",
  "Galatians",
  "Ephesians",
  "Philippians",
  "Colossians",
  "1 Thessalonians",
  "2 Thessalonians",
  "1 Timothy",
  "2 Timothy",
  "Titus",
  "Philemon",
  "Hebrews",
  "James",
  "1 Peter",
  "2 Peter",
  "1 John",
  "2 John",
  "3 John",
  "Jude",
  "Revelation"
] 

class KjDotXmlError < Exception
end

class KjDotXml
  
  attr_reader :booklist

  def initialize(title=nil, debug: false)
    
    @debug = debug
    
    book(title) if title
    @booklist = BOOKS
    
  end
  
  def book(s)
        
    filename = s.downcase.gsub(/\s/,'-') + '.xml'
    filepath = File.join(File.dirname(__FILE__), '..', 'xml', filename)
    
    if File.exists? filepath then
      
      contents = File.read(filepath)
      @doc = Rexle.new(contents)
      
    else
      raise KjDotXmlError, 'book not found'
    end
    
  end
  
  def books(ref=nil)           
    
    return @booklist.map {|x| books(x) } unless ref

    index = ref.to_s[/^\d+$/] ? (ref.to_i - 1) : find_book(ref.downcase)
    puts 'index: ' + index.inspect if @debug
    
    title = @booklist[index]


  end

  def verses(s)

    r = s.match(/(?<book>\w+)\s+(?<chapter>\d+)[,\:]?\s*(?<verses>.*)/)
    verses2 = r[:verses] =~ /(?:\.\.|,|-)/ ? Range.new(*r[:verses]\
                        .split(/(?:\.\.|,|-)/).map(&:to_i)).to_a : r[:verses]
    puts 'r[:book]: ' + r[:book].inspect if @debug
    
    doc = book(books(r[:book]))
    
    puts 'verses2: ' + verses2.inspect if @debug
    
    if verses2.is_a? String then
      
      [
        doc.root.element("chapter[@no='#{r[:chapter]}']/verse" + 
                         "[@no='#{verses2}']")
      ]
      
    elsif verses2.is_a? Array
      
      verses2.map do |verse|
        doc.root.element("chapter[@no='#{r[:chapter]}']/verse[@no='#{verse}']")
      end
      
    end
  end  
 

  def to_doc()
    @doc
  end
  
    private

    def find_book(ref)

      puts 'find_book/ref: ' + ref.inspect if @debug
      
      h = @booklist.inject({}) do |r,rawx|

        x = rawx.downcase
        a3 = [
          x,
          x.sub(/(\d)\s/,'\1'),
          x.sub(/(\d)\s/,'\1-'),
          NoVowels.compact(x),
          NoVowels.compact(x.sub(/(\d)\s/,'\1')),
          NoVowels.compact(x.sub(/(\d)\s/,'\1-')),
        ]
        #puts 'a3: ' + a3.inspect if @debug
        a3b = a3.uniq.abbrev.keys.reject {|x| x[/^\s*\d+$/] or x.length < 2}
        r.merge(rawx => a3b)

      end
      #puts 'h: '  + h.inspect if @debug
      r = h.find {|key, val| val.grep(/#{ref}/).any? }
      r = h.find {|key, vl| vl.grep(/#{ref.sub(/\d+\s*/,'')}/).any? } unless r
      puts '_r: ' + r.inspect if @debug
      @booklist.index r.first if r

    end
  
end

#!/usr/bin/env ruby

# file: kjdotxml.rb

require 'rexle'


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

  def initialize()
  end
  
  def book(s)
    
    #filepath = File.join('/tmp', s.downcase.gsub(/\s/,'-') + '.xml')
    filename = s.downcase.gsub(/\s/,'-') + '.xml'
    filepath = File.join(File.dirname(__FILE__), '..', 'xml', filename)
    
    if File.exists? filepath then
      
      contents = File.read(filepath)
      Rexle.new(contents)
      
    else
      raise KjDotXmlError, 'book not found'
    end
    
  end
  
  def books()
    BOOKS
  end

  
end


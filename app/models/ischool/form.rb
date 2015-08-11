# == Schema Information
#
# Table name: Forms
#
#  SchoolID     :string(32)       default(""), not null
#  FormID       :integer          not null, primary key
#  CreatedBy    :integer
#  CreationDate :date
#  FacultyID    :integer
#  FormData     :text(65535)
#  FormNumber   :string(15)
#  ModifiedBy   :integer
#  ModifyDate   :date
#  StudentID    :integer
#

class Ischool::Form < Ischool::Base
  self.primary_key = 'FormID'
  self.table_name = 'Forms'
  
  def self.cards
    where('FormNumber like "RC%"')
  end
  
  def self.current_cards
    cards.where('CreationDate' => Period.current.range)
  end
  
  def self.last_period_cards
    cards.where('CreationDate' => Period.previous.range)
  end
  
  def self.cards_this_year
    cards.where('CreationDate' => Period.current_year_range)
  end
  
  def self.for_student(aeries_id)
    where('StudentID' => aeries_id).order('CreationDate desc')
  end
  
  def data
    @data ||= parse_data
  end
  
  def parse_data
    ary = self.attributes['FormData'].split(/\s/).sort!
    
    spanish = ary.pop
    english = extract_comments ary.pop
    
    result = {}
    
    ary.each do |v|
      if filter_keys.include? v.split('.').first
        key, value = v.split('=')
        result[key] = value
      end
    end
    
    result['comments'] = english
    
    result
  end
  
  private
  
  def extract_comments(comments)
    doc = Nokogiri::XML(URI.decode_www_form(comments).flatten.last)
    doc.css('span').map(&:text)
  end
  
  def filter_keys
    %w{a b la_e la1 la2 la3 m_e m1 sd1 sd2 sd3 sd_e pd1 pd2 pd3 pd_e ss1 ss2 ss3 ss_e sma1 sma2 sma3 wsh cit}
  end
  
end
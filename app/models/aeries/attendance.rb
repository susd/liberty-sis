# == Schema Information
#
# Table name: ATT
#
#  SC  :integer          default(0), not null
#  SN  :integer          default(0), not null
#  DY  :integer          default(1), not null
#  CD  :string(1)        default(" "), not null
#  PR  :string(1)        default(" "), not null
#  GR  :integer          default(0), not null
#  TR  :varchar(1)       default(" "), not null
#  TN  :integer          default(0), not null
#  AL  :varchar(1)       default(" "), not null
#  A0  :string(1)        default(" "), not null
#  A1  :string(1)        default(" "), not null
#  A2  :string(1)        default(" "), not null
#  A3  :string(1)        default(" "), not null
#  A4  :string(1)        default(" "), not null
#  A5  :string(1)        default(" "), not null
#  A6  :string(1)        default(" "), not null
#  A7  :string(1)        default(" "), not null
#  A8  :string(1)        default(" "), not null
#  A9  :string(1)        default(" "), not null
#  DT  :datetime
#  RS  :string(3)        default(""), not null
#  NS  :integer          default(0), not null
#  AP1 :string(3)        default(""), not null
#  AP2 :string(3)        default(""), not null
#  HS  :integer          default(0), not null
#  IT  :varchar(1)       default(" "), not null
#  NPS :varchar(7)       default(""), not null
#  ITD :varchar(14)      default(""), not null
#  DEL :boolean          default(FALSE), not null
#  DTS :datetime
#

module Aeries
  class Attendance < Base
    self.table_name = "ATT"
    self.primary_keys = [:sc, :sn, :dy]

    # T, L, D, I, E, X, Y, and N

    def self.absence_codes
      %w{E I M N R S U}
    end

    def self.tardy_codes
      %w{D L T}
    end

    def self.confirmed
      where.not(al: '')
    end

    def absence?
      self.class.absence_codes.include? attributes['al']
    end

    def tardy?
      self.class.tardy_codes.include? attributes['al']
    end

    def simple
      if absence?
        'absent'
      else
        'tardy'
      end
    end
  end
end

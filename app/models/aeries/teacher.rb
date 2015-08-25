# == Schema Information
#
# Table name: TCH
#
#  SC  :integer          default(0), not null
#  TN  :integer          default(0), not null
#  TE  :string(30)       default(""), not null
#  TF  :string(20)       default(""), not null
#  TT  :string(4)        default(""), not null
#  SS  :integer          default(0), not null
#  PD  :varchar(10)      default(""), not null
#  MX  :integer          default(30), not null
#  RM  :varchar(6)       default(""), not null
#  BM  :varchar(255)     default(""), not null
#  MS  :integer          default(0), not null
#  TS  :integer          default(0), not null
#  ET  :varchar(1)       default(" "), not null
#  ID  :integer          default(0), not null
#  TR  :varchar(1)       default(" "), not null
#  EM  :varchar(255)     default(""), not null
#  CB  :varchar(4)       default(""), not null
#  TG  :varchar(1)       default(" "), not null
#  ID2 :integer          default(0), not null
#  ID3 :integer          default(0), not null
#  MTS :varchar(2)       default(""), not null
#  HQT :varchar(1)       default(" "), not null
#  TLN :varchar(50)      default(""), not null
#  NCC :varchar(1)       default(" "), not null
#  HQ2 :varchar(1)       default(" "), not null
#  HQ3 :varchar(1)       default(" "), not null
#  ESR :varchar(1)       default(" "), not null
#  LI  :varchar(2)       default(""), not null
#  INS :varchar(3)       default(""), not null
#  FS  :varchar(3)       default(""), not null
#  U1  :varchar(3)       default(""), not null
#  U2  :varchar(3)       default(""), not null
#  U3  :varchar(3)       default(""), not null
#  U4  :varchar(3)       default(""), not null
#  U5  :varchar(3)       default(""), not null
#  U6  :varchar(3)       default(""), not null
#  U7  :varchar(3)       default(""), not null
#  U8  :varchar(3)       default(""), not null
#  LO  :integer          default(0), not null
#  HI  :integer          default(0), not null
#  WS  :varchar(255)     default(""), not null
#  CID :integer          default(0), not null
#  CA1 :varchar(2)       default(""), not null
#  CA2 :varchar(2)       default(""), not null
#  IT  :varchar(1)       default(""), not null
#  ISI :varchar(1)       default(""), not null
#  DLI :varchar(1)       default(""), not null
#  DEL :boolean          default(FALSE), not null
#  DTS :datetime
#

module Aeries
  class Teacher < Base
    self.table_name = "TCH"
    self.primary_keys = [:sc, :tn]

    def self.active
      where("[TCH].tn BETWEEN 1 AND 899").where.not(tg: 'I')
    end

    def self.active_by_site(school_code)
      active.select(:tn).distinct.where(sc: school_code)
    end

    def name
      "#{attributes['tf']} #{attributes['tln']}"
    end

    def staff_record
      @staff ||= Employee.find_by(id: attributes['id'], psc: attributes['sc'])
    end

    def to_teacher
      {
        first_name: attributes['tf'],
        last_name:  attributes['tln'],
        sex: staff_record.sx,
        hired_on: staff_record.hired_on,
        import_details: {source: 'aeries', import_class: self.class.to_s, import_id: attributes['id']}
      }
    end
  end
end

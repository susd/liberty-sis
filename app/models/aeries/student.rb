# == Schema Information
#
# Table name: STU
#
#  SC  :integer          default(0), not null
#  SN  :integer          default(0), not null
#  LN  :string(100)      default(""), not null
#  FN  :string(100)      default(""), not null
#  MN  :string(100)      default(""), not null
#  ID  :integer          default(0), not null
#  SX  :varchar(1)       default(" "), not null
#  GR  :integer          default(0), not null
#  BD  :datetime
#  PG  :string(50)       default(""), not null
#  AD  :varchar(55)      default(""), not null
#  CY  :varchar(30)      default(""), not null
#  ST  :varchar(2)       default(""), not null
#  ZC  :varchar(5)       default(""), not null
#  ZX  :varchar(4)       default(""), not null
#  TL  :varchar(10)      default(""), not null
#  FW  :varchar(10)      default(""), not null
#  FX  :varchar(5)       default(""), not null
#  MW  :varchar(10)      default(""), not null
#  MX  :varchar(5)       default(""), not null
#  T1  :varchar(1)       default(" "), not null
#  T2  :varchar(1)       default(" "), not null
#  T3  :varchar(1)       default(" "), not null
#  T4  :varchar(1)       default(" "), not null
#  T5  :varchar(1)       default(" "), not null
#  U1  :varchar(1)       default(" "), not null
#  U2  :varchar(1)       default(" "), not null
#  U3  :varchar(1)       default(" "), not null
#  U4  :varchar(1)       default(" "), not null
#  U5  :varchar(1)       default(" "), not null
#  U6  :varchar(1)       default(" "), not null
#  U7  :varchar(1)       default(" "), not null
#  U8  :varchar(1)       default(" "), not null
#  ED  :datetime
#  LD  :datetime
#  GC  :varchar(5)       default(""), not null
#  MC  :varchar(3)       default(""), not null
#  EN  :varchar(1)       default(" "), not null
#  EC  :varchar(3)       default(""), not null
#  SP  :varchar(1)       default(" "), not null
#  LS  :integer          default(0), not null
#  GP  :money            default(0.0), not null
#  CR  :integer          default(0), not null
#  CS  :integer          default(0), not null
#  TP  :money            default(0.0), not null
#  CP  :money            default(0.0), not null
#  UR  :integer          default(0), not null
#  CA  :money            default(0.0), not null
#  CC  :money            default(0.0), not null
#  CU  :integer          default(0), not null
#  ON  :integer          default(0), not null
#  QT  :varchar(1)       default(" "), not null
#  TT  :varchar(1)       default(" "), not null
#  PT  :varchar(1)       default(" "), not null
#  LK  :varchar(6)       default(""), not null
#  LT  :integer          default(0), not null
#  RE  :varchar(255)     default(""), not null
#  PC  :varchar(1)       default(" "), not null
#  TR  :varchar(1)       default(" "), not null
#  LO  :integer          default(0), not null
#  HI  :integer          default(9), not null
#  TG  :varchar(1)       default(" "), not null
#  LG  :integer          default(0), not null
#  LA  :integer          default(0), not null
#  MR  :integer          default(0), not null
#  LR  :varchar(1)       default(" "), not null
#  FK  :integer          default(0), not null
#  GG  :money            default(0.0), not null
#  GT  :money            default(0.0), not null
#  GK  :integer          default(0), not null
#  GS  :integer          default(0), not null
#  BM  :varchar(255)     default(""), not null
#  CO  :text(2147483647) default(""), not null
#  HT  :integer          default(0), not null
#  WT  :integer          default(0), not null
#  EY  :varchar(1)       default(" "), not null
#  HC  :varchar(1)       default(" "), not null
#  L2  :integer          default(0), not null
#  GA  :money            default(0.0), not null
#  GD  :money            default(0.0), not null
#  SD  :datetime
#  DG  :datetime
#  GPN :money            default(0.0), not null
#  TPN :money            default(0.0), not null
#  CPN :money            default(0.0), not null
#  GGN :money            default(0.0), not null
#  GTN :money            default(0.0), not null
#  PTS :money            default(0.0), not null
#  PUC :money            default(0.0), not null
#  PCS :money            default(0.0), not null
#  QUC :varchar(1)       default(" "), not null
#  QCS :varchar(1)       default(" "), not null
#  LF  :varchar(1)       default(" "), not null
#  HL  :varchar(2)       default(""), not null
#  SQ  :integer          default(0), not null
#  NS  :integer          default(0), not null
#  HP  :varchar(30)      default(""), not null
#  DE  :integer          default(0), not null
#  DP  :integer          default(0), not null
#  DA  :integer          default(0), not null
#  CCG :money            default(0.0), not null
#  GCG :money            default(0.0), not null
#  NG  :integer          default(0), not null
#  RAD :varchar(55)      default(""), not null
#  RCY :varchar(30)      default(""), not null
#  RST :varchar(2)       default(""), not null
#  RZC :varchar(5)       default(""), not null
#  RZX :varchar(4)       default(""), not null
#  NT  :integer          default(0), not null
#  CRL :varchar(2)       default(""), not null
#  SM  :integer          default(0), not null
#  DM  :integer          default(0), not null
#  CID :varchar(10)      default(""), not null
#  SS  :varchar(10)      default(""), not null
#  PED :varchar(2)       default(""), not null
#  SF  :varchar(10)      default(""), not null
#  LNA :string(100)      default(""), not null
#  FNA :string(100)      default(""), not null
#  MNA :string(100)      default(""), not null
#  SFA :varchar(10)      default(""), not null
#  VDT :datetime
#  VBD :varchar(1)       default(" "), not null
#  VBO :varchar(20)      default(""), not null
#  BCY :varchar(30)      default(""), not null
#  BST :varchar(3)       default(""), not null
#  BCU :varchar(2)       default(""), not null
#  CL  :varchar(2)       default(""), not null
#  HLO :varchar(30)      default(""), not null
#  DO  :varchar(1)       default(" "), not null
#  HSG :varchar(3)       default(""), not null
#  IT  :varchar(1)       default(" "), not null
#  ITD :varchar(14)      default(""), not null
#  GRT :varchar(1)       default(""), not null
#  EC2 :varchar(3)       default(""), not null
#  EC3 :varchar(3)       default(""), not null
#  EC4 :varchar(3)       default(""), not null
#  EC5 :varchar(3)       default(""), not null
#  EC6 :varchar(3)       default(""), not null
#  GPA :money            default(0.0), not null
#  TPA :money            default(0.0), not null
#  CPA :money            default(0.0), not null
#  GGA :money            default(0.0), not null
#  GTA :money            default(0.0), not null
#  OCR :integer          default(0), not null
#  OGR :integer          default(0), not null
#  HS  :integer          default(0), not null
#  NTR :varchar(1)       default(" "), not null
#  CIC :varchar(1)       default(" "), not null
#  AP1 :varchar(3)       default(""), not null
#  AP2 :varchar(3)       default(""), not null
#  SEM :varchar(255)     default(""), not null
#  PEM :varchar(255)     default(""), not null
#  U9  :varchar(2)       default(""), not null
#  U10 :varchar(2)       default(""), not null
#  DD  :datetime
#  DNR :varchar(1)       default(" "), not null
#  CUC :varchar(1)       default(" "), not null
#  CCS :varchar(1)       default(" "), not null
#  SES :varchar(1)       default(" "), not null
#  SG  :varchar(2)       default(""), not null
#  RN  :integer          default(0), not null
#  VPC :varchar(20)      default(""), not null
#  EGD :datetime
#  CCO :varchar(1)       default(""), not null
#  BPS :varchar(1)       default(" "), not null
#  SWR :varchar(3)       default(""), not null
#  EOY :varchar(3)       default(""), not null
#  CO2 :text(2147483647) default(""), not null
#  RS  :integer          default(0), not null
#  MPH :varchar(10)      default(""), not null
#  CO3 :text(2147483647) default(""), not null
#  OID :integer          default(0), not null
#  NID :varchar(255)     default(""), not null
#  AV  :boolean          default(FALSE), not null
#  ETH :varchar(1)       default(""), not null
#  RC1 :varchar(3)       default(""), not null
#  RC2 :varchar(3)       default(""), not null
#  RC3 :varchar(3)       default(""), not null
#  RC4 :varchar(3)       default(""), not null
#  RC5 :varchar(3)       default(""), not null
#  U11 :varchar(2)       default(""), not null
#  U12 :varchar(2)       default(""), not null
#  U13 :varchar(2)       default(""), not null
#  INE :varchar(9)       default(""), not null
#  TRU :varchar(1)       default(" "), not null
#  OSI :varchar(10)      default(""), not null
#  RDT :datetime
#  ITE :datetime
#  ENS :integer          default(0), not null
#  SNS :integer          default(0), not null
#  SLD :datetime
#  NIT :varchar(1)       default(" "), not null
#  NTD :varchar(14)      default(""), not null
#  NRS :integer          default(0), not null
#  RSY :varchar(50)      default(""), not null
#  RP  :money            default(0.0), not null
#  RC  :varchar(3)       default(""), not null
#  NSP :varchar(1)       default(""), not null
#  NP1 :varchar(3)       default(""), not null
#  NP2 :varchar(3)       default(""), not null
#  NGC :varchar(5)       default(""), not null
#  DEL :boolean          default(FALSE), not null
#  DTS :datetime
#

module Aeries
  class Student < Base
    include Aeries::AttendanceQueries

    INACTIVE = ['L', 'N', 'i']

    self.table_name = "STU"
    self.primary_keys = [:sc, :sn]

    def self.active
      where.not(tg: INACTIVE, sc: 999, del: true)
    end

    def self.inactive
      where("tg IN (?) OR sc = ? OR del = ?", INACTIVE, 999, 'true')
    end

    def self.tkinder
      where("SP" => ['T', 'U'])
    end

    def self.find_by_student(student)
      where("ID" => student.import_details['import_id'])
    end

    def school_code
      attributes['sc']
    end

    def student_number
      attributes['sn']
    end

    def to_student
      {
        first_name:   attributes['fn'],
        middle_name:  attributes['mn'],
        last_name:    attributes['ln'],
        sex:          attributes['sx'],
        birthdate:    convert_birthdate,
        home_lang:    find_home_lang,
        grade:        find_liberty_grade,
        site:         find_liberty_site,
        state:        state,
        import_details: {source: 'aeries', import_class: self.class.to_s, import_id: attributes['id']}
      }
    end

    def find_liberty_grade
      if ['T', 'U'].include? attributes['sp']
        Grade.find_by(position: 0.5)
      else
        Grade.where.not(position: 0.5).find_by(legacy_id: attributes['gr'])
      end
    end

    def find_liberty_site
      Site.find_by(code: sc)
    end

    def find_home_lang
      Language.find_by(aeries_code: attributes['hl'].to_i)
    end

    def convert_birthdate
      bd && read_attribute_before_type_cast('bd').to_date
    end

    def state
      if INACTIVE.include?(self.tg) || self.del
        2
      elsif self.tg == '*'
        0
      else
        1
      end
    end

  end
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


sites = [
  { name: 'District Office',          code: 5,  abbr: 'do'},
  { name: 'Cedarcreek School',        code: 10, abbr: 'cc' },
  { name: 'Emblem School',            code: 15, abbr: 'em' },
  { name: 'Highlands School',         code: 20, abbr: 'hi' },
  { name: 'Mountainview School',      code: 25, abbr: 'mv' },
  { name: 'Rio Vista School',         code: 30, abbr: 'rv' },
  { name: 'Rosedell School',          code: 35, abbr: 'ro' },
  { name: 'Santa Clarita School',     code: 40, abbr: 'sc' },
  { name: 'Charles Helmers School',   code: 45, abbr: 'he' },
  { name: 'Skyblue Mesa School',      code: 50, abbr: 'sk' },
  { name: 'James Foster School',      code: 55, abbr: 'fo' },
  { name: 'Bouquet Canyon School',    code: 60, abbr: 'bo' },
  { name: 'Plum Canyon School',       code: 65, abbr: 'pc' },
  { name: 'North Park School',        code: 70, abbr: 'np' },
  { name: 'Bridgeport School',        code: 75, abbr: 'bp' },
  { name: 'Tesoro Del Valle School',  code: 80, abbr: 'tv' },
  { name: 'West Creek Academy',       code: 85, abbr: 'wc' }
  ]

sites.each do |site|
  Site.where(code: site[:code]).first_or_create(site)
end

grades = [
  { name: 'Preschool', position: 0.3, legacy_id: 14 },
  { name: 'Transistional Kindergarten', position: 0.5, legacy_id: 0 },
  { name: 'Kindergarten', position: 0.8, legacy_id: 0 },
  { name: '1st Grade', position: 1.0, legacy_id: 1 },
  { name: '2nd Grade', position: 2.0, legacy_id: 2 },
  { name: '3rd Grade', position: 3.0, legacy_id: 3 },
  { name: '4th Grade', position: 4.0, legacy_id: 4 },
  { name: '5th Grade', position: 5.0, legacy_id: 5 },
  { name: '6th Grade', position: 6.0, legacy_id: 6 }
  ]

grades.each do |gr|
  Grade.where(name: gr[:name]).first_or_create(gr)
end

langs = [
  { calpads_code: 0,  calpads_name: "English                                      ".strip, aeries_code: 0,  name: "English"             },
  { calpads_code: 1,  calpads_name: "Spanish                                      ".strip, aeries_code: 1,  name: "Spanish"             },
  { calpads_code: 2,  calpads_name: "Vietnamese                                   ".strip, aeries_code: 2,  name: "Vietnamese"          },
  { calpads_code: 3,  calpads_name: "Cantonese                                    ".strip, aeries_code: 3,  name: "Cantonese"           },
  { calpads_code: 4,  calpads_name: "Korean                                       ".strip, aeries_code: 4,  name: "Korean"              },
  { calpads_code: 5,  calpads_name: "Filipino (Pilipino or Tagalog)               ".strip, aeries_code: 5,  name: "Filipino (Tagalog)"  },
  { calpads_code: 6,  calpads_name: "Portuguese                                   ".strip, aeries_code: 6,  name: "Portuguese"          },
  { calpads_code: 7,  calpads_name: "Mandarin (Putonghua)                         ".strip, aeries_code: 7,  name: "Mandarin (Putonghua)"},
  { calpads_code: 8,  calpads_name: "Japanese                                     ".strip, aeries_code: 8,  name: "Japanese"            },
  { calpads_code: 9,  calpads_name: "Khmer (Cambodian)                            ".strip, aeries_code: 9,  name: "Khmer (Cambodian)"   },
  { calpads_code: 10, calpads_name: "Lao                                          ".strip, aeries_code: 10, name: "Lao"                 },
  { calpads_code: 11, calpads_name: "Arabic                                       ".strip, aeries_code: 11, name: "Arabic"              },
  { calpads_code: 12, calpads_name: "Armenian                                     ".strip, aeries_code: 12, name: "Armenian"            },
  { calpads_code: 13, calpads_name: "Burmese                                      ".strip, aeries_code: 13, name: "Burmese"             },
  { calpads_code: 99, calpads_name: "Other non-English languages                  ".strip, aeries_code: 14, name: "Croatian"            },
  { calpads_code: 15, calpads_name: "Dutch                                        ".strip, aeries_code: 15, name: "Dutch"               },
  { calpads_code: 16, calpads_name: "Farsi (Persian)                              ".strip, aeries_code: 16, name: "Farsi (Persian)"     },
  { calpads_code: 17, calpads_name: "French                                       ".strip, aeries_code: 17, name: "French"              },
  { calpads_code: 18, calpads_name: "German                                       ".strip, aeries_code: 18, name: "German"              },
  { calpads_code: 19, calpads_name: "Greek                                        ".strip, aeries_code: 19, name: "Greek"               },
  { calpads_code: 20, calpads_name: "Chamorro (Guamanian)                         ".strip, aeries_code: 20, name: "Chamorro (Guamanian)"},
  { calpads_code: 21, calpads_name: "Hebrew                                       ".strip, aeries_code: 21, name: "Hebrew"              },
  { calpads_code: 22, calpads_name: "Hindi                                        ".strip, aeries_code: 22, name: "Hindi"               },
  { calpads_code: 23, calpads_name: "Hmong                                        ".strip, aeries_code: 23, name: "Hmong"               },
  { calpads_code: 24, calpads_name: "Hungarian                                    ".strip, aeries_code: 24, name: "Hungarian"           },
  { calpads_code: 25, calpads_name: "Ilocano                                      ".strip, aeries_code: 25, name: "Ilocano"             },
  { calpads_code: 26, calpads_name: "Indonesian                                   ".strip, aeries_code: 26, name: "Indonesian"          },
  { calpads_code: 27, calpads_name: "Italian                                      ".strip, aeries_code: 27, name: "Italian"             },
  { calpads_code: 28, calpads_name: "Punjabi                                      ".strip, aeries_code: 28, name: "Punjabi"             },
  { calpads_code: 29, calpads_name: "Russian                                      ".strip, aeries_code: 29, name: "Russian"             },
  { calpads_code: 30, calpads_name: "Samoan                                       ".strip, aeries_code: 30, name: "Samoan"              },
  { calpads_code: 32, calpads_name: "Thai                                         ".strip, aeries_code: 32, name: "Thai"                },
  { calpads_code: 33, calpads_name: "Turkish                                      ".strip, aeries_code: 33, name: "Turkish"             },
  { calpads_code: 34, calpads_name: "Tongan                                       ".strip, aeries_code: 34, name: "Tongan"              },
  { calpads_code: 35, calpads_name: "Urdu                                         ".strip, aeries_code: 35, name: "Urdu"                },
  { calpads_code: 36, calpads_name: "Cebuano (Visayan)                            ".strip, aeries_code: 36, name: "Cebuano (Visayan)"   },
  { calpads_code: 37, calpads_name: "Sign Language                                ".strip, aeries_code: 37, name: "Sign Language"       },
  { calpads_code: 38, calpads_name: "Ukrainian                                    ".strip, aeries_code: 38, name: "Ukrainian"           },
  { calpads_code: 39, calpads_name: "Chaozhou (Chiuchow)                          ".strip, aeries_code: 39, name: "Chaozhou (Chaochow)" },
  { calpads_code: 40, calpads_name: "Pashto                                       ".strip, aeries_code: 40, name: "Pashto"              },
  { calpads_code: 41, calpads_name: "Polish                                       ".strip, aeries_code: 41, name: "Polish"              },
  { calpads_code: 42, calpads_name: "Assyrian                                     ".strip, aeries_code: 42, name: "Assyrian"            },
  { calpads_code: 43, calpads_name: "Gujarati                                     ".strip, aeries_code: 43, name: "Gujarati"            },
  { calpads_code: 44, calpads_name: "Mien (Yao)                                   ".strip, aeries_code: 44, name: "Mien (Yao)"          },
  { calpads_code: 45, calpads_name: "Rumanian                                     ".strip, aeries_code: 45, name: "Rumanian"            },
  { calpads_code: 46, calpads_name: "Taiwanese                                    ".strip, aeries_code: 46, name: "Taiwanese"           },
  { calpads_code: 47, calpads_name: "Lahu                                         ".strip, aeries_code: 47, name: "Lahu"                },
  { calpads_code: 48, calpads_name: "Marshallese                                  ".strip, aeries_code: 48, name: "Marshallese"         },
  { calpads_code: 49, calpads_name: "Mixteco                                      ".strip, aeries_code: 49, name: "Mixteco"             },
  { calpads_code: 50, calpads_name: "Khmu                                         ".strip, aeries_code: 50, name: "Khmu"                },
  { calpads_code: 51, calpads_name: "Kurdish (Kurdi, Kurmanji)                    ".strip, aeries_code: 51, name: "Kurdish"             },
  { calpads_code: 52, calpads_name: "Serbo-Croatian (Bosnian, Croatian, Serbian)  ".strip, aeries_code: 52, name: "Serbo-Croatian"      },
  { calpads_code: 53, calpads_name: "Toishanese                                   ".strip, aeries_code: 53, name: "Toishanese"          },
  { calpads_code: 54, calpads_name: "Chaldean                                     ".strip, aeries_code: 54, name: "Chaldean"            },
  { calpads_code: 56, calpads_name: "Albanian                                     ".strip, aeries_code: 56, name: "Albanian"            },
  { calpads_code: 57, calpads_name: "Tigrinya                                     ".strip, aeries_code: 57, name: "Tigrinya"            },
  { calpads_code: 99, calpads_name: "Other non-English languages                  ".strip, aeries_code: 58, name: "Bosnian"             },
  { calpads_code: 60, calpads_name: "Somali                                       ".strip, aeries_code: 60, name: "Somali"              },
  { calpads_code: 61, calpads_name: "Bengali                                      ".strip, aeries_code: 61, name: "Bengali"             },
  { calpads_code: 62, calpads_name: "Telugu                                       ".strip, aeries_code: 62, name: "Telugu"              },
  { calpads_code: 63, calpads_name: "Tamil                                        ".strip, aeries_code: 63, name: "Tamil"               },
  { calpads_code: 64, calpads_name: "Marathi                                      ".strip, aeries_code: 64, name: "Marathi"             },
  { calpads_code: 65, calpads_name: "Kannada                                      ".strip, aeries_code: 65, name: "Kannada"             },
  { calpads_code: 99, calpads_name: "Other non-English languages                  ".strip, aeries_code: 88, name: "Native American"     },
  { calpads_code: 99, calpads_name: "Other non-English languages                  ".strip, aeries_code: 99, name: "Other non-English"   }
  ]

langs.each do |lang|
  Language.where(aeries_code: lang[:aeries_code]).first_or_create(lang)
end


roles = [
  {name: 'admin'},
  {name: 'teacher'},
  {name: 'office'},
  {name: 'principal'}
]

roles.each do |role|
  Role.where(name: role[:name]).first_or_create(role)
end

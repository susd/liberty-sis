require 'spreadsheet'

module Mcgraw
  class Formatter
    attr_reader :path, :book, :sheet

    def initialize(path)
      @path = path
      @book = Spreadsheet::Workbook.new
      @sheet = book.create_worksheet(:name => 'Sheet1')
    end

    def write
      yield sheet
      book.write(path)
    end
  end
end

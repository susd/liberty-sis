require "csv"

module Bbconnect
  class ExportAllJob < ActiveJob::Base
    queue_as :export

    after_perform do
      Bbconnect::ExportAllJob.set(wait: 3.days).perform_later
    end

    def perform
      export_k12
      export_ezcare
      export_faculty

      upload_all
    end

    private

    def export_k12
      CSV.open(Bbconnect::K12Exporter::PATH, 'w') do |csv|
        csv << Bbconnect::K12Exporter.header
        Student.includes(:contacts, :site, :grade).order(:site, :grade).find_each.with_index do |student, idx|
          csv << Bbconnect::K12Exporter.new(student).export
        end
      end
    end

    def export_ezcare
      CSV.open(Bbconnect::CdpExporter::TARGET, 'w') do |csv|
        csv << Bbconnect::CdpExporter.header
        CSV.foreach(Bbconnect::CdpExporter::SOURCE, headers: true).with_index do |row, idx|
          csv << Bbconnect::CdpExporter.new(row).export
        end
      end
    end

    def export_faculty
      CSV.open(Bbconnect::FacultyExporter::PATH, 'w') do |csv|
        csv << Bbconnect::FacultyExporter.header

        Employee.active.includes(:primary_site).order(:primary_site)
        .find_each.with_index do |employee, idx|
          csv << Bbconnect::FacultyExporter.new(employee).export
        end
      end
    end

    def upload_all
      upload_k12
      upload_faculty
      upload_ezcare
    end

    def upload_k12
      Bbconnect::Uploader.new(
        Bbconnect::K12Exporter::PATH,
        Rails.application.secrets[:bbconnect_k12].merge(type: "Student")
        ).perform
    end

    def upload_faculty
      Bbconnect::Uploader.new(
        Bbconnect::FacultyExporter::PATH,
        Rails.application.secrets[:bbconnect_k12].merge(type: "Faculty")
        ).perform
    end

    def upload_ezcare
      Bbconnect::Uploader.new(
        Bbconnect::CdpExporter::TARGET,
        Rails.application.secrets[:bbconnect_cdp].merge(type: "Student")
        ).perform
    end

  end
end

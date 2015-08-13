# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  email               :string           default(""), not null
#  encrypted_password  :string           default(""), not null
#  remember_created_at :datetime
#  sign_in_count       :integer          default(0), not null
#  current_sign_in_at  :datetime
#  last_sign_in_at     :datetime
#  current_sign_in_ip  :inet
#  last_sign_in_ip     :inet
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  first_name          :text
#  last_name           :text
#  image_url           :text
#  provider            :text
#  uid                 :text
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :omniauthable

  has_and_belongs_to_many :roles

  has_one :employee

  def self.from_omniauth(auth)
    pass = Devise.friendly_token
    user = find_or_create_by(auth.slice('provider', 'uid')) do |u|
      u.provider               = auth['provider']
      u.uid                    = auth['uid']
      u.email                  = auth['info']["email"]
      u.password               = pass
      u.password_confirmation  = pass
    end

    user.update({
      first_name: auth['info']['first_name'],
      last_name:  auth['info']["last_name"],
      image_url:  auth['info']['image']
    })

    user
  end

  def name
    "#{first_name} #{last_name}"
  end

  def admin?
    roles.where(name: 'admin').exists?
  end

  def can?(action, resource, target = nil)
    @cached_perms ||= roles.pluck(:permissions)
    # if target.is_a? Symbol
    #   match_general_permission(action, resource, target)
    # else
    #   match_specific_permission(action, resource, target)
    # end

    # if has_general_permission?
    # when :all, true
    # when :site, is target associated with site?
    # when :own, is target associated with user?
    # when :self, is target equal to user's employee record?
    matched_roles = roles.where("permissions ? :action", action: action)
    # maybe this would be better as a normal table
  end

  def match_site_permission(action, resource, target)
    false
  end

  def match_specific_permission(action, resource, target)
    employee && employee.send(resource).include?(target)
  end

end

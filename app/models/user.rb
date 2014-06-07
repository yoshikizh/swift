class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, authentication_keys: [:login]

  attr_accessor :login

  validates :username,:uniqueness => { :case_sensitive => false }

  symbolize :utype, :in => {
      :normal    => "用户",
      :admin    => "管理员"
  }, :scopes => true

  def add_point(n)
    self.update_attributes :point => self.point + n
  end

  class << self
    def find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
    end
  end
end

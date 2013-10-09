class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  attr_accessor :login
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :username, :name, :email, :password, :password_confirmation, :remember_me  
  attr_accessible :login, :first_name, :last_name
  
  validates_presence_of :username
  validates_format_of :username, with: /^[a-z0-9_]+$/, message: 'must be lowercase alphanumerics only'
  validates_length_of :username, maximum: 32, message: 'exceeds maximum of 32 characters'
  validates_exclusion_of :username, in: ['www', 'mail', 'ftp'], message: 'is not available'
  validates_uniqueness_of :username
  
  after_create :assign_default_role
  
  has_many :issues
  has_many :responses
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def assign_default_role
    add_role(:user)
  end
  
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
end

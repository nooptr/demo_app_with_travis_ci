class User < ActiveRecord::Base
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable,
    :validatable, :timeoutable
    #, :confirmable

  belongs_to :designation	
  belongs_to :role

  mount_uploader :image, ImageUploader
  attr_accessor :previous_experiance_year,:previous_experiance_month
	validates :firstname, presence: true , format:{ with: /\A[a-zA-Z]+\z/,message: "only allow letters" }
	validates :lastname, presence: true ,format:{ with: /\A[a-zA-Z]+\z/,message: "only allow letters" }
	validates_presence_of :password,:on => :create 
	validates_presence_of :password_confirmation,:on => :create 
	validates :username, presence: true ,uniqueness: true ,format:{ with: /\A[a-z0-9\-_]+\z/,message: "only allow letters,numbers,underscore and hyphen" }
	validates :empid, presence: true
	validates :phone, format:{ with: /\d{3}\-?\d{3}\-?\d{4}/,message: "only allow numbers" }
	
  before_save :user_values,:calculate_previous_experiance

	def user_values
		self.role_id ||= Role.user_role.id if Role.user_role
  end

  def calculate_previous_experiance
  	self.previous_experiance ||= "#{previous_experiance_year}.#{previous_experiance_month}"
  end

  def reset_status
  	self.locked_at = nil
    self.reason = ""
    self.deactivated_date = ""
    self.locked = "active"
    self.failed_attempts = 0 if respond_to?(:failed_attempts=)
    self.unlock_token = nil  if respond_to?(:unlock_token=)
    save(validate: false)
  end

  def calculate_total_experiance
 	  current_experiance_year = ((DateTime.now.to_date-doj.to_date)/365).to_i
    current_experiance_month = (((DateTime.now.to_date-self.doj.to_date).to_i/365)*12)%12
    total_experiance_month = previous_experiance.split(".").last.to_i + current_experiance_month
    total_experiance_year = current_experiance_year+ previous_experiance.split(".").first.to_i
    return "#{total_experiance_year}.#{total_experiance_month}"
  end
end  

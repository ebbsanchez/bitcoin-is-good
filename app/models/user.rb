class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :students, class_name: 'User', foreign_key: :tutor_id
  belongs_to :tutor, class_name: 'User'

end

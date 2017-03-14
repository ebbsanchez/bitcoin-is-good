class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessor :payed
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :days
  has_many :transactions
  has_many :addresses

  has_many :students, class_name: 'User', foreign_key: :tutor_id
  belongs_to :tutor, class_name: 'User'


end

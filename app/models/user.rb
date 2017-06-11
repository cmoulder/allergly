class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  has_many :meals, :dependent => :destroy
  validates :first_name, :length => { :minimum => 2, :maximum => 15 }
  validates :first_name, :presence => true
end

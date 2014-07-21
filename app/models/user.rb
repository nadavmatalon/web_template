class User < ActiveRecord::Base

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable, :validatable
  	devise 	:database_authenticatable, :registerable,
       		:recoverable, :rememberable, :trackable, 
            :omniauthable, :omniauth_providers => [:github],
            authentication_keys: [:username]
            # :omniauthable, :omniauth_providers => [:facebook],

    before_save { email.downcase! }

	has_many :gitlinks

  	validates :name, length: { maximum: 50 }
  	validates :username, :presence => true, uniqueness: { case_sensitive: false }
  	# validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, uniqueness: { case_sensitive: false }


    def self.from_omniauth(auth)
        where(auth.slice(:provider, :uid)).first_or_create do |user|
            user.name = auth.info.name || "n/a"
            user.username = auth.info.nickname
            user.email = auth.info.email
    #       user.image = auth.info.image 
            user.password = Devise.friendly_token[0,20]
        end
    end


    # for facebook:

    # def self.from_omniauth(auth)
    #     where(auth.slice(:provider, :uid)).first_or_create do |user|
    #         user.email = auth.info.email
    #         user.password = Devise.friendly_token[0,20]
    #         user.name = auth.info.name  
    #         user.username = auth.info.first_name || auth.info.name
    #         # user.image = auth.info.image 
    #     end
    # end
end

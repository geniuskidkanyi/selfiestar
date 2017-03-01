require 'twilio-ruby'
class User < ApplicationRecord
      mount_uploader :avatar, PhotoUploader
    devise :two_factor_authenticatable, :database_authenticatable, :registerable,
          :rememberable, :trackable, :validatable
    def email_required?
        false
    end

    def email_changed?
        false
    end
    # attr_accessible :username
    attr_accessor :login, :reset_token
    # attr_accessible :login
    has_one_time_password(encrypted: true)
    def self.find_for_database_authentication(warden_conditions)
        conditions = warden_conditions.dup
        login = conditions.delete(:login)
        where(conditions).where(['lower(username) = :value', { value: login.strip.downcase }]).first
    end
    # devise end
    has_many :likes
    has_many :selfies
    has_many :winners
    has_many :comments
    has_many :visits
    validates :username, presence: true, uniqueness: true
    validates :phone_number, presence: true, uniqueness: true

    # ##twillio setup
    def send_two_factor_authentication_code(code)
        number = '+220' + phone_number
        client.messages.create(
            from: '+12674607667',
            to: number,
            body: "Your login code on Selfiestar: #{code} "
        )
        logger.info 'Code sent.'
     end

    def likes?(selfy)
        selfy.likes.where(user_id: id).any?
    end

    # Sets the password reset attributes.
    def create_reset_digest
      totp = ROTP::TOTP.new("base32secret3232")
    self.reset_token = totp.now
    update_attribute(:reset_password_token, self.reset_token)
    update_attribute(:reset_password_sent_at, Time.zone.now)
    end

    def send_password_reset_sms
      number = '+220' + phone_number
      client.messages.create(
          from: '+12674607667',
          to: number,
          body: self.reset_token
      )
      logger.info 'Code sent.'
    end
    # Returns true if a password reset has expired.
    def password_reset_expired?
    reset_password_sent_at < 1.hours.ago
    end
    private

    def client
        # pry.binding
        account_sid = 'ACd4bf259b70ba7eeaea89a24ca750f3ac'
        auth_token = 'd99aa0a16da8cdcb05f40144f2823541'

        @client ||= Twilio::REST::Client.new account_sid, auth_token
    end
    def self.send_reset_password_instructions attributes = {}
      recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
      pry.binding
      recoverable.send_reset_password_instructions
      recoverable
    end



    def self.find_record login
      where(["username = :value", {value: login}]).first
    end

end

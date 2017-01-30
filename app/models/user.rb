require 'twilio-ruby'
class User < ApplicationRecord
    # devise
    devise :two_factor_authenticatable, :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable
    def email_required?
        false
    end

    def email_changed?
        false
    end
    # attr_accessible :username
    attr_accessor :login
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
    validates :username, presence: true, uniqueness: true
    validates :phone_number, presence: true, uniqueness: true

    # ##twillio setup
    def send_two_factor_authentication_code(code)
        number = '+220' + phone_number
        client.messages.create(
            from: '+12674607667',
            to: number,
            body: code
        )
        logger.info 'Code sent.'
     end

    def likes?(selfy)
        selfy.likes.where(user_id: id).any?
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
      recoverable.send_reset_password_instructions if recoverable.persisted?
      recoverable
    end

    def self.find_recoverable_or_initialize_with_errors required_attributes, attributes, error = :invalid
      (case_insensitive_keys || []).each {|k| attributes[k].try(:downcase!)}

      attributes = attributes.slice(*required_attributes)
      attributes.delete_if {|_key, value| value.blank?}

      if attributes.size == required_attributes.size
        if attributes.key?(:login)
          login = attributes.delete(:login)
          record = find_record(login)
        else
          record = where(attributes).first
        end
      end

      unless record
        record = new

        required_attributes.each do |key|
          value = attributes[key]
          record.send("#{key}=", value)
          record.errors.add(key, value.present? ? error : :blank)
        end
      end
      record
    end

    def self.find_record login
      where(["username = :value", {value: login}]).first
    end

end

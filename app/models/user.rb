class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :authentication_keys => [:name]

  #nameを必須とする
  validates_uniqueness_of :name
  validates_presence_of :name

  def send_on_create_confirmation_instructions
    generate_confirmation_token!  unless @raw_confirmation_token
    send_devise_notification(:confirmation_on_create_instructions, @raw_confirmation_token, {})
  end

  #nameを利用してログインするようにオーバーライド
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      #認証の条件式を変更する
      where(conditions).where(["name = :value", { :value => name }]).first
    else
      where(conditions).first
    end
  end

  #emailを不要とする
  def email_required?
    false
  end

  def email_changed?
    false
  end

end

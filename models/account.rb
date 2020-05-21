class Account < Sequel::Model

  plugin :validation_helpers

  attr_accessor :password, :password_confirmation

  def validate
    validates_presence     :name, message: 'Name is Required'
    validates_presence     :surname, message: 'Surname is Required'
    validates_presence     :avatar, message: 'Avatar is Required'
    validates_presence     :email, message: 'Email is Required'
    validates_presence     :role, message: 'Role is Required'
    validates_presence     :password, message: 'Password is Required' if password_required
    validates_presence     :password_confirmation, message: 'Password Confirmation is Required' if password_required
    validates_length_range 4..40, :password, message: 'Password Min 4 and Max 40' unless password.blank?
    errors.add(:password_confirmation, 'must confirm password') if !password.blank? && password != password_confirmation
    validates_length_range 3..100, :email, message: 'Email Min 3 and Max 100' unless email.blank?
    validates_unique       :email, message: 'Error Duplicate Email' unless email.blank?
    validates_format       /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :email, message: 'Email is Invalid Format' unless email.blank?
    validates_format       /[A-Za-z]/, :role, message: 'Role must an alphabet' unless role.blank?
  end

  # Callbacks
  def before_save
    encrypt_password
  end

  ##
  # This method is for authentication purpose.
  #
  def self.authenticate(email, password)
    account = filter(Sequel.function(:lower, :email) => Sequel.function(:lower, email)).first
    account && account.has_password?(password) ? account : nil
  end

  ##
  # Replace ActiveRecord method.
  #
  def self.find_by_id(id)
    self[id] rescue nil
  end

  def has_password?(password)
    ::BCrypt::Password.new(self.crypted_password) == password
  end

  private

  def encrypt_password
    self.crypted_password = ::BCrypt::Password.create(password) if password.present?
  end

  def password_required
    self.crypted_password.blank? || password.present?
  end
end

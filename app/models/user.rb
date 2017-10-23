# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  rut                    :text
#  first_name             :text
#  last_name              :text
#  phone_number           :text
#  address                :text
#  image                  :text
#  role_id                :integer          not null
#  deleted_at             :datetime
#  emergency_phone        :text             default(""), not null
#  contract_date          :datetime
#  contract_end_date      :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  acts_as_paranoid
  devise :database_authenticatable, :registerable,
    :recoverable, :validatable

  validates :email, uniqueness: true, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  belongs_to :role
  validates :role, presence: true
  before_validation :assign_role_id, on: :create
  has_many :access_tokens, foreign_key: :resource_owner_id, class_name: 'Doorkeeper::AccessToken',
    dependent: :destroy
  has_many :executed_reports, class_name: :Report, foreign_key: :executor_id

  delegate :organization, to: :role, allow_nil: false
  delegate :organization_id, to: :role, allow_nil: false
  has_many :created_reports, class_name: :Report, foreign_key: :creator_id, dependent: :destroy
  # has_many :assigned_reports, class_name: :Report, foreign_key: :assigned_user_id, dependent: :destroy
  has_and_belongs_to_many :assigned_reports, class_name: 'Report'
  has_many :created_promotions, class_name: :Promotion, foreign_key: :creator_id, dependent: :destroy
  after_create :send_confirmation_email
  has_and_belongs_to_many :promotions
  has_many :checkins, dependent: :destroy
  has_many :devices, dependent: :destroy
  has_many :broadcasts, foreign_key: :sender_id, class_name: :Broadcast, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :sale_goal_uploads, dependent: :nullify
  has_many :images, dependent: :destroy
  has_and_belongs_to_many :promoted_stores, class_name: 'Store'

  # has_many :promoted_stores, class_name: :Store, foreign_key: :promoter_id, dependent: :nullify
  has_many :instructed_stores, class_name: :Store, foreign_key: :instructor_id, dependent: :nullify
  has_many :supervised_stores, class_name: :Store, foreign_key: :supervisor_id, dependent: :nullify

  def send_confirmation_email
    UserMailer.delay(queue: "#{ENV['QUEUE_PREFIX']}_email").confirmation_email(self)
  end

  def send_reset_password_instructions
    set_reset_password_token
    UserMailer.delay(queue: "#{ENV['QUEUE_PREFIX']}_email").reset_password_email(self)
  end

  def full_name
    "#{first_name} #{last_name}".present? ? "#{first_name} #{last_name}" : email
  end

  def name
    full_name
  end

  def viewable_reports
    Report.includes(:assigned_users, :creator).where("users.id = ? OR creators_reports.id = ?", self.id, self.id)
    .references(:assigned_users)
  end

  def assign_role_id
    inv = Invitation.find_by_email(self.email)
    if inv.present?
      self.role_id = inv.role_id
    end

    if self.role_id.nil?
      self.role = Role.first
    end
  end

  def set_reset_password_token
    token = ""
    4.times do |i|
      token = token + rand(10).to_s
    end
    self.reset_password_token = token
    self.reset_password_sent_at = Time.now.utc
    self.save validate: false
    token
  end

  def self.find_or_create_by_lowercase_email!(email, role)
    if email.nil? or email.empty?
      return nil
    end
    email.strip!
    email.downcase!
    instance = nil
    User.skip_callback(:create, :after, :send_confirmation_email)
    begin
      instance = self.with_deleted.where('lower(email) = ?', email).first
      if instance.nil?
        instance = self.create! email: email,
          password: "12345678", role: role,
          first_name: email, last_name: email
      else
        instance.restore!
      end
    ensure
      User.set_callback(:create, :after, :send_confirmation_email)
    end
    instance
  end
end

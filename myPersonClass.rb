require 'date'
require_relative 'consoleinput'
require_relative 'personalvalidation'

class Person
  include consoleinput
  include personalvalidation

  attr_reader :first_name, :last_name, :inn, :birth_date

  def initialize(first_name, last_name, inn, birth_date)
    self.first_name = first_name
    self.last_name = last_name
    self.inn = inn
    self.birth_date = birth_date
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def age
    now = Date.today
    now.year - birth_date.year - ((now.month > birth_date.month || (now.month == birth_date.month && now.day >= birth_date.day)) ? 0 : 1)
  end

  def to_s
    "#{full_name}, INN: #{inn}, Birth Date: #{birth_date.strftime('%Y-%m-%d')}"
  end

  def first_name=(new_first_name)
    validate_name(new_first_name, 'first_name')
    @first_name = new_first_name
  end

  def last_name=(new_last_name)
    validate_name(new_last_name, 'last_name')
    @last_name = new_last_name
  end

  def inn=(new_inn)
    validate_inn(new_inn)
    @inn = new_inn
  end

  def birth_date=(new_birth_date)
    validate_date(new_birth_date, 'birth_date')
    @birth_date = Date.parse(new_birth_date)
  end

  private

  def validate_name(name, field_name)
    raise ArgumentError, "Invalid #{field_name}" unless valid_name?(name)
  end

  def validate_inn(inn)
    raise ArgumentError, 'Invalid INN' unless valid_inn?(inn)
  end

  def validate_date(date, field_name)
    raise ArgumentError, 'Invalid date format' unless valid_date_format?(date)
    raise ArgumentError, 'Invalid birth date' unless after_date?(date)
  end
end
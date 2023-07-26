require 'date'

module PersonValidator  
  private

  VALID_NAME_PATTERN = /\A[A-Za-z]+\z/
  VALID_INN_PATTERN = /\A[A-Z]{2}\d{10}\z/
  MAX_NAME_LENGTH = 20

  def valid_name?(name)
    name.match?(VALID_NAME_PATTERN) && name.length <= MAX_NAME_LENGTH
  end 

  def valid_inn?(inn)
    inn.match?(VALID_INN_PATTERN)
  end 

  def valid_date?(date)
    date.is_a?(Date) && date <= Date.today
  end
end

require 'test/unit'
require_relative 'myPerson'
require_relative 'myPersonRepository'

class myPersonRepositoryTest < Test::Unit::TestCase
  def setup
    @repository = myPersonRepository.new
    @person1 = myPerson.new('Paul', 'Dalton', '2005-04-06', '123456789')
    @person2 = myPerson.new('Aly', 'Sp', '1885-05-10', '987654321')
  end

  def test_add_person
    @repository.add_person(@person1)
    assert_equal([@person1], @repository.people)

    assert_raise(ArgumentError) { @repository.add_person('not a person') }
    assert_raise(PersonAlreadyExist) { @repository.add_person(@person1) }
  end

  def test_edit_person_by_inn
    @repository.add_person(@person1)
    @repository.edit_person_by_inn('123456789', 'Alex', 'Mon', '2005-04-30')
    assert_equal('Alex', @person1.first_name)
    assert_equal('Mon', @person1.last_name)
    assert_equal('2005-04-30', @person1.birth_date)

    assert_raise(PersonNotFoundError) { @repository.edit_person_by_inn('4534823483', 'Jack', 'Smith', '1985-03-20') }
  end

  def test_delete_person_by_inn
    @repository.add_person(@person1)
    @repository.add_person(@person2)
    @repository.delete_person_by_inn('123456789')
    assert_equal([@person2], @repository.people)

    assert_raise(PersonNotFoundError) { @repository.delete_person_by_inn('123456789') }
  end

  def test_get_by_inn
    @repository.add_person(@person1)
    assert_equal(@person1, @repository.get_by_inn('123456789'))
    assert_nil(@repository.get_by_inn('999999999'))
  end

  def test_get_by_part_name
    @repository.add_person(@person1)
    @repository.add_person(@person2)
    assert_equal([@person1, @person2], @repository.get_by_part_name('doe'))
    assert_equal([@person2], @repository.get_by_part_name('jane'))
  end

  def test_get_by_date_range
    @repository.add_person(@person1)
    @repository.add_person(@person2)
    assert_equal([@person1], @repository.get_by_date_range(nil, '1985-01-01'))
    assert_equal([@person2], @repository.get_by_date_range('1985-01-01', nil))
    assert_equal([@person1, @person2], @repository.get_by_date_range(nil, nil))
  end
end
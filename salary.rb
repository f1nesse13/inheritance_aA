class Employee
  attr_reader :name, :title, :salary
  attr_accessor :boss
  
  def initialize(name, title, salary, boss=nil)
    @name, @title, @salary = name, title, salary
    self.boss = boss
  end 


  def boss=(boss)
    @boss = boss
    boss.add_employee(self) unless boss.nil?
    boss
  end

  def bonus(multiplier)
    self.salary * multiplier
  end

end

class Manager < Employee
  attr_reader :employees
  def initialize(name, title, salary, boss=nil)
    super
    @employees = []
  end

  def add_employee(employee)
    self.employees << employee
  end

  def bonus(multiplier)
    sum = 0
    if self.employees.length != 0
      self.employees.each do |employee|
        if employee.is_a?(Manager)
          sum += employee.salary
          employee.employees.each { |sub_employee| sum += sub_employee.salary  }
        else
          sum += employee.salary
        end
      end
    end
    return (sum * multiplier)
  end
  
end

ned = Manager.new("ned", "Manager", 1000000)
darren = Manager.new("darren", "TA", 78000, ned)
shawna = Employee.new("shawna", "TA", 12000, darren)
david = Employee.new("david", "TA", 10000, darren)
p ned.bonus(5)
p darren.bonus(4)
p david.bonus(3)

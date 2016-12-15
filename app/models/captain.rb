class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: :classifications).where(classifications: { name: "Catamaran" })
  end

  def self.sailors
    self.joins(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboaters
    self.joins(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  def self.talented_seamen
    # self.joins(boats: :classifications).where(classifications: {name: "Sailboat"}) or where.(classifications: {name: "Motorboat"})
    self.where('id IN (?)', self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  end

  def self.non_sailors
    # self.joins(boats: :classifications).where.not(classifications: {name: "Sailboat"}).uniq
    self.where.not('id IN (?)', self.sailors.pluck(:id))
  end
end

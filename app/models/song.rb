class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: { scope: %i[artist_name release_year] }
  validates :released, inclusion: { in: [true, false] }
  validates :artist_name, presence: true
  with_options if: :released? do |instance|
    instance.validates :release_year, presence: true
    instance.validates :release_year, numericality: { less_than_or_equal_to: Date.today.year }
  end

  def released?
    released
  end
end

module HallsHelper
  def capacity_label(hall)
    return 'small' if hall.capacity <= 5
    return 'medium' if hall.capacity <= 10
    return 'large' if hall.capacity <= 20
    'extra large'
  end
end

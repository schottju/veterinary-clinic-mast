class PictureDecorator < Draper::Decorator
  delegate_all

  def print_animal_id
    "#{animal_id.nil? ? 'Brak przypisanego zwierzęcia' : (self.try(:animal).try(:id_number).blank? ? 'Brak numeru id zwierzęcia': picture.try(:animal).try(:id_number))}"
  end
end

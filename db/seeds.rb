#Patients
edward = User.new(first_name: 'Edward', last_name: 'Wojtak', email: 'daktyr@o2.pl', pesel: '12345678911', phone_number: '123456781', role: :pacjent, password: 'password', password_confirmation: 'password')
edward.skip_confirmation!
edward.save!

justyna = User.new(first_name: 'Justyna', last_name: 'Kowal', email: 'pacjent@example.com', pesel: '12345678912', phone_number: '123456782', role: :pacjent, password: 'password', password_confirmation: 'password')
justyna.skip_confirmation!
justyna.save!

jan = User.new(first_name: 'Jan', last_name: 'Nowak', email: 'jan@example.com', pesel: '12345678913', phone_number: '123456783', role: :pacjent, password: 'password', password_confirmation: 'password')
jan.skip_confirmation!
jan.save!

#Veterinarians
veterinarian_user = User.new(first_name: 'Adam', last_name: 'Winiarczyk', email: 'weterynarz@example.com', pesel: '12345678901', phone_number: '123456789', role: :'Vétérinaire', password: 'password', password_confirmation: 'password')
veterinarian_user.skip_confirmation!
veterinarian_user.save!

veterinarian = Veterinarian.create!(title: 'lek. wet.', specialization: 'zwierzęta hodowlane', pwz: '01234', user_id: veterinarian_user.id)

#Working days
WorkingDay.create!(monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, veterinarian_id: veterinarian.id)

#Vacations
Vacation.create!(start: Date.today + 5.days, end: Date.today + 5.days, veterinarian_id: veterinarian.id)
Vacation.create!(start: Date.today + 25.days, end: Date.today + 37.days, veterinarian_id: veterinarian.id)
Vacation.create!(start: Date.today + 11.days, end: Date.today + 15.days, veterinarian_id: veterinarian.id)
Vacation.create!(start: Date.today + 21.days, end: Date.today + 23.days, veterinarian_id: veterinarian.id)
Vacation.create!(start: Date.today + 26.days, end: Date.today + 33.days, veterinarian_id: veterinarian.id)
Vacation.create!(start: Date.today + 41.days, end: Date.today + 45.days, veterinarian_id: veterinarian.id)
Vacation.create!(start: Date.today + 61.days, end: Date.today + 72.days, veterinarian_id: veterinarian.id)
Vacation.create!(start: Date.today + 81.days, end: Date.today + 83.days, veterinarian_id: veterinarian.id)

#Admin
admin = User.new(first_name: 'Admin', last_name: 'Administrator', email: 'administrator@example.com', pesel: '12345678900', phone_number: '123456780', role: :admin, password: 'password', password_confirmation: 'password')
admin.skip_confirmation!
admin.save!

#Adresy
Address.create!(street: 'Kilińskiego', house_number: '12', flat_number: '44', zip_code: '37-400', city: 'Nisko', borough: 'Nisko', district: 'niżański', province: 'podkarpackie', country: 'PL', user_id: edward.id)
Address.create!(street: 'Kościuszki', house_number: '4A', flat_number: '5', zip_code: '37-400', city: 'Nisko', borough: 'Nisko', district: 'niżański', province: 'podkarpackie', country: 'PL', user_id: justyna.id)
Address.create!(street: 'Bema', house_number: '123', flat_number: '', zip_code: '37-400', city: 'Nisko', borough: 'Nisko', district: 'niżański', province: 'podkarpackie', country: 'PL', user_id: jan.id)
Address.create!(street: 'Krótka', house_number: '22', flat_number: '', zip_code: '37-400', city: 'Nisko', borough: 'Nisko', district: 'niżański', province: 'podkarpackie', country: 'PL', user_id: veterinarian_user.id)
Address.create!(street: 'Adminowa', house_number: '12', flat_number: '3', zip_code: '37-400', city: 'Nisko', borough: 'Nisko', district: 'niżański', province: 'podkarpackie', country: 'PL', user_id: admin.id)

#Species
kot = Species.create!(name: 'kot')
pies = Species.create!(name: 'pies')
krowa = Species.create!(name: 'krowa')
swinia = Species.create!(name: 'świnia')
kura = Species.create!(name: 'kura')
Species.create!(name: 'królik')
Species.create!(name: 'indyk')
Species.create!(name: 'kaczka')
koń = Species.create!(name: 'koń')
Species.create!(name: 'owca')
Species.create!(name: 'koza')
ryba = Species.create!(name: 'ryba')
pszczola = Species.create!(name: 'pszczoła')

#Units
Unit.create!(name: 'kg')
g_unit = Unit.create!(name: 'g')
Unit.create!(name: 'mg')
Unit.create!(name: 'l')
ml_unit = Unit.create!(name: 'ml')
Unit.create!(name: 'szt.')

#Diseases
Disease.create!(name: 'Kolka brzuszna')
Disease.create!(name: 'Wzdęcie')
Disease.create!(name: 'Ochwat kopytowy')
Disease.create!(name: 'Mięśniochwat')
Disease.create!(name: 'Zapalenie wymienia')
Disease.create!(name: 'Różyca')
Disease.create!(name: 'Zatrucie pokarmowe')
Disease.create!(name: 'Zapalenie jelit ślepych')
Disease.create!(name: 'Dna moczanowa')
Disease.create!(name: 'Ektopasożyty')
Disease.create!(name: 'Endopasożyty')
Disease.create!(name: 'Nosówka')
Disease.create!(name: 'Zapalenie spojówek')
Disease.create!(name: 'Zapalenie ucha')
Disease.create!(name: 'Warroza')

#Treatments
Treatment.create!(name: 'Poród', cost: 300, description: 'Odebranie porodu')
Treatment.create!(name: 'Porada', cost: 50, description: 'Porada lekarska')
Treatment.create!(name: 'Diagnostyka', cost: 50, description: 'Rozpoznanie choroby')
Treatment.create!(name: 'Szczepienie', cost: 20, description: 'Wykonanie szczepienia')
Treatment.create!(name: 'Badania I', cost: 50, description: 'Podstawowe badania')
Treatment.create!(name: 'Badania II', cost: 50, description: 'Badania uzupełniające')
Treatment.create!(name: 'Pobranie próbki', cost: 50, description: 'Pobranie próbki do badań laboratoryjnych')
Treatment.create!(name: 'Cesarka', cost: 1000, description: 'Cesarskie cięcie')
Treatment.create!(name: 'Kastracja I', cost: 500, description: 'Kastracja ogiera')
Treatment.create!(name: 'Kastracja II', cost: 200, description: 'Kastracja knura')
Treatment.create!(name: 'Przepuklina', cost: 100, description: 'Operacja przepukliny')
Treatment.create!(name: 'Trokarowanie', cost: 250, description: 'Przebicie powlok brzusznych i żwacza')
Treatment.create!(name: 'Sondowanie', cost: 200, description: 'Wprowadzenie sondy')
Treatment.create!(name: 'Kosmetyka I', cost: 50, description: 'Obcięcie pazurów u zwierząt domowych')
Treatment.create!(name: 'Kosmetyka II', cost: 100, description: 'Strzyżenie zwierząt domowych')

#Animals
krowa_zwierze = Animal.create!(id_number: 'PL1234566', name: 'Miła', birth_date: Date.new(2011, 9, 15), age: Date.today.year - Date.new(2011, 9, 15).year, amount: 1, weight: '', gender: :samica, description: 'W czarne łaty', user_id: justyna.id, species_id: krowa.id)
kury_zwierze = Animal.create!(id_number: 'PL2134245', amount: 13, gender: :mieszana, description: 'Kury w różnym wieku', user_id: justyna.id, species_id: kura.id)
Animal.create!(id_number: 'PL5234534', amount: 20, weight: 100, gender: :mieszana, age: 2, description: 'Mieszane stado w różnym wieku, waga od 100 do 150 kg', user_id: justyna.id, species_id: swinia.id)
Animal.create!(id_number: 'PL13434NN', name: 'Burek', birth_date: Date.new(2010, 11, 15), amount: 1, weight: 2.5, gender: :samiec, age: Date.today.year - Date.new(2010, 11, 15).year, description: 'Bury kot', user_id: justyna.id, species_id: kot.id)
pies_zwierze = Animal.create!(id_number: 'PL1234123', name: 'Amik', birth_date: Date.new(2011, 6, 20), amount: 1, weight: 5, gender: :samiec, age: Date.today.year - Date.new(2011, 6, 20).year, description: 'Czarny podpalany jamnik', user_id: justyna.id, species_id: pies.id)
Animal.create!(id_number: 'PLDSA2333', amount: 100, gender: :mieszana, description: 'Tegoroczne karpie', user_id: justyna.id, species_id: ryba.id)
Animal.create!(id_number: 'PL2345SFD', amount: 500, gender: :mieszana, description: 'Cztery ule pszczół', user_id: justyna.id, species_id: pszczola.id)
Animal.create!(id_number: 'PL34554DD', name: 'Mruczek', birth_date: Date.new(2012, 5, 23), amount: 1, weight: 4, gender: :samiec, age: Date.today.year - Date.new(2012, 5, 23).year, description: 'Rudy perski kot', user_id: jan.id, species_id: kot.id)
Animal.create!(id_number: 'PL34234DS', name: 'Kiepski', birth_date: Date.new(2007, 3, 22), amount: 1, weight: 10, gender: :samiec, age: Date.today.year - Date.new(2007, 3, 22).year, description: 'Czarny doberman', user_id: jan.id, species_id: pies.id)
Animal.create!(id_number: 'PL123A233', name: 'Rafał', birth_date: Date.new(2009, 4, 18), amount: 1, weight: 900, gender: :samiec, age: Date.today.year - Date.new(2009, 4, 18).year, description: 'Koń wyścigowy pełnej krwi', user_id: jan.id, species_id: koń.id)

# #Appointments
Appointment.create!(status: :zatwierdzona, kind: 'w klinice', user_id: justyna.id, veterinarian_id: veterinarian.id, day: Date.today + 2.days, time: :rano, description: 'Obcięcie pazurków')
Appointment.create!(status: :zatwierdzona, kind: 'w klinice', user_id: justyna.id, veterinarian_id: veterinarian.id, day: Date.today - 6.days, time: :wieczorem, description: 'Strzyżenie psa')
Appointment.create!(status: :zatwierdzona, kind: :domowa, user_id: justyna.id, veterinarian_id: veterinarian.id, day: Date.today + 10.days, time: :rano, description: 'Szczepienie  przeciwko wściekliźnie')
Appointment.create!(status: :niezatwierdzona, kind: 'w klinice', user_id: justyna.id, veterinarian_id: veterinarian.id, day: Date.today + 20.days, time: :wieczorem, description: 'Kastrowanie knura')
Appointment.create!(status: :zatwierdzona, kind: 'w klinice', user_id: justyna.id, veterinarian_id: veterinarian.id, day: Date.today + 60.days, time: :rano, description: 'Kastrowanie ogiera')
Appointment.create!(status: :zatwierdzona, kind: :domowa, user_id: jan.id, veterinarian_id: veterinarian.id, day: Date.today + 6.days, time: :rano, description: 'Obcięcie pazurków u kota')
Appointment.create!(status: :zatwierdzona, kind: 'w klinice', user_id: jan.id, veterinarian_id: veterinarian.id, day: Date.today + 7.days, time: 'w południe', description: 'Strzyżenie psa')
Appointment.create!(status: :niezatwierdzona, kind: :domowa, user_id: jan.id, veterinarian_id: veterinarian.id, day: Date.today + 120.days, time: :wieczorem, description: 'Kastrowanie knura')
Appointment.create!(status: :zatwierdzona, kind: 'w klinice', user_id: justyna.id, veterinarian_id: veterinarian.id, day: Date.today + 55.days, time: :rano, description: 'Obcięcie pazurków u kota')
Appointment.create!(status: :zatwierdzona, kind: 'w klinice', user_id: justyna.id, veterinarian_id: veterinarian.id, day: Date.today - 100.days, time: :wieczorem, description: 'Strzyżenie kota')

#Pictures
picture1 = Picture.create!(name: 'RTG jamy brzusznej krowy', description: 'Widoczne wzdęcie', image: File.open(Rails.root + "app/assets/images/cow1.jpg"), user_id: justyna.id, animal_id: krowa_zwierze.id)
Picture.create!(name: 'RTG psa', description: 'Brak nieprawidłowości', image: File.open(Rails.root + "app/assets/images/dog1.jpg"), user_id: justyna.id, animal_id: pies_zwierze.id)
Picture.create!(name: 'RTG psa', description: 'Widoczne ciało obce w żołądku', image: File.open(Rails.root + "app/assets/images/dog2.jpg"), user_id: justyna.id, animal_id: pies_zwierze.id)
Picture.create!(name: 'RTG psa', description: 'Brak nieprawidłowości', image: File.open(Rails.root + "app/assets/images/dog3.jpg"), user_id: justyna.id, animal_id: pies_zwierze.id)
Picture.create!(name: 'RTG psa', description: 'Widoczne ciało obce w żołądku', image: File.open(Rails.root + "app/assets/images/dog4.jpg"), user_id: justyna.id, animal_id: pies_zwierze.id)


#Medicines
tympachol = Medicine.create!(name: 'Tympachol', description: 'Stosowany przy wzdęciach', amount: 250, grace_period: 0, price: 30, serial_number: '231521522', dosage: '', unit_id: ml_unit.id)
Medicine.create!(name: 'Mastisan', description: 'Leczenie klinicznych i podklinicznych zapaleń wymienia u krów w okresie laktacji', amount: 80, grace_period: 3, price: 48, serial_number: '245245245', dosage: 'Wycisnąc po 20g (jedna tubka) do każdego gruczołu mlecznego', unit_id: g_unit.id)
Medicine.create!(name: 'Maść Jodo-kamforowa', description: 'Zmniejsza zapalenie i opuchliznę', amount: 150, grace_period: 0, price: 30, serial_number: '2543253225', dosage: 'Smarować każde wymię 2 razy dziennie przez 3-5 dni', unit_id: g_unit.id)
sulfatyf = Medicine.create!(name: 'Sulfatyf', description: 'Proszek do sporządzania roztworu doustnego dla kur i indyków', amount: 50, grace_period: 0, price: 35, serial_number: '342543345', dosage: '1-3g na litr wody do picia przez 7 dni', unit_id: g_unit.id)

#Medical records
medical_record_01 = MedicalRecord.new(anamnesis: 'Krowa po zjedzeniu zielonki oraz ziemniaków kładzie się, postękuje, jest niespokojna, widocznie uwypuklone powłoki brzuszne', description: 'Wypompowano gazy oraz podano lek za pomocą sondy', comment: 'Po wykonaniu zabiegu objawy ustąpiły, zaobserwowano poprawę', user_id: justyna.id, veterinarian_id: veterinarian.id, additional_cost: 50)
medical_record_01.medicines << tympachol
medical_record_01.treatments << Treatment.where(name: 'Sondowanie')
medical_record_01.animals << krowa_zwierze
medical_record_01.pictures << picture1
medical_record_01.diseases << Disease.where(name: 'Wzdęcie')
medical_record_01.save!

medical_record_02 = MedicalRecord.new(anamnesis: 'Wymię bardzo spuchnięte, mleko z domieszką skrzepów, zmieniony kolor mleka, brak apetytu', description: 'Podano lek do każdego gruczołu mlecznego', comment: 'Objawy powinny zacząć ustępować po 3 dniach od podania leku. Całkowite ustąpienie objawów nastąpi po 3-5 dniach od zaczęcia smarowania wymion maścią.', user_id: justyna.id, veterinarian_id: veterinarian.id, additional_cost: 30)
medical_record_02.medicines << Medicine.where(name: [ 'Mastisan', 'Maść Jodo-kamforowa' ])
medical_record_02.treatments << Treatment.where(name: 'Diagnostyka')
medical_record_02.animals << krowa_zwierze
medical_record_02.diseases << Disease.where(name: 'Zapalenie wymienia')
medical_record_02.save!

medical_record_03 = MedicalRecord.new(anamnesis: 'Biegunka z domieszką krwi, senność', description: 'Przepisano lek', comment: 'Po 4 dniach od podania leku nastąpi poprawa stanu zdrowia', user_id: justyna.id, veterinarian_id: veterinarian.id, additional_cost: 0)
medical_record_03.medicines << sulfatyf
medical_record_03.treatments << Treatment.where(name: 'Porada')
medical_record_03.animals << kury_zwierze
medical_record_03.diseases << Disease.where(name: 'Zapalenie jelit ślepych')
medical_record_03.save!

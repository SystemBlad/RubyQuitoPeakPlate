require 'date'
require 'time'

#BEGIN======VEHICLE CLASS========
class VehicleClass
	
	def initialize(plateNumber)
		@plateNumber = plateNumber
		@parsed_time = DateTime.now
	end

	def getPlateNumber()
		return @plateNumber
	end


	def IcanDriveTheVehicle(dateInput,timeInput)

		plateLastChar  = @plateNumber.split(//).last(1).join


		@parsed_time = DateTime.strptime(dateInput + " " + timeInput, '%d/%m/%Y %H:%M')

		firstDateMorning = DateTime.strptime(dateInput + " " + '7:00', '%d/%m/%Y %H:%M')
		lastDateMorning = DateTime.strptime(dateInput + " " + '9:30', '%d/%m/%Y %H:%M')


		firstDateAffternoon = DateTime.strptime(dateInput + " " + '16:00', '%d/%m/%Y %H:%M')
		lastDateAffternoon = DateTime.strptime(dateInput + " " + '19:30', '%d/%m/%Y %H:%M')

		isHourPeakPlate = false

		if @parsed_time >= firstDateMorning && @parsed_time <= lastDateMorning 
			isHourPeakPlate = true
		end

		if @parsed_time >= firstDateAffternoon && @parsed_time <= lastDateAffternoon 
			isHourPeakPlate = true
		end

		weekday = @parsed_time.wday

		case plateLastChar
		when '1', '2'
			if weekday === 1 && isHourPeakPlate
				return false
			end
		when '3', '4'
			if weekday === 2 && isHourPeakPlate
				return false
			end			
		when '5', '6'
			if weekday === 3 && isHourPeakPlate
				return false
			end	
		when '7', '8'
			if weekday === 4 && isHourPeakPlate
				return false
			end				
		when '9', '0'
			if weekday === 5 && isHourPeakPlate
				return false
			end				
		else
		   puts 'Placa Incorrecta'

		end
		return true
	end

end
#END======VEHICLE CLASS========

#BEGIN======MAIN PROGRAM========
plateNumber = ""

while plateNumber === "" || plateNumber.length < 6	|| plateNumber.length > 7
	puts "Ingrese el número de Placa (6 o 7 digitos)"
	plateNumber = gets.chomp
	if plateNumber === "" || plateNumber.length < 6	|| plateNumber.length > 7
		puts "Placa Invalida"
	end
end

vehicleObject = VehicleClass.new(plateNumber)

puts "Ingrese Fecha 'DD/MM/YYYY'"
dateString = gets.chomp


puts "Ingrese la Hora 'HH:MM'"
timeString = gets.chomp


invalidDate = false

begin 
	DateTime.strptime(dateString + " " + timeString, '%d/%m/%Y %H:%M') 
rescue 
	invalidDate = true
end

if !invalidDate
	if vehicleObject.IcanDriveTheVehicle(dateString, timeString)
		puts 'Puede conducir su vehículo placa: ' + vehicleObject.getPlateNumber()
	else
		puts 'NO puede conducir su vehículo placa: ' + vehicleObject.getPlateNumber()
	end
else
	puts "Fecha u Hora Invalidas"
end

#END======MAIN PROGRAM========

#BEGIN======UNIT TESTING========
puts "UNIT TEST"
require 'test/unit'
 
class PeakPlateTest < Test::Unit::TestCase
  def test_de_verdad 

  	#For Plate Number ends in 3, day Tuesday
    vehicleObjectTest = VehicleClass.new('PCH2033')
	assert_equal true, vehicleObjectTest.IcanDriveTheVehicle('07/04/2015','15:30')
	assert_equal true, vehicleObjectTest.IcanDriveTheVehicle('07/04/2015','06:30')
	assert_equal false, vehicleObjectTest.IcanDriveTheVehicle('07/04/2015','16:30')
	assert_equal false, vehicleObjectTest.IcanDriveTheVehicle('07/04/2015','08:30')	

	#For Plate Number ends in 2, day tuesday
    vehicleObjectTest = VehicleClass.new('PCH2032')
	assert_equal true, vehicleObjectTest.IcanDriveTheVehicle('07/04/2015','15:30')
	assert_equal true, vehicleObjectTest.IcanDriveTheVehicle('07/04/2015','06:30')
	assert_equal true, vehicleObjectTest.IcanDriveTheVehicle('07/04/2015','16:30')
	assert_equal true, vehicleObjectTest.IcanDriveTheVehicle('07/04/2015','08:30')

	#For Plate Number ends in 2, day Monday
    vehicleObjectTest = VehicleClass.new('PCH2032')
	assert_equal true, vehicleObjectTest.IcanDriveTheVehicle('06/04/2015','15:30')
	assert_equal true, vehicleObjectTest.IcanDriveTheVehicle('06/04/2015','06:30')
	assert_equal false, vehicleObjectTest.IcanDriveTheVehicle('06/04/2015','16:30')
	assert_equal false, vehicleObjectTest.IcanDriveTheVehicle('06/04/2015','08:30')

	#For Plate Number ends in 0, day Friday
    vehicleObjectTest = VehicleClass.new('PCH2030')
	assert_equal true, vehicleObjectTest.IcanDriveTheVehicle('10/04/2015','15:30')
	assert_equal true, vehicleObjectTest.IcanDriveTheVehicle('10/04/2015','06:30')
	assert_equal false, vehicleObjectTest.IcanDriveTheVehicle('10/04/2015','16:30')
	assert_equal false, vehicleObjectTest.IcanDriveTheVehicle('10/04/2015','08:30')

	#For Plate Number ends in 5, day Friday
    vehicleObjectTest = VehicleClass.new('PCH1045')
	assert_equal true, vehicleObjectTest.IcanDriveTheVehicle('10/04/2015','15:30')
	assert_equal true, vehicleObjectTest.IcanDriveTheVehicle('10/04/2015','06:30')
	assert_equal true, vehicleObjectTest.IcanDriveTheVehicle('10/04/2015','16:30')
	assert_equal true, vehicleObjectTest.IcanDriveTheVehicle('10/04/2015','08:30')

	#For Plate Number ends in 5, day Wednesday
    vehicleObjectTest = VehicleClass.new('PCH1045')
	assert_equal true, vehicleObjectTest.IcanDriveTheVehicle('8/04/2015','15:30')
	assert_equal true, vehicleObjectTest.IcanDriveTheVehicle('8/04/2015','06:30')
	assert_equal false, vehicleObjectTest.IcanDriveTheVehicle('8/04/2015','16:30')
	assert_equal false, vehicleObjectTest.IcanDriveTheVehicle('8/04/2015','08:30')		

  end
end
#END======UNIT TESTING========

#include "p16f84.inc"

c_array_base set 0x010
c_array_size set 0xA
c_eeprom_location set 0x0

v_i equ 0x0c

org 0x2100
str de "BSUIR-POVS"
org 0x0
	
	GOTO BEGIN	

COPY_FROM_EEPROM:
	MOVLW c_array_size
	MOVWF v_i
	MOVLW c_eeprom_location-1
	MOVWF EEADR
	MOVLW c_array_base-1
	MOVWF FSR

LOOP:
	INCF EEADR, F
	INCF FSR, F

	BSF STATUS, RP0
	BSF EECON1, RD
	BCF STATUS, RP0

	MOVF EEDATA, W

	MOVWF INDF

	DECFSZ v_i, F
	GOTO LOOP	

	RETURN

BEGIN:
	CALL COPY_FROM_EEPROM
	
	end

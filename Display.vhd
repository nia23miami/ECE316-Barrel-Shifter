Library ieee;
Use ieee.std_logic_signed.All;
Use ieee.std_logic_1164.All;

Entity Display Is
	Port (
		Input : In std_logic_vector(3 Downto 0); --input from calc
	    segmentSeven : Out std_logic_vector(6 Downto 0)); --7 bit output end Display_Ckt;
End Display;

Architecture behav_display Of Display Is
Begin
	Process (Input)
	Begin
		Case Input Is
			When"0000" => segmentSeven <= "0000001"; -- 0
			When"0001" => segmentSeven <= "1001111"; -- 1
			When"0010" => segmentSeven <= "0010010"; -- 2
			When"0011" => segmentSeven <= "0000110"; -- 3
			When"0100" => segmentSeven <= "1001100"; -- 4
			When"0101" => segmentSeven <= "0100100"; -- 5
			When"0110" => segmentSeven <= "0100000"; -- 6
			When"0111" => segmentSeven <= "0001111"; -- 7
			When"1000" => segmentSeven <= "0000000"; -- 8
			When"1001" => segmentSeven <= "0000100"; -- 9
			When"1010" => segmentSeven <= "0001000"; -- 10 A
			When"1011" => segmentSeven <= "1100000"; -- 11 b
			When"1100" => segmentSeven <= "0110001"; -- 12 c
			When"1101" => segmentSeven <= "1000010"; -- 13 d
			When"1110" => segmentSeven <= "0110000"; -- 14 e
			When"1111" => segmentSeven <= "0111000"; -- 15 f
			When Others =>segmentSeven <= "1111111";
		End Case;
	End Process;
End behav_display;

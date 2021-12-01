library IEEE;
use ieee . std_logic_1164 . all;
use IEEE . numeric_std . all;
entity shift_array is
	port (	DIN : in std_logic_vector (15 downto 0);
		highlow : in std_logic;
		c : in std_logic_vector (7 downto 0);
		x : in std_logic;
		Dout : out std_logic_vector (31 downto 0) );
end shift_array;

architecture behave of shift_array is
	signal vector_to_integer : integer;
	signal low_ref : std_logic_vector (31 downto 0);
	signal high_ref : std_logic_vector (31 downto 0);
begin
	c1 : process (DIN, c)
	begin
		low_ref <= x&x&x&x&x&x&x&x&x&x&x&x&x&x&x&x & DIN;
		high_ref <= DIN & "0000000000000000";
		vector_to_integer <= to_integer (to_unsigned (to_integer (unsigned(c(6 downto 0))), 8));
	end process;
	-- highlow
	-- 1= high_ref
	-- 0= lowbigger
	-- control
	-- left =0
	-- right =1
	--x =1 signed
	--x =0 unsigned
	c3 : process (high_ref, low_ref, c, highlow)
	begin
		if (x = '0' and c(7) = '1' and highlow = '1') then
			Dout <= std_logic_vector (shift_right (unsigned (high_ref), vector_to_integer));
		elsif (x = '0' and c(7) = '1' and highlow = '0') then
			Dout <= std_logic_vector (shift_right (unsigned (low_ref), vector_to_integer));
		elsif (x = '0' and c(7) = '0' and highlow = '1') then
			Dout <= std_logic_vector (shift_left (unsigned (high_ref), vector_to_integer));
		elsif (x = '0' and c(7) = '0' and highlow = '0') then
			Dout <= std_logic_vector (shift_left (unsigned (low_ref), vector_to_integer));
		elsif (x = '1' and c(7) = '1' and highlow = '1') then
			Dout <= std_logic_vector (shift_right (signed (high_ref), vector_to_integer));
		elsif (x = '1' and c(7) = '1' and highlow = '0') then
			Dout <= std_logic_vector (shift_right (signed (low_ref), vector_to_integer));
		elsif (x = '1' and c(7) = '0' and highlow = '1') then
			Dout <= std_logic_vector (shift_left (signed (high_ref), vector_to_integer));
		elsif (x = '1' and c(7) = '0' and highlow = '0') then
			Dout <= std_logic_vector (shift_left (signed (low_ref), vector_to_integer));
		end if;
	end process;
end architecture behave;

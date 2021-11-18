library IEEE;
use IEEE . STD_LOGIC_1164 . all;
entity mux is
	port (	SEL0 : in STD_LOGIC;
		A : in STD_LOGIC_VECTOR (15 downto 0);
		B : in STD_LOGIC_VECTOR (15 downto 0);
		X : out STD_LOGIC_VECTOR (15 downto 0) );
end mux;

architecture Behavioral of mux is
begin
	process (SEL0, A, B)
	begin
		if (SEL0 = '1') then
			X <= A;
		else
			x <= B;
		end if;
	end process;
end Behavioral;
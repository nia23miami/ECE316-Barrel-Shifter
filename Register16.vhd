library ieee;
use ieee . std_logic_1164 . all;
use ieee . std_logic_signed . all;
entity Register16 is
	port (	Inp : in std_logic_vector (15 downto 0);
		Load, Clk : in std_logic;
		outp : out std_logic_vector (15 downto 0) );
end Register16;

architecture behav of Register16 is
	signal storage : std_logic_vector (15 downto 0);
begin
	process (Inp, Load, Clk)
	begin
		if (Clk'event and Clk = '1' and Load = '1') then
			storage <= Inp;
		elsif (Clk'event and Clk = '0') then
			Outp <= storage;
		end if;
	end process;
end behav;
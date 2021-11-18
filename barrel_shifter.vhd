library IEEE;
use IEEE . std_logic_1164 . all;
use IEEE . std_logic_arith . all;

entity barrel_shifter is
	port (	DIN : inout std_logic_vector (15 downto 0); -- DIN bus
		R : inout std_logic_vector (15 downto 0); --R bus
		C : in std_logic_vector (7 downto 0); -- Control Code
		High_low : in std_logic; -- Reference bit
		x : in std_logic;
		sror : in std_logic;
		load : in std_logic_vector (2 downto 0); -- amf function code
		fullout : out std_logic_vector (31 downto 0);
		sel : std_logic_vector (3 downto 0); -- multiplexer select line
		ctr : std_logic_vector (3 downto 0); -- Tri state buffer
		clk : std_logic ); -- clock
end barrel_shifter;

architecture behav of barrel_shifter is
	component shift_array
		port (	DIN : in std_logic_vector (15 downto 0);
			highlow : in std_logic;
			control : in std_logic_vector (7 downto 0);
			x : in std_logic;
			Dout : out std_logic_vector (31 downto 0) );
	end component;
	component tri_state
		port (	input : in std_logic_vector (15 downto 0);
			enable : in std_logic;
			output : out std_logic_vector (15 downto 0) );
	end component;
	component mux
		port (	SEL0 : in STD_LOGIC;
			A : in STD_LOGIC_VECTOR (15 downto 0);
			B : in STD_LOGIC_VECTOR (15 downto 0);
			X : out STD_LOGIC_VECTOR (15 downto 0) );
	end component;
	component register16
		port (	Inp : in std_logic_vector (15 downto 0);
			Load, Clk : in std_logic;
			outp : out std_logic_vector (15 downto 0) );
	end component;

	signal register_SI_output : STD_LOGIC_VECTOR (15 downto 0);
	signal mux_SI_output : STD_LOGIC_VECTOR (15 downto 0);
	signal shifterarray_output : STD_LOGIC_VECTOR (31 downto 0);
	signal mux_S1_output : STD_LOGIC_VECTOR (15 downto 0);
	signal mux_S0_output : STD_LOGIC_VECTOR (15 downto 0);
	signal register_S1_output : STD_LOGIC_VECTOR (15 downto 0);
	signal register_S0_output : STD_LOGIC_VECTOR (15 downto 0);
	signal mux_feedback_output : STD_LOGIC_VECTOR (15 downto 0);
	signal orpass_out : STD_LOGIC_VECTOR (31 downto 0);
	signal orpass_or : STD_LOGIC_VECTOR (31 downto 0);
begin
	SIRegister : Register16 port map(DIN, load (0), clk, register_SI_output);
	Buffer_feeback_top : tri_state port map(register_SI_output, Ctr (0), DIN);
	Mux_SI : mux port map(Sel (0), register_SI_output, R, mux_SI_output);
	ShifterArray : shift_array port map(mux_SI_output, High_low, C, x, shifterarray_output);
	Mux_S1 : mux port map(Sel (1), orpass_out (31 downto 16), DIN, mux_S1_output);
	Mux_S0 : mux port map(Sel (2), orpass_out (15 downto 0), DIN, mux_S0_output);
	Register_S1 : Register16 port map(mux_S1_output, Load (1), clk, register_S1_output);
	Register_S0 : Register16 port map(mux_S0_output, Load (2), clk, register_S0_output);
	Buffer_S1 : tri_state port map(register_S1_output, Ctr (1), R);
	Buffer_S0 : tri_state port map(register_S0_output, Ctr (2), R);
	Mux_feedback : mux port map(Sel (3), register_S1_output, register_S0_output, mux_feedback_output);
	Buffer_feeback_bottom : tri_state port map(mux_feedback_output, Ctr (3), DIN);
	
	process (sror)
	begin
		if (sror = '1') then
			orpass_out <= orpass_or;
		else
			orpass_out <= shifterarray_output;
		end if;
	end process;

	fullout <= shifterarray_output;
	orpass_or <= shifterarray_output or (register_s1_output & register_s0_output);
	
end behav;
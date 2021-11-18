library IEEE;
use IEEE . std_logic_1164 . all;
use IEEE . std_logic_arith . all;

entity demo_barrel_shifter is
    port ( sl : in std_logic_vector (3 downto 0);
        ld : in std_logic_vector (2 downto 0);
        cl : in std_logic_vector (1 downto 0);
        hl : in std_logic;
        clock : in std_logic;
        xin : in std_logic;
        leds : out std_logic_vector (7 downto 0);
        sevseg6 : out std_logic_vector (6 downto 0);
        sevseg5 : out std_logic_vector (6 downto 0);
        sevseg4 : out std_logic_vector (6 downto 0);
        sevseg3 : out std_logic_vector (6 downto 0);
        sevseg2 : out std_logic_vector (6 downto 0);
        sevseg1 : out std_logic_vector (6 downto 0) );
end demo_barrel_shifter;

architecture behav of demo_barrel_shifter is
	component barrel_shifter is
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
    end component;
	component Display Is
	Port (
		Input : In std_logic_vector(3 Downto 0); --input from calc
	    segmentSeven : Out std_logic_vector(6 Downto 0)); --7 bit output end Display_Ckt;
    end component;


    signal SI : std_logic_vector (15 downto 0);
	signal full : STD_LOGIC_VECTOR (31 downto 0);
    signal control : std_logic_vector (3 downto 0);
    signal R : std_logic_vector (15 downto 0);

begin
    bs : barrel_shifter port map (SI,R,"10000101",hl,xin,'0',ld,full,sl,control,clock);
	display6 : display port map (full (23 downto 20), sevseg6);
    display5 : display port map (full (19 downto 16), sevseg5);
    display4 : display port map (full (15 downto 12), sevseg4);
    display3 : display port map (full (11 downto 8), sevseg3);
    display2 : display port map (full (7 downto 4), sevseg2);
    display1 : display port map (full (3 downto 0), sevseg1);
    
    control <= "00" & cl;
    leds <= full (31 downto 24);
end behav;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity count_display is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           btn_event : in STD_LOGIC;
           leds : out STD_LOGIC_VECTOR (3 downto 0);
           sevenseg : out STD_LOGIC_VECTOR (6 downto 0);
           anode: out STD_LOGIC_VECTOR (3 downto 0));
end count_display;

architecture Behavioral of count_display is
 signal count_sig: STD_LOGIC_VECTOR (3 downto 0) := "0000";
 signal slow_clk: STD_LOGIC := '0';
begin
    --complete the architecture
    -- instantiate and port map the three components - clk_div, modMcounter and hex_7seg modules
    --refer to the block diagram in lab handout
    -- use the signals declared above in this architecture to wire between components (internally)
    --dont forget to include the generic map in addition to port map
    
   Debounce_Inst: entity work.button_debounce
   generic map (
   STABLE_CYCLES => 2_000_000
   )
   port map (
   clk_in => clock,
   reset => reset,
   btn_in => btn_event,
   btn_db => slow_clk
   );
    
-- onesec: entity work.clk_div
-- generic map (
-- clk_in_freq => 100000000,
-- clk_out_freq => 1
-- )
-- port map (
-- reset => reset,
-- clk_in => clock,
-- clk_out => slow_clk
-- );
 
ModM: entity work.modMcounter
generic map (
n => 4
)
port map(
reset => reset,
clk => slow_clk,
count => count_sig
);

Hex7: entity work.hex_7seg
port map(
hexdigit => count_sig,
seg => sevenseg
);
 
 leds <= count_sig;
 anode <= "1110";
end Behavioral;

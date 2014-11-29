library ieee;
use ieee.std_logic_1164.all;

entity ula_tb is
end ula_tb;

architecture ula_tb of ula_tb is
	signal sclk, sclr, svalid, sdo_op, sclkout: std_logic;
	signal sswitches: std_logic_vector (15 downto 0);
	signal ssave, sdonext, sreset: std_logic;
	signal sinstru: std_logic_vector (15 downto 0);
	signal sstate: std_logic_vector (1 downto 0);
begin
	vector: entity work.entry
	port map (
		clk => sclk,
		clr => sclr,
		valid => svalid,
		do_operation => sdo_op,
		switches => sswitches,
		save_instru => ssave,
		do_next_instru => sdonext,
		reset => sreset,
		instru => sinstru,
		state => sstate,
		clkout => sclkout
	);

	process
	begin
		wait;
	end process;
end ula_tb;

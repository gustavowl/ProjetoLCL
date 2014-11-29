library ieee;
use ieee.std_logic_1164.all;

entity ula_tb is
end ula_tb;

architecture ula_tb of ula_tb is
	signal sa, sb, sresul, sresto: std_logic_vector(15 downto 0);
	--signal sLerA, sclk, sld, sclr, serro, sContSubt: std_logic;
	signal sclk, scalcular, sconcl, serrout: std_logic;
	signal sstate: std_logic_vector (2 downto 0);
begin
	vector: entity work.rtl
	port map (
		a => sa,
		b => sb,
		resul => sresul,
		resto => sresto,
		clk => sclk,
		calcular => scalcular,
		concl => sconcl,
		errout => serrout,
		state => sstate
	);

	process
	begin
		wait;
	end process;
end ula_tb;

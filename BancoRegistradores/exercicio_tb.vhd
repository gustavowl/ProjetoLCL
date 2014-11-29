library ieee;
use ieee.std_logic_1164.all;

entity exercicio_tb is
end exercicio_tb;

architecture arq_tb of exercicio_tb is
	signal si, sq: std_logic_vector (15 downto 0);
	signal sregnum: std_logic_vector (2 downto 0);
	signal sclk, sld: std_logic;
begin
	vector: entity work.banco_reg
	port map (
		write => si,
		read => sq,
		regnum => sregnum,
		clk => sclk,
		ld => sld
	);

	process
	begin
--		sclk <= '1';
--		sld <= '0';
--		wait for 100 ns;
--
--		wait for 50 ns;

--		wait for 50 ns;
		wait;
	end process;
end arq_tb;

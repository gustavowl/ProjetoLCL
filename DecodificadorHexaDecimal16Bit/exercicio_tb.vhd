library ieee;
use ieee.std_logic_1164.all;

entity exercicio_tb is
end exercicio_tb;

architecture arq_tb of exercicio_tb is
	signal mentry: std_logic_vector(15 downto 0);
	signal md3: std_logic_vector(6 downto 0);
	signal md2: std_logic_vector(6 downto 0);
	signal md1: std_logic_vector(6 downto 0);
	signal md0: std_logic_vector(6 downto 0);
	
begin
	vector: entity work.decodhex16bit
	port map (
		entry => mentry,
		d3 => md3,
		d2 => md2,
		d1 => md1,
		d0 => md0
	);

	process
	begin
		mentry <= "1111111011011100";
		wait for 50 ns;

		mentry <= "1011101010011000";
		wait for 50 ns;

		mentry <= "0111011001010100";
		wait for 50 ns;

		mentry <= "0011001000010000";
		wait for 50 ns;
		wait;
	end process;
end arq_tb;

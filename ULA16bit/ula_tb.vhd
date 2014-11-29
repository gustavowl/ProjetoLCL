library ieee;
use ieee.std_logic_1164.all;

entity ula_tb is
end ula_tb;

architecture ula_tb of ula_tb is
	signal ma, mb, ms: std_logic_vector(15 downto 0);
	signal mw, mx, my, mz, mcout: std_logic;
begin
	vector: entity work.ula
	port map (
		a => ma,
		b => mb,
		s => ms,
		x => mx,
		y => my,
		z => mz,
		couterro => mcout
	);

	process
	begin
		ma <= "0000000000001010";
		mb <= "0000000000000010";
		mw <= '0';
		mx <= '0';
		my <= '0';
		mz <= '0';
		wait for 50 ns;

		mx <= '0';
		my <= '0';
		mz <= '1';
		wait for 50 ns;

		mx <= '0';
		my <= '1';
		mz <= '0';
		wait for 50 ns;

		mx <= '0';
		my <= '1';
		mz <= '1';
		wait for 50 ns;

		mx <= '1';
		my <= '0';
		mz <= '0';
		wait for 50 ns;

		mx <= '1';
		my <= '0';
		mz <= '1';
		wait for 50 ns;

		mx <= '1';
		my <= '1';
		mz <= '0';
		wait for 50 ns;

		mx <= '1';
		my <= '1';
		mz <= '1';
		wait for 50 ns;
		wait;
	end process;
end ula_tb;

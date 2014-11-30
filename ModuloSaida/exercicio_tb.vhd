library ieee;
use ieee.std_logic_1164.all;

entity exercicio_tb is
end exercicio_tb;

architecture arq_tb of exercicio_tb is
	signal sclk, sop_over, sreset, serro_ula: std_logic;
	signal sresult: std_logic_vector (15 downto 0);
	signal sled_op_over, sled_doing_op , sled_reset, sled_erro_ula: std_logic;
	signal sdisplays: std_logic_vector (15 downto 0);
begin
	vector: entity work.modsaida
	port map (
		clk => sclk,
		op_over => sop_over,
		reset => sreset,
		erro_ula => serro_ula,
		result => sresult,
		led_op_over => sled_op_over,
		led_doing_op => sled_doing_op,
		led_reset => sled_reset,
		led_erro_ula => sled_erro_ula,
		displays => sdisplays
	);

	process
	begin
		wait;
	end process;
end arq_tb;
